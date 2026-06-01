from unittest.mock import MagicMock, patch

import pytest

from apps.erp_sync.services.erp_importer import ERPOrderImporter
from apps.erp_sync.services.volume_push_service import ERPVolumePushService
from apps.orders.models import Order
from apps.orders.services.volume_service import VolumeService
from tests.factories import OrderFactory


@pytest.mark.django_db
class TestVolumeSyncRegression:
    
    @pytest.fixture(autouse=True)
    def mock_erp_task(self):
        with patch("apps.erp_sync.tasks.push_volume_to_erp_task.delay") as mock:
            self.mock_erp_task = mock
            yield mock

    @pytest.fixture(autouse=True)
    def mock_requests_put(self):
        with patch("requests.put") as mock:
            mock.return_value = MagicMock(status_code=200)
            self.mock_requests_put = mock
            yield mock

    @pytest.fixture(autouse=True)
    def mock_auth(self):
        with patch("apps.erp_sync.services.auth_service.ERPAuthService.get_valid_token", return_value="fake-token"):
            yield

    def test_scenario_1_picking_flow_sends_correct_volume_to_erp(self):
        """Cenário 1: Fluxo completo do picking envia volume correto para o ERP"""
        order = OrderFactory(order_number="12345", total_volumes=None, status="pending")
        
        # Operador confirma 4 volumes
        VolumeService.confirm_volumes(order, 4)
        
        # Asserta: order atualizado localmente
        order.refresh_from_db()
        assert order.total_volumes == 4
        assert order.status == Order.StatusChoices.CONFIRMED
        
        # Asserta: task enfileirada corretamente (order_number como string para a task)
        self.mock_erp_task.assert_called_once_with("12345", 4)

    def test_scenario_2_mark_shipped_does_not_trigger_second_push(self):
        """Cenário 2: mark_shipped NÃO dispara segundo push ao ERP"""
        order = OrderFactory(order_number="12345", total_volumes=4, status="in_progress")
        
        # Operador marca como expedido (impressão concluída)
        VolumeService.mark_shipped(order)
        
        # Asserta: task NÃO foi chamada
        self.mock_erp_task.assert_not_called()
        
        order.refresh_from_db()
        assert order.status == Order.StatusChoices.SHIPPED

    def test_scenario_3_erp_resync_does_not_alter_confirmed_volumes(self):
        """Cenário 3: Re-sincronização do ERP não altera volumes já confirmados"""
        order = OrderFactory(order_number="999", picking="P-999", total_volumes=7, status="confirmed")
        
        importer = ERPOrderImporter()
        order_json = {
            "orderId": 999,
            "preNoteId": "P-999",
            "orderPackages": 2,  # ERP manda valor diferente
            "orderStatus": "Faturado",
            "clientId": "1",
            "clientName": "Test",
        }
        
        importer.save_order(order_json)
        
        order.refresh_from_db()
        assert order.total_volumes == 7  # Protegido
        assert order.situation == "Faturado" # Outros campos atualizam

    def test_scenario_4_push_volume_sends_order_id_as_integer(self):
        """Cenário 4: push_volume envia orderId como integer no JSON"""
        ERPVolumePushService.push_volume("88001", 3)
        
        # Asserta: requests.put chamado com payload correto
        self.mock_requests_put.assert_called_once()
        args, kwargs = self.mock_requests_put.call_args
        sent_payload = kwargs["json"]
        
        assert sent_payload == [{"orderId": 88001, "volume": 3}]
        assert isinstance(sent_payload[0]["orderId"], int)
