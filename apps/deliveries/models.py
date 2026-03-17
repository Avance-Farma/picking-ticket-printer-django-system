from django.db import models


class Delivery(models.Model):
    carrier = models.CharField(
        max_length=255, verbose_name="Transportadora", blank=True
    )
    route = models.CharField(max_length=255, verbose_name="Rota", blank=True)
    manifest = models.CharField(
        max_length=255, verbose_name="Romaneio", blank=True
    )
    vehicle = models.CharField(
        max_length=255, verbose_name="Veículo", blank=True
    )
    driver = models.CharField(
        max_length=255, verbose_name="Motorista", blank=True
    )
    helper = models.CharField(
        max_length=255, verbose_name="Ajudante", blank=True
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "deliveries"
        verbose_name = "Entrega (Transporte)"
        verbose_name_plural = "Entregas (Transporte)"

    def __str__(self):
        return f"{self.route}"
