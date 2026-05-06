"""
Views da app erp_sync.

ERPSyncTriggerView  — POST: dispara a task de sincronização manualmente
                      Retorna {log_id} para polling de status.

ERPSyncStatusView   — GET: retorna o status atual de um ERPSyncLog pelo ID.
                      Usado pelo frontend para fazer polling e atualizar o botão.
"""

import logging

from django.contrib.auth.mixins import (
    LoginRequiredMixin,
)
from drf_spectacular.utils import extend_schema, inline_serializer
from rest_framework import serializers
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.erp_sync.models import ERPSyncLog

logger = logging.getLogger(__name__)


class ERPSyncTriggerView(LoginRequiredMixin, APIView):
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
                "date": serializers.CharField(
                    required=False, help_text="YYYY-MM-DD"
                )
            },
        ),
        responses={
            202: inline_serializer(
                name="ERPSyncTriggerResponse",
                fields={
                    "status": serializers.CharField(),
                    "log_id": serializers.IntegerField(),
                    "sync_date": serializers.CharField(),
                    "message": serializers.CharField(),
                },
            )
        },
    )
    def post(self, request, *args, **kwargs):
        from datetime import date

        from django.conf import settings

        from apps.erp_sync.tasks import sync_erp_orders_task

        # request.data é o body já parseado pelo DRF (funciona com JSON e form-data)
        raw_date = (request.data.get("date") or "").strip()
        if raw_date:
            try:
                target_date = date.fromisoformat(raw_date)
            except ValueError:
                return Response(
                    {
                        "error": f"Data inválida: '{raw_date}'. Use o formato YYYY-MM-DD."
                    },
                    status=400,
                )
        else:
            target_date = date.today()

        branch_ids = getattr(settings, "ERP_BRANCH_IDS", [27, 19])
        branch_ids_str = ",".join(str(b) for b in branch_ids)

        # Usa get_or_create para respeitar o unique_together (sync_date, branch_ids)
        # Se já existe um log para esse dia, reutiliza e marca como running novamente
        log, created = ERPSyncLog.objects.get_or_create(
            sync_date=target_date,
            branch_ids=branch_ids_str,
            defaults={"status": ERPSyncLog.StatusChoices.RUNNING},
        )
        if not created:
            log.status = ERPSyncLog.StatusChoices.RUNNING
            log.save(update_fields=["status"])

        sync_erp_orders_task.apply_async(
            kwargs={
                "manual_log_id": log.id,
                "sync_date": target_date.strftime("%Y-%m-%d"),
            }
        )

        logger.info(
            "ERP Sync: manual pelo usuário %s — data=%s log_id=%s (novo=%s)",
            request.user,
            target_date,
            log.id,
            created,
        )

        return Response(
            {
                "status": "queued",
                "log_id": log.id,
                "sync_date": target_date.strftime("%d/%m/%Y"),
                "message": f"Sincronização de {target_date.strftime('%d/%m/%Y')} iniciada.",
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
                    "sync_date": serializers.CharField(),
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
            "sync_date": log.sync_date.strftime("%d/%m/%Y"),
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
