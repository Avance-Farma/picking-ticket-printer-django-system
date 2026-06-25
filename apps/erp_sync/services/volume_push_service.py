"""
ERPVolumePushService — envia atualizações de volume para a API do ERP.

Endpoint: PUT /api/Avance/UpdateOrderVolume
Swagger: http://187.117.44.93:55050/index.html

REQUEST:
  - orderId : integer (Número do pedido — convertido de string para int)
  - volume  : integer (Quantidade total de volumes)

RESPONSE (LISTA com um objeto):
  [{
    "originalOrderId" : integer (ID do pedido confirmado)
    "volume"          : integer (Volume confirmado)
    "success"         : boolean (true se sucesso, false se erro)
    "message"         : string (Mensagem descritiva)
  }]

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

from apps.erp_sync.exceptions import ERPSyncError, ERPValidationError
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

        # Validar valores do payload
        if order_id_int <= 0:
            logger.error(
                "[%s] ERP Push: orderId deve ser positivo: %d",
                request_id,
                order_id_int,
            )
            raise ERPSyncError(f"orderId deve ser positivo: {order_id_int}")

        if volume <= 0:
            logger.error(
                "[%s] ERP Push: volume deve ser positivo: %d",
                request_id,
                volume,
            )
            raise ERPSyncError(f"volume deve ser positivo: {volume}")

        logger.debug(
            "[%s] ERP Push: Validação de payload OK - orderId=%d, volume=%d",
            request_id,
            order_id_int,
            volume,
        )

        # Preparar payload
        # NOTA: Para idempotência futura, adicionar requestId ao payload
        # payload = [{
        #     "orderId": order_id_int,
        #     "volume": volume,
        #     "requestId": request_id  # ← ERP pode usar para deduplicação
        # }]
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
                raise ERPValidationError(f"Resposta inválida do ERP (não é JSON): {response.text}") from exc

            # Validar estrutura da resposta — CONTRATO REAL
            # A API ERP retorna uma LISTA com um objeto, não um objeto único
            if not isinstance(response_data, list):
                logger.error(
                    "[%s] ERP Push: Resposta não é uma lista: %s",
                    request_id,
                    type(response_data).__name__,
                )
                raise ERPValidationError(
                    f"Resposta inválida do ERP: esperado list, recebido {type(response_data).__name__}"
                )

            if len(response_data) == 0:
                logger.error(
                    "[%s] ERP Push: Resposta é uma lista vazia",
                    request_id,
                )
                raise ERPValidationError("Resposta inválida do ERP: lista vazia")

            # Validar TODOS os itens (não apenas o primeiro)
            for idx, item in enumerate(response_data):
                if not isinstance(item, dict):
                    logger.error(
                        "[%s] ERP Push: Item %d não é um dicionário: %s",
                        request_id,
                        idx,
                        type(item).__name__,
                    )
                    raise ERPValidationError(
                        f"Resposta inválida do ERP: item {idx} não é dicionário"
                    )

            # Processar apenas o primeiro item (esperado)
            # Mas alertar se houver múltiplos itens
            if len(response_data) > 1:
                logger.warning(
                    "[%s] ERP Push: Resposta contém %d itens, processando apenas o primeiro",
                    request_id,
                    len(response_data),
                )

            item = response_data[0]

            # Validar campo "success" — OBRIGATÓRIO e BOOLEANO
            if "success" not in item:
                logger.error(
                    "[%s] ERP Push: Campo 'success' ausente na resposta",
                    request_id,
                )
                raise ERPValidationError("Campo 'success' obrigatório ausente na resposta do ERP")

            success = item.get("success")

            # Validar tipo: deve ser booleano
            if not isinstance(success, bool):
                logger.error(
                    "[%s] ERP Push: Campo 'success' não é booleano: %s (tipo: %s)",
                    request_id,
                    success,
                    type(success).__name__,
                )
                raise ERPValidationError(
                    f"Campo 'success' deve ser booleano, recebido {type(success).__name__}: {success}"
                )

            # Validar valor: deve ser True
            if success is not True:
                message = item.get("message", "Erro desconhecido")
                logger.error(
                    "[%s] ERP Push: ERP recusou a atualização - success=false - Message: %s",
                    request_id,
                    message,
                )
                raise ERPValidationError(f"O ERP recusou a atualização: {message}")

            # Validar campo "message" — OBRIGATÓRIO e STRING
            if "message" not in item:
                logger.warning(
                    "[%s] ERP Push: Campo 'message' ausente na resposta",
                    request_id,
                )
                # Não é erro crítico, apenas aviso

            message = item.get("message", "")
            if not isinstance(message, str):
                logger.warning(
                    "[%s] ERP Push: Campo 'message' não é string: %s (tipo: %s)",
                    request_id,
                    message,
                    type(message).__name__,
                )
                # Não é erro crítico, apenas aviso

            # Validar campo "volume" — OBRIGATÓRIO e INTEIRO
            if "volume" not in item:
                logger.error(
                    "[%s] ERP Push: Campo 'volume' ausente na resposta",
                    request_id,
                )
                raise ERPValidationError("Campo 'volume' obrigatório ausente na resposta do ERP")

            response_volume = item.get("volume")

            # Validar tipo do volume retornado
            if not isinstance(response_volume, int):
                logger.error(
                    "[%s] ERP Push: Campo 'volume' retornado não é inteiro: %s (tipo: %s)",
                    request_id,
                    response_volume,
                    type(response_volume).__name__,
                )
                raise ERPValidationError(
                    f"Campo 'volume' deve ser inteiro, recebido {type(response_volume).__name__}"
                )

            # Validar se ERP confirmou o volume CORRETO
            if response_volume != volume:
                logger.error(
                    "[%s] ERP Push: volume retornado diferente - Esperado: %d, Recebido: %d",
                    request_id,
                    volume,
                    response_volume,
                )
                raise ERPValidationError(
                    f"volume retornado diferente: esperado {volume}, recebido {response_volume}"
                )

            # Validar campo "originalOrderId" — OPCIONAL (apenas log)
            # A API ERP retorna "originalOrderId" em vez de "orderId"
            if "originalOrderId" in item:
                response_order_id = item.get("originalOrderId")

                # Validar tipo
                if not isinstance(response_order_id, int):
                    logger.warning(
                        "[%s] ERP Push: Campo 'originalOrderId' não é inteiro: %s (tipo: %s)",
                        request_id,
                        response_order_id,
                        type(response_order_id).__name__,
                    )
                # Validar se corresponde ao enviado
                elif response_order_id != order_id_int:
                    logger.warning(
                        "[%s] ERP Push: originalOrderId retornado diferente - Esperado: %d, Recebido: %d",
                        request_id,
                        order_id_int,
                        response_order_id,
                    )
            else:
                logger.warning(
                    "[%s] ERP Push: Campo 'originalOrderId' ausente na resposta (esperado conforme Swagger)",
                    request_id,
                )

            logger.info(
                "[%s] ERP Push: Dados confirmados pelo ERP - volume=%d, success=true",
                request_id,
                response_volume,
            )

            # Sucesso!
            elapsed_time = time.time() - start_time
            logger.info(
                "[%s] ERP Push: Volume do pedido %s atualizado com sucesso no ERP em %.2fs",
                request_id,
                order_number,
                elapsed_time,
            )

            # Alertar se resposta foi muito lenta (perto do timeout)
            if elapsed_time > 20:  # 20s de 30s timeout
                logger.warning(
                    "[%s] ERP Push: Resposta muito lenta: %.2fs (perto do timeout de 30s)",
                    request_id,
                    elapsed_time,
                )

            # Alertar se resposta foi anormalmente rápida (pode indicar cache/erro)
            if elapsed_time < 0.1:
                logger.warning(
                    "[%s] ERP Push: Resposta muito rápida: %.2fs (pode indicar cache ou erro)",
                    request_id,
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
