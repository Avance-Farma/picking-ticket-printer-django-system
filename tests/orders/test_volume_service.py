from unittest.mock import patch

import pytest

from apps.orders.models import Order
from apps.orders.services.volume_service import VolumeService
from tests.factories import OrderFactory, OrderItemFactory


@pytest.mark.unit
@pytest.mark.django_db
class TestVolumeService:
    @pytest.fixture(autouse=True)
    def mock_erp_task(self):
        with patch("apps.erp_sync.tasks.push_volume_to_erp_task.delay") as mock:
            self.mock_erp_task = mock
            yield mock

    def test_confirm_volumes_saves_to_order(self):
        # Arrange
        order = OrderFactory(status="pending")

        # Act
        VolumeService.confirm_volumes(order, total_volumes=3)

        # Assert
        order.refresh_from_db()
        assert order.total_volumes == 3
        assert order.status == "confirmed"
        assert order.confirmed_at is not None

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
        assert order.shipped_at is not None

    def test_mark_failed_sets_status(self):
        order = OrderFactory(status="in_progress")
        VolumeService.mark_failed(order)
        order.refresh_from_db()
        assert order.status == "failed"

    def test_confirm_volumes_sets_confirmed_at(self):
        """RED: confirmed_at deve ser populado na confirmação."""
        order = OrderFactory(status="pending")
        assert order.confirmed_at is None

        VolumeService.confirm_volumes(order, total_volumes=2)
        order.refresh_from_db()

        assert order.confirmed_at is not None

    def test_reconfirm_updates_confirmed_at(self):
        """RED: Re-confirmação deve atualizar confirmed_at."""
        order = OrderFactory(status="pending")
        VolumeService.confirm_volumes(order, total_volumes=2)
        order.refresh_from_db()
        first_confirmed = order.confirmed_at

        VolumeService.confirm_volumes(order, total_volumes=4)
        order.refresh_from_db()

        assert order.confirmed_at >= first_confirmed
        assert order.total_volumes == 4

    def test_mark_shipped_sets_shipped_at(self):
        """RED: shipped_at deve ser populado na expedição."""
        order = OrderFactory(status="in_progress")
        assert order.shipped_at is None

        VolumeService.mark_shipped(order)
        order.refresh_from_db()

        assert order.shipped_at is not None

    def test_mark_failed_does_not_set_shipped_at(self):
        """RED: Falha não gera shipped_at."""
        order = OrderFactory(status="in_progress")
        VolumeService.mark_failed(order)
        order.refresh_from_db()

        assert order.shipped_at is None

    def test_process_and_print_sets_confirmed_at_if_missing(self):
        """RED: Se confirmed_at é None, process_and_print preenche."""
        order = OrderFactory(status="pending", confirmed_at=None)
        OrderItemFactory(order=order)

        VolumeService.process_and_print(order, total_volumes=1)
        order.refresh_from_db()

        assert order.confirmed_at is not None

    def test_process_and_print_preserves_existing_confirmed_at(self):
        """RED: Se confirmed_at já existe, process_and_print NÃO sobrescreve."""
        import datetime

        from django.utils import timezone as tz

        original_time = tz.now() - datetime.timedelta(hours=1)
        order = OrderFactory(status="confirmed", confirmed_at=original_time)
        OrderItemFactory(order=order)

        VolumeService.process_and_print(order, total_volumes=1)
        order.refresh_from_db()

        assert order.confirmed_at == original_time

    def test_confirm_volumes_dispatches_celery_task(self):
        # Arrange
        order = OrderFactory(status="pending")
        
        # Act
        VolumeService.confirm_volumes(order, total_volumes=3)
        
        # Assert
        self.mock_erp_task.assert_called_once_with(order.order_number, 3)
        order.refresh_from_db()
        assert order.status == "confirmed"

    def test_mark_shipped_does_not_dispatch_celery_task(self):
        """[RED] mark_shipped não deve mais enviar push ao ERP (duplicado)."""
        # Arrange
        order = OrderFactory(status="in_progress", total_volumes=5)
        
        # Act
        VolumeService.mark_shipped(order)
        
        # Assert
        self.mock_erp_task.assert_not_called()
        order.refresh_from_db()
        assert order.status == "shipped"

    def test_confirm_volumes_succeeds_even_if_erp_fails_async(self):
        """O sucesso local não depende mais do ERP (assíncrono)."""
        order = OrderFactory(status="pending")
        
        # Mesmo que o dispatch da task falhasse (raro), o pedido deve ser confirmado
        self.mock_erp_task.side_effect = Exception("Celery down")
        
        VolumeService.confirm_volumes(order, total_volumes=2)
        
        order.refresh_from_db()
        assert order.status == "confirmed"
        assert order.total_volumes == 2

    def test_confirm_volumes_returns_dict(self):
        """RED: confirm_volumes deve retornar um dict com erp_warning."""
        order = OrderFactory(status="pending")
        result = VolumeService.confirm_volumes(order, 3)
        assert isinstance(result, dict)
        assert "erp_warning" in result
        assert result["erp_warning"] is None

    def test_confirm_volumes_returns_warning_on_delay_failure(self):
        """RED: Retorna aviso se o enfileiramento da task falhar."""
        order = OrderFactory(status="pending")
        self.mock_erp_task.side_effect = Exception("Redis down")
        
        result = VolumeService.confirm_volumes(order, 3)
        
        assert result["erp_warning"] is not None
        order.refresh_from_db()
        assert order.status == "confirmed"  # Operação local mantida

    def test_mark_shipped_returns_dict(self):
        """RED: mark_shipped deve retornar um dict com erp_warning."""
        order = OrderFactory(status="in_progress", total_volumes=2)
        result = VolumeService.mark_shipped(order)
        assert isinstance(result, dict)
        assert "erp_warning" in result
        assert result["erp_warning"] is None

    def test_mark_shipped_no_longer_returns_warning_on_delay_failure(self):
        """mark_shipped não chama mais o ERP, então não retorna aviso de delay."""
        order = OrderFactory(status="in_progress", total_volumes=2)
        # Mesmo que a task falhasse se fosse chamada, mark_shipped não a chama
        self.mock_erp_task.side_effect = Exception("Should not be called")
        
        result = VolumeService.mark_shipped(order)
        
        assert result["erp_warning"] is None
        order.refresh_from_db()
        assert order.status == "shipped"
