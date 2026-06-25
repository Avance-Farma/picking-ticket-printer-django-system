import csv

from django.contrib import admin, messages
from django.http import HttpResponse
from django.shortcuts import redirect
from django.utils.translation import gettext_lazy as _
from unfold.admin import ModelAdmin
from unfold.decorators import action, display

from apps.orders.models import Order, OrderItem


class OrderAdmin(ModelAdmin):
    actions_list = ["export_orders_action", "retry_erp_sync_action"]
    actions_detail = ["print_ticket_action"]

    list_display = (
        "picking",
        "order_number",
        "delivery__route",
        "customer__name",
        "import_source",
        "display_erp_sync_status",
        "status",
        "created_at",
        "updated_at",
    )
    search_fields = (
        "picking",
        "order_number",
        "delivery__route",
        "customer__name",
    )
    list_filter = (
        "status",
        "erp_volume_sync_status",
        "import_source",
        "created_at",
        "delivery__route",
        "picking",
    )
    readonly_fields = (
        "created_at",
        "updated_at",
        "confirmed_at",
        "shipped_at",
        "import_source",
        "erp_volume_sync_status",
        "erp_volume_sync_error",
    )

    @display(
        description="Sincronização ERP",
        label={
            Order.ERPSyncStatus.SENT: "success",
            Order.ERPSyncStatus.ERROR: "danger",
            Order.ERPSyncStatus.PENDING: "info",
        },
    )
    def display_erp_sync_status(self, obj):
        return obj.get_erp_volume_sync_status_display()

    @action(description=_("Sincronizar com ERP"))
    def retry_erp_sync_action(self, request, queryset):
        from apps.erp_sync.tasks import push_volume_to_erp_task

        count = 0
        for order in queryset:
            if order.total_volumes and order.erp_volume_sync_status in [
                Order.ERPSyncStatus.ERROR,
                Order.ERPSyncStatus.PENDING,
            ]:
                order.erp_volume_sync_status = Order.ERPSyncStatus.PENDING
                order.erp_volume_sync_error = ""
                order.save(update_fields=["erp_volume_sync_status", "erp_volume_sync_error"])
                push_volume_to_erp_task.delay(order.order_number, order.total_volumes)
                count += 1

        self.message_user(
            request,
            f"{count} pedido(s) reenfileirado(s) para sincronização com ERP.",
            messages.SUCCESS,
        )

    @action(description=_("Exportar Todos os Pedidos em CSV"))
    def export_orders_action(self, request):
        response = HttpResponse(content_type="text/csv")
        response["Content-Disposition"] = (
            'attachment; filename="pedidos_exportados.csv"'
        )

        writer = csv.writer(response)
        writer.writerow([
            "ID",
            "Picking",
            "Pedido",
            "Rota",
            "Cliente",
            "Status",
            "Data Criação",
        ])

        for order in Order.objects.all():
            writer.writerow([
                order.id,
                order.picking,
                order.order_number,
                order.order_route,
                order.customer.name if order.customer else "",
                order.get_status_display(),
                order.created_at.strftime("%d/%m/%Y %H:%M"),
            ])

        return response

    @action(description=_("Imprimir Etiqueta ZPL"))
    def print_ticket_action(self, request, object_id):
        messages.success(
            request, f"Ticket print requested for order {object_id}."
        )
        return redirect(
            request.META.get("HTTP_REFERER", "admin:orders_order_changelist")
        )


admin.site.register(Order, OrderAdmin)


class OrderItemAdmin(ModelAdmin):
    list_display = (
        "order",
        "product__description",
        "quantity",
        "created_at",
        "updated_at",
    )
    search_fields = (
        "order__order_number",
        "order__picking",
        "product__description",
        "product__sku_code",
    )
    list_filter = (
        "created_at",
        "updated_at",
    )
    readonly_fields = (
        "created_at",
        "updated_at",
    )


admin.site.register(OrderItem, OrderItemAdmin)
