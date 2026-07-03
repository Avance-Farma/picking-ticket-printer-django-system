import logging

from django.contrib import admin
from unfold.admin import ModelAdmin

from .models import Delivery

logger = logging.getLogger(__name__)


# Register your models here.
class DeliveryAdmin(ModelAdmin):
    list_display = (
        "route",
        "manifest",
        "carrier",
        "vehicle",
        "driver",
        "helper",
        "created_at",
        "updated_at",
    )
    list_filter = (
        "route",
        "manifest",
        "carrier",
        "vehicle",
        "driver",
        "helper",
        "created_at",
        "updated_at",
    )
    search_fields = (
        "route",
        "manifest",
        "carrier",
        "vehicle",
        "driver",
        "helper",
    )
    ordering = (
        "-created_at",
    )
    readonly_fields = ("created_at", "updated_at")


try:
    admin.site.register(Delivery, DeliveryAdmin)
    logger.info("DeliveryAdmin registered successfully.")
except Exception as exc:
    logger.error("Failed to register DeliveryAdmin: %s", exc)
