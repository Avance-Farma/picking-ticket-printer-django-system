import logging

from django.contrib import admin
from unfold.admin import ModelAdmin

from apps.addresses.models import Address

logger = logging.getLogger(__name__)


# Register your models here.
class AddressAdmin(ModelAdmin):
    list_display = (
        "street",
        "number",
        "complement",
        "district",
        "city",
        "state",
        "zip_code",
    )

    list_filter = (
        "state",
        "city",
        "district",
    )
    readonly_fields = ("created_at", "updated_at")

    search_fields = (
        "street",
        "number",
        "complement",
        "district",
        "city",
        "state",
        "zip_code",
    )

    ordering = (
        "state",
        "city",
        "district",
        "street",
        "number",
        "complement",
        "zip_code",
    )


try:
    admin.site.register(Address, AddressAdmin)
    logger.info("AddressAdmin registered successfully.")
except Exception as exc:
    logger.error("Failed to register AddressAdmin: %s", exc)
