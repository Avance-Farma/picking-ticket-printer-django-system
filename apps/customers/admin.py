from django.contrib import admin
from unfold.admin import ModelAdmin

from .models import Customer


# Register your models here.
class CustomerAdmin(ModelAdmin):
    list_display = (
        "code",
        "name",
        "id_number",
        "address",
        "created_at",
        "updated_at",
    )
    search_fields = (
        "code",
        "name",
        "id_number",
        "address__city",
        "address__street",
    )
    list_filter = (
        "created_at",
        "updated_at",
    )
    readonly_fields = ("created_at", "updated_at")


admin.site.register(Customer, CustomerAdmin)
