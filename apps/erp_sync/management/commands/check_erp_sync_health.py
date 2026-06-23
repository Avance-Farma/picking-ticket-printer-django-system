import logging

from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.orders.models import Order

logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = "Verifica saúde da sincronização ERP e lista pedidos com erro"

    def add_arguments(self, parser):
        parser.add_argument(
            "--pending-hours",
            type=int,
            default=24,
            help="Horas para considerar um PENDING como suspeito (padrão: 24)",
        )

    def handle(self, *args, **options):
        pending_hours = options["pending_hours"]

        # Verificar pedidos PENDING há muito tempo
        pending_orders = Order.get_pending_erp_sync_orders(hours=pending_hours)
        if pending_orders.exists():
            self.stdout.write(
                self.style.WARNING(
                    f"⚠️  {pending_orders.count()} pedido(s) PENDING há mais de {pending_hours}h:"
                )
            )
            for order in pending_orders:
                age = timezone.now() - order.updated_at
                self.stdout.write(
                    f"  - Pedido {order.order_number} (idade: {age.total_seconds() / 3600:.1f}h)"
                )
        else:
            self.stdout.write(
                self.style.SUCCESS(f"✓ Nenhum pedido PENDING há mais de {pending_hours}h")
            )

        # Verificar pedidos com ERROR
        error_orders = Order.get_error_erp_sync_orders()
        if error_orders.exists():
            self.stdout.write(
                self.style.ERROR(
                    f"❌ {error_orders.count()} pedido(s) com ERRO:"
                )
            )
            for order in error_orders[:10]:  # Mostrar apenas os 10 primeiros
                self.stdout.write(
                    f"  - Pedido {order.order_number}: {order.erp_volume_sync_error[:80]}"
                )
        else:
            self.stdout.write(self.style.SUCCESS("✓ Nenhum pedido com erro de sincronização ERP"))

        if not pending_orders.exists() and not error_orders.exists():
            self.stdout.write(
                self.style.SUCCESS("✓ Sincronização ERP saudável")
            )
