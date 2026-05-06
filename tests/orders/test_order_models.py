import pytest
from tests.factories import OrderFactory

@pytest.mark.django_db
class TestOrderERPSyncFields:
    def test_order_has_erp_sync_fields(self):
        """Valida que o modelo Order possui os campos necessários para o push de volume."""
        # Arrange
        order = OrderFactory()

        # Act & Assert
        assert hasattr(order, "erp_volume_sync_status")
        assert hasattr(order, "erp_volume_sync_error")
        
    def test_order_default_sync_status_is_pending(self):
        """Valida que o status padrão de sincronização é 'pending'."""
        order = OrderFactory()
        assert order.erp_volume_sync_status == "pending"
