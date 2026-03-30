import json
import logging

from django.contrib.auth.mixins import (
    LoginRequiredMixin,
    PermissionRequiredMixin,
)
from django.core.files.storage import FileSystemStorage
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
        recent_batches = ImportBatch.objects.order_by("-created_at")[:10]
        recent_orders = Order.objects.order_by("-created_at")[:10]
        return render(
            request,
            self.template_name,
            {
                "recent_batches": recent_batches,
                "recent_orders": recent_orders,
            },
        )

    def post(self, request, *args, **kwargs):
        import_files = request.FILES.getlist("import_files")
        if not import_files:
            return JsonResponse(
                {"error": "No files were sent."},
                status=400,
            )

        upload_dir = "/app/uploads"

        fs = FileSystemStorage(location=upload_dir)

        file_paths = []
        for f in import_files:
            try:
                saved_name = fs.save(f.name, f)
                full_path = fs.path(saved_name)
                file_paths.append((full_path, saved_name))
            except Exception:
                logger.exception("Failed to save uploaded file: %s", f.name)

        if not file_paths:
            return JsonResponse(
                {"error": "Failed to store files."}, status=500
            )

        batch = ImportBatch.objects.create(
            total_files=len(file_paths), processed_files=0, status="processing"
        )

        process_import_batch_task.delay(batch.id, file_paths)

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
