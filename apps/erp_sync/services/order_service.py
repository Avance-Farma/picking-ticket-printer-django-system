"""
ERPOrderService — consulta o endpoint de pedidos da API ERP.

Endpoint: GET /api/Avance/PrenoteOrder
Parâmetros utilizados:
  - relationalBranchId : ID da filial (RJ=27, ES=19)
  - beginDate          : data de início no formato YYYY-MM-DD
  - endDate            : data de fim no formato YYYY-MM-DD
  - dateType           : 1 = pedido | 2 = prenota  (sempre usamos 1)
"""

import logging

import requests
from django.conf import settings

from apps.erp_sync.services.auth_service import ERPAuthService

logger = logging.getLogger(__name__)

DATE_TYPE_ORDER = 1  # Pedido (não prenota)


class ERPOrderService:
    """
    Serviço stateless para buscar pedidos da API ERP.
    Em caso de 401, invalida o cache e tenta novamente com novo login.
    """

    @classmethod
    def _base_url(cls) -> str:
        return getattr(settings, "ERP_API_BASE_URL", "http://187.117.44.93:55050")

    @classmethod
    def fetch_orders(
        cls,
        branch_id: int,
        begin_date: str | None = None,
        end_date: str | None = None,
        date_type: int = DATE_TYPE_ORDER,
        order_id: str | None = None,
        prenote_id: str | None = None,
    ) -> list[dict]:
        """
        Busca pedidos de uma filial com suporte a filtros avançados.

        Args:
            branch_id : relationalBranchId (ex: 27 para RJ, 19 para ES)
            begin_date : data de início (YYYY-MM-DD)
            end_date : data de fim (YYYY-MM-DD)
            date_type : 1=Pedido, 2=Prenota
            order_id : busca por ID de pedido específico
            prenote_id : busca por ID de prenota específica

        Returns:
            Lista de dicts conforme o JSON da API.
        """
        # Retrocompatibilidade: se o segundo argumento for uma data, usa como begin_date e end_date
        # Isso acontece se alguém chamar fetch_orders(27, "2026-05-12")
        if isinstance(begin_date, str) and "-" in begin_date and end_date is None:
            end_date = begin_date

        url = f"{cls._base_url()}/api/Avance/PrenoteOrder"
        params: dict[str, str | int] = {
            "relationalBranchId": branch_id,
        }

        if order_id:
            params["relatedOrderId"] = order_id
        elif prenote_id:
            params["relatedPreNoteId"] = prenote_id
        else:
            if begin_date:
                params["beginDate"] = begin_date
            if end_date:
                params["endDate"] = end_date
            params["dateType"] = date_type

        token = ERPAuthService.get_valid_token()
        headers = {
            "accept": "text/plain",
            "Authorization": f"Bearer {token}",
        }

        logger.info(
            "ERP Orders: buscando filial=%s params=%s...", branch_id, params
        )

        try:
            resp = requests.get(url, params=params, headers=headers, timeout=60)

            # Token expirado inesperadamente → invalida cache e retenta
            if resp.status_code == 401:
                logger.warning(
                    "ERP Orders: 401 na filial=%s — invalidando cache e "
                    "retentando login.",
                    branch_id,
                )
                ERPAuthService.invalidate_cache()
                token = ERPAuthService.get_valid_token()
                headers["Authorization"] = f"Bearer {token}"
                resp = requests.get(url, params=params, headers=headers, timeout=60)

            resp.raise_for_status()

        except requests.RequestException as exc:
            logger.error(
                "ERP Orders: erro de rede ao buscar filial=%s params=%s: %s",
                branch_id,
                params,
                exc,
            )
            return []

        try:
            data = resp.json()
        except ValueError:
            logger.error(
                "ERP Orders: resposta inválida (não-JSON) para filial=%s params=%s",
                branch_id,
                params,
            )
            return []

        if not isinstance(data, list):
            logger.warning(
                "ERP Orders: resposta inesperada (não é lista) para filial=%s: %r",
                branch_id,
                data,
            )
            return []

        logger.info(
            "ERP Orders: %d pedido(s) recebido(s) — filial=%s params=%s",
            len(data),
            branch_id,
            params,
        )
        return data

    @classmethod
    def fetch_orders_with_filters(
        cls,
        branch_ids: list[int] | None = None,
        begin_date: str | None = None,
        end_date: str | None = None,
        date_type: int = DATE_TYPE_ORDER,
        order_id: str | None = None,
        prenote_id: str | None = None,
    ) -> list[dict]:
        """
        Busca pedidos de múltiplas filiais usando filtros avançados.
        """
        if branch_ids is None:
            branch_ids = getattr(settings, "ERP_BRANCH_IDS", [27, 19])

        all_orders: list[dict] = []
        for branch_id in branch_ids:
            orders = cls.fetch_orders(
                branch_id,
                begin_date=begin_date,
                end_date=end_date,
                date_type=date_type,
                order_id=order_id,
                prenote_id=prenote_id,
            )
            all_orders.extend(orders)

        return all_orders


    @classmethod
    def fetch_orders_for_all_branches(cls, date_str: str) -> list[dict]:
        """
        Busca pedidos de todas as filiais configuradas em ERP_BRANCH_IDS.

        Args:
            date_str : data no formato "YYYY-MM-DD"

        Returns:
            Lista consolidada de todos os pedidos de todas as filiais.
        """
        branch_ids: list[int] = getattr(settings, "ERP_BRANCH_IDS", [27, 19])
        all_orders: list[dict] = []

        for branch_id in branch_ids:
            orders = cls.fetch_orders(branch_id, date_str)
            all_orders.extend(orders)

        return all_orders
