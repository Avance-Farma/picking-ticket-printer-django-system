import json
import logging

from django.contrib.auth.mixins import (
    LoginRequiredMixin,
    PermissionRequiredMixin,
)
from django.http import JsonResponse
from django.shortcuts import render
from django.views import View
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.orders.models import Order

from .models import ImportBatch
from .tasks import process_import_batch_task

logger = logging.getLogger(__name__)


class UploadImportView(
    LoginRequiredMixin,
    PermissionRequiredMixin,
    View,
):
    template_name = "upload_import.html"
    permission_required = "imports.add_importbatch"

    def get(self, request, *args, **kwargs):
        from django.core.paginator import Paginator

        from apps.erp_sync.models import ERPSyncLog

        recent_batches = ImportBatch.objects.order_by("-created_at")[:10]
        recent_orders = Order.objects.order_by("-created_at")[:10]

        # Paginação dos logs de sincronização (10 por página, mais recentes primeiro)
        sync_logs_qs = ERPSyncLog.objects.order_by("-last_checked_at")
        paginator = Paginator(sync_logs_qs, 10)
        page_number = request.GET.get("sync_page", 1)
        sync_logs_page = paginator.get_page(page_number)

        return render(
            request,
            self.template_name,
            {
                "recent_batches": recent_batches,
                "recent_orders": recent_orders,
                "recent_sync_logs": sync_logs_page,
                "sync_logs_paginator": paginator,
            },
        )

    def post(self, request, *args, **kwargs):
        import_files = request.FILES.getlist("import_files")
        if not import_files:
            return JsonResponse(
                {"error": "No files were sent."},
                status=400,
            )

        file_payloads = []
        for f in import_files:
            try:
                content = f.read()
                file_payloads.append((content, f.name))
            except Exception:
                logger.exception("Failed to read uploaded file: %s", f.name)

        if not file_payloads:
            return JsonResponse(
                {"error": "Failed to read files."}, status=500
            )

        batch = ImportBatch.objects.create(
            total_files=len(file_payloads), processed_files=0, status="processing"
        )

        process_import_batch_task.delay(batch.id, file_payloads)

        return JsonResponse({"success": True, "batch_id": batch.id})


class ImportProgressAPIView(
    APIView,
):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        if not request.user.has_perm("imports.view_importbatch"):
            return Response(
                {"error": "Você não tem permissão para ver isso."}, status=403
            )

        batch_id = request.query_params.get("batch_id")
        if not batch_id:
            return Response({"error": "batch_id não fornecido"}, status=400)

        try:
            batch = ImportBatch.objects.get(id=batch_id)
            errors = json.loads(batch.errors) if batch.errors else []

            return Response({
                "status": batch.status,
                "processed": batch.processed_files,
                "total": batch.total_files,
                "errors": errors,
            })
        except ImportBatch.DoesNotExist:
            return Response({"error": "Batch não encontrado"}, status=404)
