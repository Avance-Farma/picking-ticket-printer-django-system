import json
import logging
from datetime import timedelta

from django.db import DatabaseError
from django.utils import timezone
from django.utils.translation import gettext_lazy as _

from apps.customers.models import Customer
from apps.orders.models import Order
from apps.products.models import Product

logger = logging.getLogger(__name__)


def dashboard_callback(request, context):
    """
    Callback function to populate the Unfold admin dashboard with KPIs
    and advanced metrics.

    Each database query group is wrapped in its own try-except block so
    that a transient database error degrades the dashboard gracefully
    instead of raising a 500.  When an error occurs it is logged and an
    alert is injected so admins know something is wrong.
    """
    db_error_occurred = False

    # ── 1. KPI counts ────────────────────────────────────────────────────────
    try:
        total_orders = Order.objects.count()
        pending_orders = Order.objects.filter(status="pending").count()
        total_products = Product.objects.count()
        total_customers = Customer.objects.count()
    except DatabaseError as exc:
        logger.error("dashboard_callback: failed to fetch KPI counts: %s", exc)
        db_error_occurred = True
        total_orders = 0
        pending_orders = 0
        total_products = 0
        total_customers = 0

    context.update({
        "kpi": [
            {
                "title": _("Total de Pedidos"),
                "metric": total_orders,
                "footer": _("Histórico completo"),
            },
            {
                "title": _("Pedidos Pendentes"),
                "metric": pending_orders,
                "footer": _("Aguardando separação"),
            },
            {
                "title": _("Produtos"),
                "metric": total_products,
                "footer": _("Itens no catálogo"),
            },
            {
                "title": _("Clientes"),
                "metric": total_customers,
                "footer": _("Cadastros totais"),
            },
        ],
    })

    # ── 2. Recent Orders (Last 5) ─────────────────────────────────────────────
    try:
        recent_orders = Order.objects.select_related("customer").order_by(
            "-created_at"
        )[:5]
        # Force evaluation inside the try block so lazy QuerySet errors surface here
        context["recent_orders"] = list(recent_orders)
    except DatabaseError as exc:
        logger.error("dashboard_callback: failed to fetch recent orders: %s", exc)
        db_error_occurred = True
        context["recent_orders"] = []

    # ── 3. Progress Data (Today's Picking) ───────────────────────────────────
    today = timezone.now().date()
    try:
        today_orders = Order.objects.filter(created_at__date=today)
        total_today = today_orders.count()
        picked_today = today_orders.exclude(
            status=Order.StatusChoices.PENDING
        ).count()

        progress_percentage = 0
        if total_today > 0:
            progress_percentage = int((picked_today / total_today) * 100)
    except DatabaseError as exc:
        logger.error(
            "dashboard_callback: failed to fetch today's picking data: %s", exc
        )
        db_error_occurred = True
        total_today = 0
        picked_today = 0
        progress_percentage = 0

    context["progress_data"] = {
        "total": total_today,
        "picked": picked_today,
        "percentage": progress_percentage,
    }

    # ── 4. Alerts ─────────────────────────────────────────────────────────────
    # Check if there are old pending orders (older than 2 days)
    alerts = []

    try:
        two_days_ago = timezone.now() - timedelta(days=2)
        delayed_orders_count = Order.objects.filter(
            status=Order.StatusChoices.PENDING, created_at__lt=two_days_ago
        ).count()
    except DatabaseError as exc:
        logger.error(
            "dashboard_callback: failed to fetch delayed orders count: %s", exc
        )
        db_error_occurred = True
        delayed_orders_count = 0

    if delayed_orders_count > 0:
        alerts.append({
            "type": "warning",
            "message": (
                f"Atenção: Existem {delayed_orders_count} pedidos "
                "atrasados (aguardando há mais de 2 dias)!"
            ),
        })
    elif pending_orders > 50:
        alerts.append({
            "type": "info",
            "message": (
                f"Fila cheia: {pending_orders} pedidos aguardam "
                "separação no momento."
            ),
        })
    else:
        alerts.append({
            "type": "success",
            "message": "Tudo em dia! A fila de picking está controlada.",
        })

    # Prepend a database error notice so it is the first thing admins see
    if db_error_occurred:
        alerts.insert(0, {
            "type": "warning",
            "message": (
                "Atenção: Não foi possível conectar ao banco de dados. "
                "Alguns dados do painel podem estar incompletos ou zerados. "
                "Verifique a conexão com o PostgreSQL e consulte os logs para mais detalhes."
            ),
        })

    context["alerts"] = alerts

    # ── 5. Chart Data (Orders per day, last 7 days) ───────────────────────────
    try:
        chart_data = []
        chart_labels = []
        for i in range(6, -1, -1):
            day = today - timedelta(days=i)
            count = Order.objects.filter(created_at__date=day).count()
            chart_labels.append(day.strftime("%d/%m"))
            chart_data.append(count)
    except DatabaseError as exc:
        logger.error(
            "dashboard_callback: failed to fetch chart data: %s", exc
        )
        db_error_occurred = True
        chart_data = [0] * 7
        chart_labels = [
            (today - timedelta(days=i)).strftime("%d/%m")
            for i in range(6, -1, -1)
        ]

    context["chart_data"] = json.dumps(chart_data)
    context["chart_labels"] = json.dumps(chart_labels)

    return context
