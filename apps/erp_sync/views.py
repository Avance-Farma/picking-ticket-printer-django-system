"""
Views da app erp_sync.

ERPSyncTriggerView  — POST: dispara a task de sincronização manualmente
                      Retorna {log_id} para polling de status.

ERPSyncStatusView   — GET: retorna o status atual de um ERPSyncLog pelo ID.
                      Usado pelo frontend para fazer polling e atualizar o botão.
"""

import logging

from drf_spectacular.utils import extend_schema, inline_serializer
from rest_framework import serializers
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.erp_sync.models import ERPSyncLog

logger = logging.getLogger(__name__)


class ERPSyncTriggerView(APIView):
    """
    POST /api/v1/erp-sync/trigger/

    Dispara a sincronização ERP imediatamente (para uso manual via botão).
    Cria um ERPSyncLog com status 'running' e enfileira a Celery task.

    Permissão: usuário logado (mesma permissão da tela de ingestão).
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=inline_serializer(
            name="ERPSyncTriggerRequest",
            fields={
                "search_mode": serializers.ChoiceField(
                    choices=["date", "order", "prenote"], required=False
                ),
                "date": serializers.CharField(required=False),  # Legado
                "begin_date": serializers.CharField(required=False),
                "end_date": serializers.CharField(required=False),
                "date_type": serializers.IntegerField(required=False),
                "order_id": serializers.CharField(required=False),
                "prenote_id": serializers.CharField(required=False),
                "branch_ids": serializers.ListField(
                    child=serializers.IntegerField(), required=False
                ),
            },
        ),
        responses={
            202: inline_serializer(
                name="ERPSyncTriggerResponse",
                fields={
                    "status": serializers.CharField(),
                    "log_id": serializers.IntegerField(),
                    "message": serializers.CharField(),
                },
            )
        },
    )
    def post(self, request, *args, **kwargs):
        from datetime import date

        from django.conf import settings

        from apps.erp_sync.tasks import sync_erp_orders_task

        data = request.data
        search_mode = data.get("search_mode")
        
        # 1. Normalização e Validação
        begin_date = data.get("begin_date")
        end_date = data.get("end_date")
        date_type = int(data.get("date_type", 1))
        order_id = data.get("order_id")
        prenote_id = data.get("prenote_id")
        branch_ids_override = data.get("branch_ids")

        # Retrocompatibilidade
        if not search_mode:
            legacy_date = data.get("date")
            if legacy_date:
                search_mode = "date"
                begin_date = legacy_date
                end_date = legacy_date
            else:
                search_mode = "date"
                begin_date = date.today().isoformat()
                end_date = date.today().isoformat()

        # Validação por modo
        if search_mode == "date":
            if not begin_date or not end_date:
                return Response(
                    {"error": "Modo 'date' exige begin_date e end_date."}, 
                    status=400
                )
        elif search_mode == "order":
            if not order_id:
                return Response(
                    {"error": "Modo 'order' exige order_id."}, 
                    status=400
                )
        elif search_mode == "prenote":
            if not prenote_id:
                return Response(
                    {"error": "Modo 'prenote' exige prenote_id."}, 
                    status=400
                )

        # 2. Preparação do Log
        effective_branch_ids = branch_ids_override or getattr(
            settings, "ERP_BRANCH_IDS", [27]
        )
        branch_ids_str = ",".join(str(b) for b in effective_branch_ids)

        # Para modo date, salvamos a data no sync_date para manter retrocompatibilidade na UI
        target_sync_date = None
        if search_mode == "date":
            try:
                target_sync_date = date.fromisoformat(begin_date)
            except ValueError:
                pass

        log = ERPSyncLog.objects.create(
            sync_date=target_sync_date,
            branch_ids=branch_ids_str,
            search_mode=search_mode,
            search_filters={
                "begin_date": begin_date,
                "end_date": end_date,
                "date_type": date_type,
                "order_id": order_id,
                "prenote_id": prenote_id,
            },
            triggered_by="manual",
            status=ERPSyncLog.StatusChoices.RUNNING,
        )

        # 3. Disparo da Task
        sync_erp_orders_task.apply_async(
            kwargs={
                "manual_log_id": log.id,
                "search_mode": search_mode,
                "begin_date": begin_date,
                "end_date": end_date,
                "date_type": date_type,
                "order_id": order_id,
                "prenote_id": prenote_id,
                "branch_ids_override": branch_ids_override,
            }
        )

        logger.info(
            "ERP Sync: manual por %s — mode=%s log_id=%s",
            request.user, search_mode, log.id
        )

        return Response(
            {
                "status": "queued",
                "log_id": log.id,
                "message": "Sincronização iniciada com sucesso.",
            },
            status=202,
        )



class ERPSyncStatusView(APIView):
    """
    GET /api/v1/erp-sync/status/<log_id>/

    Retorna o status atual de um ERPSyncLog.
    Usado pelo frontend para fazer polling após disparar o trigger.
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={
            200: inline_serializer(
                name="ERPSyncStatusResponse",
                fields={
                    "log_id": serializers.IntegerField(),
                    "status": serializers.CharField(),
                    "status_display": serializers.CharField(),
                    "sync_date": serializers.CharField(allow_null=True),
                    "branch_ids": serializers.CharField(),
                    "orders_fetched": serializers.IntegerField(),
                    "orders_created": serializers.IntegerField(),
                    "orders_updated": serializers.IntegerField(),
                    "orders_errors": serializers.IntegerField(),
                    "error_detail": serializers.CharField(allow_null=True),
                    "created_at": serializers.CharField(),
                    "finished_at": serializers.CharField(allow_null=True),
                    "is_done": serializers.BooleanField(),
                },
            )
        }
    )
    def get(self, request, log_id, *args, **kwargs):
        try:
            log = ERPSyncLog.objects.get(id=log_id)
        except ERPSyncLog.DoesNotExist:
            return Response({"error": "Log não encontrado."}, status=404)

        return Response({
            "log_id": log.id,
            "status": log.status,
            "status_display": log.get_status_display(),
            "sync_date": log.sync_date.strftime("%d/%m/%Y") if log.sync_date else None,
            "branch_ids": log.branch_ids,
            "orders_fetched": log.orders_fetched,
            "orders_created": log.orders_created,
            "orders_updated": log.orders_updated,
            "orders_errors": log.orders_errors,
            "error_detail": log.error_detail,
            "created_at": log.created_at.strftime("%d/%m/%Y %H:%M:%S"),
            "finished_at": (
                log.finished_at.strftime("%d/%m/%Y %H:%M:%S")
                if log.finished_at
                else None
            ),
            "is_done": log.status
            in (
                ERPSyncLog.StatusChoices.SUCCESS,
                ERPSyncLog.StatusChoices.ERROR,
                ERPSyncLog.StatusChoices.PARTIAL,
            ),
        })


class ERPSyncHeartbeatView(APIView):
    """
    GET /api/v1/erp-sync/heartbeat/

    Retorna a 'saúde' atual da sincronização ERP.
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={
            200: inline_serializer(
                name="ERPSyncHeartbeatResponse",
                fields={
                    "status": serializers.CharField(),
                    "last_sync": serializers.DictField(),
                    "stats_24h": serializers.DictField(),
                },
            )
        }
    )
    def get(self, request, *args, **kwargs):
        from datetime import timedelta

        from django.db.models import Sum
        from django.utils import timezone

        # 1. Busca o último log finalizado
        last_log = ERPSyncLog.objects.exclude(
            status=ERPSyncLog.StatusChoices.RUNNING
        ).first()

        status = "unknown"
        last_sync_data = None

        if last_log:
            # OK se o último foi sucesso ou parcial
            if last_log.status in (
                ERPSyncLog.StatusChoices.SUCCESS,
                ERPSyncLog.StatusChoices.PARTIAL,
            ):
                status = "ok"
            else:
                status = "error"

            last_sync_data = {
                "id": last_log.id,
                "status": last_log.status,
                "finished_at": last_log.finished_at,
                "orders_fetched": last_log.orders_fetched,
            }

        # 2. Stats das últimas 24h
        day_ago = timezone.now() - timedelta(hours=24)
        logs_24h = ERPSyncLog.objects.filter(finished_at__gte=day_ago)
        
        stats = logs_24h.aggregate(
            total_fetched=Sum("orders_fetched"),
            total_created=Sum("orders_created"),
            total_updated=Sum("orders_updated"),
            total_errors=Sum("orders_errors"),
        )

        return Response({
            "status": status,
            "last_sync": last_sync_data,
            "stats_24h": {
                "total_orders": stats["total_fetched"] or 0,
                "created": stats["total_created"] or 0,
                "updated": stats["total_updated"] or 0,
                "errors": stats["total_errors"] or 0,
                "sync_count": logs_24h.count(),
            }
        })

