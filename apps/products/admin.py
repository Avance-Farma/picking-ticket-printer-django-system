import csv

from django.contrib import admin
from django.http import HttpResponse
from django.utils.translation import gettext_lazy as _
from unfold.admin import ModelAdmin
from unfold.decorators import action

from apps.products import models


# Register your models here.
class ProductAdmin(ModelAdmin):
    actions_list = ["export_products_action"]

    list_display = (
        "sku_code",
        "description",
        "price",
        "created_at",
        "updated_at",
    )
    search_fields = ("sku_code", "description")
    list_filter = ("created_at", "updated_at")

    @action(description=_("Exportar Todos os Produtos em CSV"))
    def export_products_action(self, request):
        response = HttpResponse(content_type="text/csv")
        response["Content-Disposition"] = (
            'attachment; filename="produtos_exportados.csv"'
        )

        writer = csv.writer(response)
        writer.writerow([
            "ID",
            "SKU",
            "Descrição",
            "Preço",
            "Data Criação",
            "Última Atualização",
        ])

        for product in models.Product.objects.all():
            writer.writerow([
                product.id,
                product.sku_code,
                product.description,
                f"R$ {product.price:.2f}" if product.price else "",
                product.created_at.strftime("%d/%m/%Y %H:%M"),
                product.updated_at.strftime("%d/%m/%Y %H:%M"),
            ])

        return response


admin.site.register(models.Product, ProductAdmin)
