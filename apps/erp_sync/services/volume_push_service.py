"""
ERPVolumePushService — envia atualizações de volume para a API do ERP.

Endpoint: PUT /api/Avance/UpdateVolumeRequest
Payload:
  - orderId : integer (Número do pedido — convertido de string para int)
  - volume  : integer (Quantidade total de volumes)
Headers:
  - Authorization : Bearer {token}
  - accept        : text/plain
"""

import logging
import requests
from django.conf import settings
from apps.erp_sync.services.auth_service import ERPAuthService
from apps.erp_sync.exceptions import ERPSyncError

logger = logging.getLogger(__name__)


class ERPVolumePushService:
    """
    Serviço stateless responsável por enviar a atualização de volumes
    ativamente (Push) para a API do ERP quando um pedido for impresso.
    """

    @classmethod
    def _base_url(cls) -> str:
        return getattr(settings, "ERP_API_BASE_URL", "http://187.117.44.93:55050")

    @classmethod
    def push_volume(cls, order_number: str, volume: int) -> None:
        """
        Envia a quantidade de volumes para o ERP via PUT.
        Endpoint: PUT /api/Avance/UpdateOrderVolume
        """
        url = f"{cls._base_url()}/api/Avance/UpdateOrderVolume"
        
        try:
            order_id_int = int(order_number)
        except (ValueError, TypeError) as exc:
            logger.error("ERP Push: order_number inválido para conversão: %r", order_number)
            raise ERPSyncError(f"order_number inválido para conversão: {order_number!r}") from exc

        payload = [{"orderId": order_id_int, "volume": volume}]

        token = ERPAuthService.get_valid_token()
        headers = {
            "accept": "*/*",
            "Authorization": f"Bearer {token}",
        }

        logger.info("ERP Push: Enviando volume=%d para pedido=%s...", volume, order_number)

        try:
            resp = requests.put(url, json=payload, headers=headers, timeout=30)

            if resp.status_code == 401:
                logger.warning("ERP Push: 401 Unauthorized — invalidando cache e retentando login.")
                ERPAuthService.invalidate_cache()
                token = ERPAuthService.get_valid_token()
                headers["Authorization"] = f"Bearer {token}"
                resp = requests.put(url, json=payload, headers=headers, timeout=30)

            resp.raise_for_status()
            logger.info("ERP Push: Volume do pedido %s atualizado com sucesso no ERP.", order_number)

        except requests.exceptions.RequestException as exc:
            logger.error("ERP Push: falha ao enviar volume para o pedido %s: %s", order_number, exc)
            if isinstance(exc, requests.exceptions.ConnectionError) or isinstance(exc, requests.exceptions.Timeout):
                raise ERPSyncError(f"Falha de conexão com o ERP: {exc}") from exc
            raise ERPSyncError(f"Erro ao sincronizar volume com o ERP: {exc}") from exc
