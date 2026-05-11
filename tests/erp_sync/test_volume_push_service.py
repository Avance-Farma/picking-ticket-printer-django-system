import pytest
import requests
from unittest.mock import patch, MagicMock

from apps.erp_sync.services.volume_push_service import ERPVolumePushService
from apps.erp_sync.exceptions import ERPSyncError


@pytest.fixture
def mock_auth_token():
    with patch("apps.erp_sync.services.auth_service.ERPAuthService.get_valid_token", return_value="fake-token") as mock:
        yield mock


@pytest.fixture
def mock_requests_put():
    with patch("requests.put") as mock:
        yield mock


class TestERPVolumePushService:

    def test_push_volume_success(self, mock_auth_token, mock_requests_put, settings):
        """Testa se envia os dados corretamente para o endpoint do ERP e com sucesso"""
        settings.ERP_API_BASE_URL = "http://fake-erp.com"
        
        mock_resp = MagicMock()
        mock_resp.status_code = 200
        mock_requests_put.return_value = mock_resp

        ERPVolumePushService.push_volume(order_number="123456", volume=5)

        mock_requests_put.assert_called_once_with(
            "http://fake-erp.com/api/Avance/UpdateOrderVolume",
            json=[{"orderId": 123456, "volume": 5}],
            headers={
                "accept": "*/*",
                "Authorization": "Bearer fake-token",
            },
            timeout=30,
        )

    def test_push_volume_payload_uses_integer_order_id(self, mock_auth_token, mock_requests_put, settings):
        """[RED] Garante que o orderId seja enviado como integer, não string"""
        settings.ERP_API_BASE_URL = "http://fake-erp.com"
        mock_requests_put.return_value = MagicMock(status_code=200)

        ERPVolumePushService.push_volume(order_number="12345", volume=3)

        # O teste deve falhar se o código atual enviar "12345"
        mock_requests_put.assert_called_once()
        args, kwargs = mock_requests_put.call_args
        sent_payload = kwargs["json"]
        assert isinstance(sent_payload[0]["orderId"], int), f"orderId deveria ser int, veio {type(sent_payload[0]['orderId'])}"
        assert sent_payload[0]["orderId"] == 12345

    def test_push_volume_401_retry_success(self, mock_auth_token, mock_requests_put, settings):
        """Testa revalidação de token em caso de 401 Unauthorized"""
        settings.ERP_API_BASE_URL = "http://fake-erp.com"
        
        # 1st response: 401
        resp_401 = MagicMock()
        resp_401.status_code = 401

        # 2nd response: 200
        resp_200 = MagicMock()
        resp_200.status_code = 200

        mock_requests_put.side_effect = [resp_401, resp_200]

        with patch("apps.erp_sync.services.auth_service.ERPAuthService.invalidate_cache") as mock_invalidate:
            ERPVolumePushService.push_volume(order_number="999", volume=10)
            mock_invalidate.assert_called_once()
            
        assert mock_requests_put.call_count == 2
        assert mock_auth_token.call_count == 2

    def test_push_volume_network_error(self, mock_auth_token, mock_requests_put, settings):
        """Testa se levanta a ERPSyncError customizada em caso de erro de rede"""
        settings.ERP_API_BASE_URL = "http://fake-erp.com"
        
        mock_requests_put.side_effect = requests.exceptions.ConnectionError("Connection timeout")

        with pytest.raises(ERPSyncError) as exc:
            ERPVolumePushService.push_volume(order_number="111", volume=2)

        assert "Falha de conexão com o ERP" in str(exc.value)

    def test_push_volume_http_error(self, mock_auth_token, mock_requests_put, settings):
        """Testa erro 400 Bad Request, deve lançar ERPSyncError com a mensagem formatada"""
        settings.ERP_API_BASE_URL = "http://fake-erp.com"
        
        mock_resp = MagicMock()
        mock_resp.status_code = 400
        mock_resp.raise_for_status.side_effect = requests.HTTPError("400 Client Error")
        mock_requests_put.return_value = mock_resp

        with pytest.raises(ERPSyncError) as exc:
            ERPVolumePushService.push_volume(order_number="222", volume=1)

        assert "Erro ao sincronizar volume" in str(exc.value)

    def test_push_volume_invalid_order_number(self, mock_auth_token, mock_requests_put, settings):
        """Testa se levanta ERPSyncError caso o order_number não seja conversível para int"""
        with pytest.raises(ERPSyncError) as exc:
            ERPVolumePushService.push_volume(order_number="ABC-123", volume=1)

        assert "order_number inválido para conversão" in str(exc.value)
