import json
from datetime import timedelta

from django.utils import timezone
from django.utils.translation import gettext_lazy as _

from apps.customers.models import Customer
from apps.orders.models import Order
from apps.products.models import Product


def dashboard_callback(request, context):
    """
    Callback function to populate the Unfold admin dashboard with KPIs
    and advanced metrics.
    """
    total_orders = Order.objects.count()
    pending_orders = Order.objects.filter(status="pending").count()
    total_products = Product.objects.count()
    total_customers = Customer.objects.count()

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

    # 1. Recent Orders (Last 5)
    recent_orders = Order.objects.select_related("customer").order_by(
        "-created_at"
    )[:5]
    context["recent_orders"] = recent_orders

    # 2. Progress Data (Today's Picking)
    today = timezone.now().date()
    today_orders = Order.objects.filter(created_at__date=today)
    total_today = today_orders.count()
    picked_today = today_orders.exclude(
        status=Order.StatusChoices.PENDING
    ).count()

    progress_percentage = 0
    if total_today > 0:
        progress_percentage = int((picked_today / total_today) * 100)

    context["progress_data"] = {
        "total": total_today,
        "picked": picked_today,
        "percentage": progress_percentage,
    }

    # 3. Alerts
    # Check if there are old pending orders (older than 2 days)
    two_days_ago = timezone.now() - timedelta(days=2)
    delayed_orders_count = Order.objects.filter(
        status=Order.StatusChoices.PENDING, created_at__lt=two_days_ago
    ).count()

    alerts = []
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

    context["alerts"] = alerts

    # 4. Chart Data (Orders per day, last 7 days)
    chart_data = []
    chart_labels = []
    for i in range(6, -1, -1):
        day = today - timedelta(days=i)
        count = Order.objects.filter(created_at__date=day).count()
        chart_labels.append(day.strftime("%d/%m"))
        chart_data.append(count)

    context["chart_data"] = json.dumps(chart_data)
    context["chart_labels"] = json.dumps(chart_labels)

    return context
