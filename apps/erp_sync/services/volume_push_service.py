"""
ERPVolumePushService — envia atualizações de volume para a API do ERP.

Endpoint: PUT /api/Avance/UpdateOrderVolume
Payload:
  - orderId : integer (Número do pedido — convertido de string para int)
  - volume  : integer (Quantidade total de volumes)
Headers:
  - Authorization : Bearer {token}
  - accept        : */*
"""

import logging
import time
import uuid
from typing import Any, Dict

import requests
from django.conf import settings

from apps.erp_sync.exceptions import ERPSyncError
from apps.erp_sync.services.auth_service import ERPAuthService

logger = logging.getLogger(__name__)


class ERPVolumePushService:
    """
    Serviço stateless responsável por enviar a atualização de volumes
    ativamente (Push) para a API do ERP quando um pedido for impresso.

    Endpoint: PUT /api/Avance/UpdateOrderVolume
    Payload:
      - orderId : integer (Número do pedido — convertido de string para int)
      - volume  : integer (Quantidade total de volumes)
    Headers:
      - Authorization : Bearer {token}
      - accept        : */*
    """

    @classmethod
    def _base_url(cls) -> str:
        return getattr(settings, "ERP_API_BASE_URL", "http://187.117.44.93:55050")

    @classmethod
    def push_volume(cls, order_number: str, volume: int) -> Dict[str, Any]:
        """
        Envia a quantidade de volumes para o ERP via PUT.
        Endpoint: PUT /api/Avance/UpdateOrderVolume

        Returns:
            Dict com resultado da operação incluindo response_data

        Raises:
            ERPSyncError: Se falhar na validação ou envio
        """
        # Gerar ID de rastreamento para esta requisição
        request_id = str(uuid.uuid4())[:8]
        start_time = time.time()

        url = f"{cls._base_url()}/api/Avance/UpdateOrderVolume"

        # Validar e converter order_number
        try:
            order_id_int = int(order_number)
        except (ValueError, TypeError) as exc:
            logger.error(
                "[%s] ERP Push: order_number inválido para conversão: %r",
                request_id,
                order_number,
                exc_info=True,
            )
            raise ERPSyncError(f"order_number inválido para conversão: {order_number!r}") from exc

        # Preparar payload
        payload = [{"orderId": order_id_int, "volume": volume}]

        logger.info(
            "[%s] ERP Push: Iniciando envio para pedido=%s volume=%d",
            request_id,
            order_number,
            volume,
        )
        logger.debug(
            "[%s] ERP Push: Payload a enviar: %s",
            request_id,
            payload,
        )

        # Obter token de autenticação
        try:
            token = ERPAuthService.get_valid_token()
        except Exception as exc:
            logger.error(
                "[%s] ERP Push: Falha ao obter token de autenticação: %s",
                request_id,
                exc,
                exc_info=True,
            )
            raise ERPSyncError(f"Falha ao obter token de autenticação: {exc}") from exc

        headers = {
            "accept": "*/*",
            "Authorization": f"Bearer {token}",
        }

        # Enviar requisição
        response = None
        response_data = None

        try:
            logger.debug(
                "[%s] ERP Push: Enviando PUT request para %s",
                request_id,
                url,
            )

            response = requests.put(url, json=payload, headers=headers, timeout=30)
            elapsed_time = time.time() - start_time

            logger.info(
                "[%s] ERP Push: Resposta recebida em %.2fs - Status: %d",
                request_id,
                elapsed_time,
                response.status_code,
            )
            logger.debug(
                "[%s] ERP Push: Response headers: %s",
                request_id,
                dict(response.headers),
            )

            # Tratamento de 401 Unauthorized
            if response.status_code == 401:
                logger.warning(
                    "[%s] ERP Push: 401 Unauthorized — invalidando cache e retentando login.",
                    request_id,
                )
                ERPAuthService.invalidate_cache()

                try:
                    token = ERPAuthService.get_valid_token()
                    headers["Authorization"] = f"Bearer {token}"

                    logger.info(
                        "[%s] ERP Push: Retentando com novo token",
                        request_id,
                    )

                    response = requests.put(url, json=payload, headers=headers, timeout=30)
                    elapsed_time = time.time() - start_time

                    logger.info(
                        "[%s] ERP Push: Resposta da retentativa em %.2fs - Status: %d",
                        request_id,
                        elapsed_time,
                        response.status_code,
                    )
                except Exception as exc:
                    logger.error(
                        "[%s] ERP Push: Falha ao retentar com novo token: %s",
                        request_id,
                        exc,
                        exc_info=True,
                    )
                    raise ERPSyncError(f"Falha ao retentar com novo token: {exc}") from exc

            # Validar status HTTP
            try:
                response.raise_for_status()
            except requests.exceptions.HTTPError as exc:
                logger.error(
                    "[%s] ERP Push: HTTP Error %d - %s",
                    request_id,
                    response.status_code,
                    response.text[:200],
                    exc_info=True,
                )
                raise ERPSyncError(f"HTTP Error {response.status_code}: {response.text}") from exc

            # Validar e parsear resposta JSON
            try:
                response_data = response.json()
                logger.debug(
                    "[%s] ERP Push: Response JSON: %s",
                    request_id,
                    response_data,
                )
            except requests.exceptions.JSONDecodeError as exc:
                logger.error(
                    "[%s] ERP Push: Falha ao parsear JSON da resposta: %s - Body: %s",
                    request_id,
                    exc,
                    response.text[:200],
                    exc_info=True,
                )
                raise ERPSyncError(f"Resposta inválida do ERP (não é JSON): {response.text}") from exc

            # Validar estrutura da resposta
            if not isinstance(response_data, list):
                logger.error(
                    "[%s] ERP Push: Resposta não é uma lista: %s",
                    request_id,
                    type(response_data),
                )
                raise ERPSyncError(
                    f"Resposta inválida do ERP: esperado lista, recebido {type(response_data).__name__}"
                )

            if len(response_data) == 0:
                logger.error(
                    "[%s] ERP Push: Resposta é uma lista vazia",
                    request_id,
                )
                raise ERPSyncError("Resposta inválida do ERP: lista vazia")

            # Validar primeiro item da resposta
            item = response_data[0]
            if not isinstance(item, dict):
                logger.error(
                    "[%s] ERP Push: Primeiro item da resposta não é um dicionário: %s",
                    request_id,
                    type(item),
                )
                raise ERPSyncError("Resposta inválida do ERP: item não é dicionário")

            # Validar campo "success"
            success = item.get("success")
            message = item.get("message", "")

            logger.info(
                "[%s] ERP Push: Campo 'success' na resposta: %s",
                request_id,
                success,
            )

            if success is False:
                logger.error(
                    "[%s] ERP Push: ERP recusou a atualização - Message: %s",
                    request_id,
                    message,
                )
                raise ERPSyncError(f"O ERP recusou a atualização: {message}")

            if success is not True:
                logger.warning(
                    "[%s] ERP Push: Campo 'success' não é booleano: %s (tipo: %s)",
                    request_id,
                    success,
                    type(success).__name__,
                )
                # Não é erro crítico, mas registra aviso

            # Sucesso!
            elapsed_time = time.time() - start_time
            logger.info(
                "[%s] ERP Push: Volume do pedido %s atualizado com sucesso no ERP em %.2fs",
                request_id,
                order_number,
                elapsed_time,
            )

            return {
                "success": True,
                "order_number": order_number,
                "volume": volume,
                "response_data": response_data,
                "elapsed_time": elapsed_time,
                "request_id": request_id,
            }

        except requests.exceptions.Timeout as exc:
            elapsed_time = time.time() - start_time
            logger.error(
                "[%s] ERP Push: Timeout após %.2fs ao enviar volume para pedido %s",
                request_id,
                elapsed_time,
                order_number,
                exc_info=True,
            )
            raise ERPSyncError(f"Timeout ao conectar com ERP: {exc}") from exc

        except requests.exceptions.ConnectionError as exc:
            elapsed_time = time.time() - start_time
            logger.error(
                "[%s] ERP Push: Erro de conexão após %.2fs ao enviar volume para pedido %s: %s",
                request_id,
                elapsed_time,
                order_number,
                exc,
                exc_info=True,
            )
            raise ERPSyncError(f"Erro de conexão com ERP: {exc}") from exc

        except requests.exceptions.RequestException as exc:
            elapsed_time = time.time() - start_time
            logger.error(
                "[%s] ERP Push: Erro de requisição após %.2fs ao enviar volume para pedido %s: %s",
                request_id,
                elapsed_time,
                order_number,
                exc,
                exc_info=True,
            )
            raise ERPSyncError(f"Erro ao sincronizar volume com o ERP: {exc}") from exc

        except ERPSyncError:
            # Re-raise ERPSyncError sem envolver
            raise

        except Exception as exc:
            elapsed_time = time.time() - start_time
            logger.error(
                "[%s] ERP Push: Erro inesperado após %.2fs ao enviar volume para pedido %s: %s",
                request_id,
                elapsed_time,
                order_number,
                exc,
                exc_info=True,
            )
            raise ERPSyncError(f"Erro inesperado ao sincronizar volume: {exc}") from exc
