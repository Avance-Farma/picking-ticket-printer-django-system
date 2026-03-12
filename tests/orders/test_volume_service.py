import pytest

from apps.orders.models import Order
from apps.orders.services.volume_service import VolumeService
from tests.factories import OrderFactory, OrderItemFactory


@pytest.mark.unit
@pytest.mark.django_db
class TestVolumeService:
    def test_confirm_volumes_saves_to_order(self):
        # Arrange
        order = OrderFactory(status="pending")

        # Act
        VolumeService.confirm_volumes(order, total_volumes=3)

        # Assert
        order.refresh_from_db()
        assert order.total_volumes == 3
        assert order.status == "confirmed"

    def test_confirm_volumes_persists_for_reporting(self):
        """
        Garante que total_volumes persiste no banco após a confirmação
        e pode ser consultado para fins de relatório.
        """
        order = OrderFactory(status="pending")
        VolumeService.confirm_volumes(order, total_volumes=5)

        # Busca do banco diretamente
        saved = Order.objects.get(pk=order.pk)
        assert saved.total_volumes == 5
        assert saved.status == "confirmed"

    def test_process_and_print_generates_correct_zpl_count(self):
        # Arrange
        order = OrderFactory()
        OrderItemFactory(order=order, quantity=10)
        OrderItemFactory(order=order, quantity=5)
        total_volumes = 3

        # Act
        zpl_commands = VolumeService.process_and_print(order, total_volumes)

        # Assert
        assert len(zpl_commands) == 3

    def test_process_and_print_marks_in_progress(self):
        # Arrange
        order = OrderFactory(status="confirmed", total_volumes=2)

        # Act
        VolumeService.process_and_print(order, total_volumes=2)

        # Assert — server sets in_progress; shipped confirmed client-side
        order.refresh_from_db()
        assert order.status == "in_progress"
        assert order.total_volumes == 2

    def test_process_and_print_persists_total_volumes(self):
        """
        Após impressão, total_volumes deve persistir para consulta de
        relatório.
        """
        order = OrderFactory(status="confirmed")
        VolumeService.process_and_print(order, total_volumes=4)

        saved = Order.objects.get(pk=order.pk)
        assert saved.total_volumes == 4
        assert (
            saved.status == "in_progress"
        )  # shipped only after client confirmation

    def test_mark_shipped_sets_status(self):
        order = OrderFactory(status="in_progress")
        VolumeService.mark_shipped(order)
        order.refresh_from_db()
        assert order.status == "shipped"

    def test_mark_failed_sets_status(self):
        order = OrderFactory(status="in_progress")
        VolumeService.mark_failed(order)
        order.refresh_from_db()
        assert order.status == "failed"
