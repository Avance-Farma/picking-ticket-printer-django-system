"""
Celery tasks para sincronização periódica com a API ERP.

Task principal:
    sync_erp_orders_task()
    - Busca pedidos do dia corrente para todas as filiais configuradas
    - Salva/atualiza os dados no banco via ERPOrderImporter
    - Registra o resultado em ERPSyncLog
    - Roda a cada ERP_SYNC_INTERVAL_MINUTES minutos (padrão: 10)

O agendamento é configurado em core/settings.py via CELERY_BEAT_SCHEDULE.
"""

import logging
from datetime import UTC, date, datetime

from celery import shared_task
from django.conf import settings

from apps.erp_sync.services.erp_importer import ERPOrderImporter
from apps.erp_sync.services.order_service import ERPOrderService

logger = logging.getLogger(__name__)


@shared_task(
    bind=True,
    name="erp_sync.sync_erp_orders",
    max_retries=3,
    default_retry_delay=60,  # espera 60s antes de cada retry
    acks_late=True,
)
def sync_erp_orders_task(
    self,
    manual_log_id: int | None = None,
    sync_date: str | None = None,
    # Novos parâmetros para sync manual avançado
    search_mode: str | None = None,  # "date" | "order" | "prenote"
    begin_date: str | None = None,
    end_date: str | None = None,
    date_type: int = 1,
    order_id: str | None = None,
    prenote_id: str | None = None,
    branch_ids_override: list[int] | None = None,
):  # type: ignore[override]
    """
    Sincroniza os pedidos de uma data específica ou via filtros avançados com a API ERP.

    Busca pedidos para cada filial em ERP_BRANCH_IDS (padrão: RJ=27, ES=19),
    insere novos e atualiza os existentes no banco de dados.
    Registra o resultado em ERPSyncLog para auditoria.

    Args:
        manual_log_id: quando disparada manualmente via botão Resync, recebe
                       o ID do log já criado pela view; caso contrário (Beat),
                       cria um novo log.
        sync_date: data no formato 'YYYY-MM-DD' a sincronizar (legado).
        search_mode: Modo de busca avançado.
        begin_date: Data de início para modo 'date'.
        end_date: Data de fim para modo 'date'.
        date_type: 1=Pedido, 2=Prenota.
        order_id: ID do pedido para modo 'order'.
        prenote_id: ID da prenota para modo 'prenote'.
        branch_ids_override: Lista de IDs de filiais para ignorar settings.
    """
    # Import aqui para evitar circular import no carregamento do Celery
    from apps.erp_sync.models import ERPSyncLog

    # ── 1. Resolve a data alvo e filiais ────────────────────────────────────
    target_date = None
    if sync_date:
        try:
            target_date = date.fromisoformat(sync_date)
        except ValueError:
            logger.error(
                "ERP Sync: data inválida: %s — usando hoje.", sync_date
            )
            target_date = date.today()
    elif not search_mode:
        target_date = date.today()

    target_str = target_date.strftime("%Y-%m-%d") if target_date else None
    
    effective_branch_ids = branch_ids_override or getattr(settings, "ERP_BRANCH_IDS", [27, 19])
    branch_ids_str = ",".join(str(b) for b in effective_branch_ids)

    logger.info(
        "ERP Sync: iniciando verificação mode=%s date=%s filiais=%s (manual=%s)",
        search_mode or "legacy",
        target_str, 
        effective_branch_ids, 
        manual_log_id is not None,
    )

    # ── 2. Busca os pedidos na API ──────────────────────────────────────────
    try:
        if search_mode:
            orders = ERPOrderService.fetch_orders_with_filters(
                branch_ids=effective_branch_ids,
                begin_date=begin_date,
                end_date=end_date,
                date_type=date_type,
                order_id=order_id,
                prenote_id=prenote_id,
            )
        else:
            orders = ERPOrderService.fetch_orders_for_all_branches(target_str)

    except Exception as exc:
        logger.exception("ERP Sync: falha ao buscar pedidos da API: %s", exc)
        # Erro de rede: atualiza log pré-existente (manual) ou registra
        if manual_log_id:
            try:
                sync_log = ERPSyncLog.objects.get(id=manual_log_id)
            except ERPSyncLog.DoesNotExist:
                sync_log = None
            if sync_log:
                sync_log.status = ERPSyncLog.StatusChoices.ERROR
                sync_log.error_detail = str(exc)
                sync_log.finished_at = datetime.now(UTC)
                sync_log.save(
                    update_fields=[
                        "status",
                        "error_detail",
                        "finished_at",
                        "last_checked_at",
                    ]
                )
        raise self.retry(exc=exc) from exc

    # ── 3. Nenhum pedido retornado ─────────────────────────────────────────
    # Atualiza last_checked_at no log do dia (se já existir) e encerra
    if not orders:
        logger.info(
            "ERP Sync: nenhum pedido novo em %s — nenhuma linha criada.",
            target_str,
        )
        # Se há um log pré-criado pela trigger view (manual), atualiza ele
        if manual_log_id:
            try:
                sync_log = ERPSyncLog.objects.get(id=manual_log_id)
                sync_log.status = ERPSyncLog.StatusChoices.SUCCESS
                sync_log.orders_fetched = 0
                sync_log.finished_at = datetime.now(UTC)
                sync_log.save(
                    update_fields=[
                        "status",
                        "orders_fetched",
                        "finished_at",
                        "last_checked_at",
                    ]
                )
            except ERPSyncLog.DoesNotExist:
                pass
        else:
            # Beat: atualiza last_checked_at no log do dia se ele já existir
            ERPSyncLog.objects.filter(
                sync_date=target_date,
                branch_ids=branch_ids_str,
            ).update(last_checked_at=datetime.now(UTC))

        return {"status": "ok", "date": target_str, "orders_fetched": 0}

    # ── 4. Há pedidos — importa e salva ────────────────────────────────────
    importer = ERPOrderImporter()
    stats = importer.import_orders(orders)

    if stats["errors"] == 0:
        final_status = ERPSyncLog.StatusChoices.SUCCESS
    elif stats["errors"] < len(orders):
        final_status = ERPSyncLog.StatusChoices.PARTIAL
    else:
        final_status = ERPSyncLog.StatusChoices.ERROR

    now = datetime.now(UTC)

    if manual_log_id:
        # Trigger manual: atualiza o log pré-criado pela view
        try:
            sync_log = ERPSyncLog.objects.get(id=manual_log_id)
            sync_log.status = final_status
            sync_log.orders_fetched = len(orders)
            sync_log.orders_created = stats["created"]
            sync_log.orders_updated = stats["updated"]
            sync_log.orders_errors = stats["errors"]
            sync_log.search_mode = search_mode or "date"
            sync_log.search_filters = {
                "begin_date": begin_date,
                "end_date": end_date,
                "date_type": date_type,
                "order_id": order_id,
                "prenote_id": prenote_id,
            } if search_mode else {}
            sync_log.triggered_by = "manual"
            sync_log.finished_at = now
            sync_log.save(
                update_fields=[
                    "status",
                    "orders_fetched",
                    "orders_created",
                    "orders_updated",
                    "orders_errors",
                    "search_mode",
                    "search_filters",
                    "triggered_by",
                    "finished_at",
                    "last_checked_at",
                ]
            )
        except ERPSyncLog.DoesNotExist:
            # Fallback: cria via update_or_create
            ERPSyncLog.objects.create(
                sync_date=target_date,
                branch_ids=branch_ids_str,
                status=final_status,
                orders_fetched=len(orders),
                orders_created=stats["created"],
                orders_updated=stats["updated"],
                orders_errors=stats["errors"],
                search_mode=search_mode or "date",
                search_filters={
                    "begin_date": begin_date,
                    "end_date": end_date,
                    "date_type": date_type,
                    "order_id": order_id,
                    "prenote_id": prenote_id,
                } if search_mode else {},
                triggered_by="manual",
                finished_at=now,
            )

    else:
        # Sem manual_log_id: decide se é Auto (Beat) ou Manual (chamada direta/CLI)
        is_manual = search_mode is not None

        if is_manual:
            ERPSyncLog.objects.create(
                sync_date=target_date,
                branch_ids=branch_ids_str,
                status=final_status,
                orders_fetched=len(orders),
                orders_created=stats["created"],
                orders_updated=stats["updated"],
                orders_errors=stats["errors"],
                search_mode=search_mode,
                search_filters={
                    "begin_date": begin_date,
                    "end_date": end_date,
                    "date_type": date_type,
                    "order_id": order_id,
                    "prenote_id": prenote_id,
                },
                triggered_by="manual",
                finished_at=now,
            )
        else:
            # Beat automático: uma linha por dia, atualizada no lugar
            ERPSyncLog.objects.update_or_create(
                sync_date=target_date,
                branch_ids=branch_ids_str,
                triggered_by="auto",
                defaults={
                    "status": final_status,
                    "orders_fetched": len(orders),
                    "orders_created": stats["created"],
                    "orders_updated": stats["updated"],
                    "orders_errors": stats["errors"],
                    "search_mode": "date",
                    "search_filters": {},
                    "finished_at": now,
                },
            )


    logger.info(
        "ERP Sync: concluído — data=%s pedidos=%d criados=%d "
        "atualizados=%d erros=%d",
        target_str,
        len(orders),
        stats["created"],
        stats["updated"],
        stats["errors"],
    )
    return {
        "status": "ok",
        "date": target_str,
        "orders_fetched": len(orders),
        **stats,
    }


def _push_volume_logic(task_instance, order_number: str, volume: int):
    """
    Lógica interna de envio de volume e atualização de status.
    Separada para facilitar testes unitários sem mockar todo o Celery.
    """
    from apps.erp_sync.exceptions import ERPSyncError
    from apps.erp_sync.services.volume_push_service import ERPVolumePushService
    from apps.orders.models import Order

    try:
        ERPVolumePushService.push_volume(order_number, volume)
        # Sucesso: Marca como Sincronizado
        Order.objects.filter(order_number=order_number).update(
            erp_volume_sync_status=Order.ERPSyncStatus.SENT,
            erp_volume_sync_error=""
        )
    except ERPSyncError as exc:
        retries = task_instance.request.retries
        max_retries = task_instance.max_retries
        
        logger.error(
            "ERP Push Task: falha pedido %s (tentativa %d/%d): %s",
            order_number,
            retries + 1,
            max_retries + 1,
            exc,
            exc_info=True,
        )
        if retries >= max_retries:
            logger.critical(
                "ERP Push Task: FALHA DEFINITIVA pedido %s após %d tentativas: %s",
                order_number,
                max_retries + 1,
                exc,
                exc_info=True,
            )
            # Falha Definitiva: Marca como Erro e salva o detalhe
            Order.objects.filter(order_number=order_number).update(
                erp_volume_sync_status=Order.ERPSyncStatus.ERROR,
                erp_volume_sync_error=f"Falha definitiva após {max_retries + 1} tentativas: {str(exc)}",
            )
            return
        raise task_instance.retry(exc=exc)


@shared_task(
    bind=True,
    name="erp_sync.push_volume_to_erp",
    max_retries=3,
    default_retry_delay=60,
    acks_late=True,
)
def push_volume_to_erp_task(self, order_number: str, volume: int):
    """
    Envia o volume para o ERP de forma assíncrona e atualiza o status na Order.
    """
    return _push_volume_logic(self, order_number, volume)
