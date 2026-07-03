import logging

from django.contrib import admin
from unfold.admin import ModelAdmin

from apps.erp_sync.models import ERPSyncLog

logger = logging.getLogger(__name__)


class ERPSyncLogAdmin(ModelAdmin):
    list_display = (
        "sync_date",
        "branch_ids",
        "status",
        "orders_fetched",
        "orders_created",
        "orders_updated",
        "orders_errors",
        "last_checked_at",
        "created_at",
        "finished_at",
    )
    list_filter = ("status", "sync_date")
    readonly_fields = (
        "sync_date",
        "branch_ids",
        "status",
        "orders_fetched",
        "orders_created",
        "orders_updated",
        "orders_errors",
        "error_detail",
        "last_checked_at",
        "created_at",
        "finished_at",
    )
    ordering = ("-created_at",)

    def has_add_permission(self, request):
        return False  # Logs são gerados automaticamente

    def has_change_permission(self, request, obj=None):
        return False  # Logs são read-only


try:
    admin.site.register(ERPSyncLog, ERPSyncLogAdmin)
    logger.info("ERPSyncLogAdmin registered successfully.")
except Exception as exc:
    logger.error("Failed to register ERPSyncLogAdmin: %s", exc)
