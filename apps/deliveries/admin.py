from django.contrib import admin
from unfold.admin import ModelAdmin

from .models import Delivery


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


admin.site.register(Delivery, DeliveryAdmin)
