from django.core.paginator import Paginator
from django.db.models import Q
from django.shortcuts import render
from django.views import View

from apps.orders.models import Order

PAGE_SIZE = 25

VALID_SORT_FIELDS = {
    "picking": "picking",
    "order_number": "order_number",
    "customer": "customer__name",
    "status": "status",
    "created_at": "created_at",
}


class OrdersListView(View):
    """
    View principal da tela de expedição de pickings.
    Suporta busca, filtro por status, ordenação por coluna e paginação.
    """

    template_name = "index.html"

    def get(self, request, *args, **kwargs):
        S = Order.StatusChoices

        search_query = request.GET.get("q", "").strip()
        status_filter = request.GET.get("status", "").strip()
        sort_field = request.GET.get("sort", "created_at").strip()
        sort_dir = request.GET.get("dir", "desc").strip()
        page_number = request.GET.get("page", 1)

        # Mapeamento seguro de campos de ordenação
        db_sort_field = VALID_SORT_FIELDS.get(sort_field, "created_at")
        order_prefix = "" if sort_dir == "asc" else "-"

        queryset = Order.objects.select_related(
            "customer", "customer__address"
        ).order_by(f"{order_prefix}{db_sort_field}")

        if search_query:
            queryset = queryset.filter(
                Q(picking__icontains=search_query)
                | Q(order_number__icontains=search_query)
                | Q(customer__name__icontains=search_query)
                | Q(customer__id_number__icontains=search_query)
            )

        valid_statuses = [c.value for c in S]
        if status_filter and status_filter in valid_statuses:
            queryset = queryset.filter(status=status_filter)
        elif not search_query and not status_filter:
            # Padrão: ocultar apenas os já expedidos
            queryset = queryset.exclude(status=S.SHIPPED)

        # Paginação
        paginator = Paginator(queryset, PAGE_SIZE)
        page_obj = paginator.get_page(page_number)

        # Contadores para o header
        total_pending = Order.objects.filter(status=S.PENDING).count()
        total_confirmed = Order.objects.filter(status=S.CONFIRMED).count()

        context = {
            "orders": page_obj,  # iterable paginado
            "page_obj": page_obj,
            "paginator": paginator,
            "search_query": search_query,
            "total_pending": total_pending,
            "total_confirmed": total_confirmed,
            "status_filter": status_filter,
            "sort_field": sort_field,
            "sort_dir": sort_dir,
            # Pills de filtro por status
            # (label, value, active_css, inactive_css)
            "status_pills": [
                (
                    "Todos",
                    "",
                    "bg-slate-800 text-white border-slate-800",
                    "bg-white text-slate-600 border-slate-300 "
                    "hover:border-slate-500",
                ),
                (
                    S.PENDING.label,
                    S.PENDING.value,
                    "bg-amber-500 text-white border-amber-500",
                    "bg-white text-amber-700 border-amber-300 "
                    "hover:border-amber-500",
                ),
                (
                    S.CONFIRMED.label,
                    S.CONFIRMED.value,
                    "bg-green-600 text-white border-green-600",
                    "bg-white text-green-700 border-green-300 "
                    "hover:border-green-500",
                ),
                (
                    S.IN_PROGRESS.label,
                    S.IN_PROGRESS.value,
                    "bg-purple-600 text-white border-purple-600",
                    "bg-white text-purple-700 border-purple-300 "
                    "hover:border-purple-500",
                ),
                (
                    S.SHIPPED.label,
                    S.SHIPPED.value,
                    "bg-blue-600 text-white border-blue-600",
                    "bg-white text-blue-700 border-blue-300 "
                    "hover:border-blue-500",
                ),
                (
                    S.FAILED.label,
                    S.FAILED.value,
                    "bg-red-600 text-white border-red-600",
                    "bg-white text-red-700 border-red-300 "
                    "hover:border-red-500",
                ),
            ],
            # Colunas ordenáveis da tabela
            "sortable_columns": [
                ("PICKING", "picking"),
                ("PEDIDO", "order_number"),
                ("CLIENTE", "customer"),
                ("STATUS", "status"),
            ],
            # Valores de status para comparação no template
            "STATUS_PENDING": S.PENDING.value,
            "STATUS_CONFIRMED": S.CONFIRMED.value,
            "STATUS_SHIPPED": S.SHIPPED.value,
            "STATUS_IN_PROGRESS": S.IN_PROGRESS.value,
            "STATUS_FAILED": S.FAILED.value,
        }
        return render(request, self.template_name, context)
