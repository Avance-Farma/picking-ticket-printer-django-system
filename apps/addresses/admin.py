from django.contrib import admin
from unfold.admin import ModelAdmin

from apps.addresses.models import Address


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


admin.site.register(Address, AddressAdmin)
