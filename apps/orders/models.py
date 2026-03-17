from django.db import models

from apps.customers.models import Customer
from apps.products.models import Product


class Order(models.Model):
    class StatusChoices(models.TextChoices):
        PENDING = "pending", "Aguardando"
        CONFIRMED = "confirmed", "Confirmado"
        IN_PROGRESS = "in_progress", "Em Progresso"
        SHIPPED = "shipped", "Expedido"
        FAILED = "failed", "Falha"

    picking = models.CharField(max_length=20)
    order_number = models.CharField(max_length=30)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    delivery = models.ForeignKey(
        "deliveries.Delivery", on_delete=models.SET_NULL, null=True, blank=True
    )

    @property
    def order_route(self):
        return self.delivery.route if self.delivery else ""

    typing_date = models.DateTimeField(
        verbose_name="Digitação", null=True, blank=True
    )
    release_date = models.DateTimeField(
        verbose_name="Liberação", null=True, blank=True
    )
    pre_invoice_date = models.DateTimeField(
        verbose_name="Pré-Nota", null=True, blank=True
    )
    invoice_number = models.CharField(
        max_length=50, verbose_name="NF", blank=True
    )
    scheduled_date = models.CharField(
        max_length=50, verbose_name="Data Programada", blank=True
    )
    condition = models.CharField(
        max_length=100, verbose_name="Condição", blank=True
    )
    operation = models.CharField(
        max_length=100, verbose_name="Operação", blank=True
    )
    origin = models.CharField(
        max_length=100, verbose_name="Origem", blank=True
    )
    typist = models.CharField(
        max_length=100, verbose_name="Digitador", blank=True
    )
    salesperson = models.CharField(
        max_length=100, verbose_name="Vendedor", blank=True
    )
    releaser = models.CharField(
        max_length=100, verbose_name="Liberador", blank=True
    )
    status = models.CharField(
        max_length=20,
        verbose_name="Status",
        choices=StatusChoices.choices,
        default=StatusChoices.PENDING,
    )

    situation = models.CharField(
        max_length=100, verbose_name="Situação", blank=True
    )
    pending_payment = models.CharField(
        max_length=100, verbose_name="Pendência", blank=True
    )
    net_weight = models.DecimalField(
        max_digits=15,
        decimal_places=4,
        verbose_name="Peso Líquido",
        null=True,
        blank=True,
    )
    total_volumes = models.PositiveIntegerField(
        null=True,
        blank=True,
        default=None,
        verbose_name="Total de Volumes",
        help_text=(
            "Quantidade de volumes confirmada para "
            "impressão (persiste para relatórios)."
        ),
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "orders"
        unique_together = [("picking", "order_number")]

    def __str__(self):
        return f"{self.order_number}"

    @property
    def total_price(self):
        return sum(
            item.quantity * item.product.price for item in self.items.all()
        )


class OrderItem(models.Model):
    order = models.ForeignKey(
        Order, on_delete=models.CASCADE, related_name="items"
    )
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.DecimalField(max_digits=18, decimal_places=3, default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "order_items"
        unique_together = [("order", "product")]

    def __str__(self):
        return f"{self.product} ({self.quantity})"
