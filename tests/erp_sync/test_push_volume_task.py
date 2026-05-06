import pytest
from unittest.mock import patch, MagicMock
from apps.erp_sync.tasks import _push_volume_logic
from apps.erp_sync.exceptions import ERPSyncError
from tests.factories import OrderFactory

@pytest.mark.django_db
class TestPushVolumeTask:
    @patch("apps.erp_sync.services.volume_push_service.ERPVolumePushService.push_volume")
    def test_push_volume_success_updates_order_status(self, mock_push):
        """Valida que o status da ordem é atualizado para 'sent' após sucesso."""
        # Arrange
        order = OrderFactory(order_number="ORD-123", erp_volume_sync_status="pending")
        mock_push.return_value = None
        mock_task = MagicMock()

        # Act
        _push_volume_logic(mock_task, order.order_number, 10)

        # Assert
        order.refresh_from_db()
        assert order.erp_volume_sync_status == "sent"
        assert order.erp_volume_sync_error == ""

    @patch("apps.erp_sync.services.volume_push_service.ERPVolumePushService.push_volume")
    def test_push_volume_failure_updates_order_status_after_max_retries(self, mock_push):
        """Valida que o status da ordem é atualizado para 'error' após falha definitiva."""
        # Arrange
        order = OrderFactory(order_number="ORD-456", erp_volume_sync_status="pending")
        mock_push.side_effect = ERPSyncError("Erro de API")

        # Mock da instância da task
        mock_task = MagicMock()
        mock_task.request.retries = 3
        mock_task.max_retries = 3

        # Act
        _push_volume_logic(mock_task, "ORD-456", 5)

        # Assert
        order.refresh_from_db()
        assert order.erp_volume_sync_status == "error"
        assert "Erro de API" in order.erp_volume_sync_error
