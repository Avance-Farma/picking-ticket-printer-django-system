import logging

import sentry_sdk
from django.core.cache import cache
from django.db.models import Q
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Order
from .serializers import OrderDetailSerializer, OrderSerializer
from .services.volume_service import VolumeService

logger = logging.getLogger(__name__)

ORDER_ERROR = "Pedido não encontrado."


class OrderRetrieveAPIView(generics.RetrieveAPIView):
    """
    Generic API View (DRF) para consultas REST de pedidos.
    """

    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    lookup_field = "order_number"


class OrderDetailByPkAPIView(generics.RetrieveAPIView):
    """
    GET /orders/api/v1/orders/detail/<pk>/

    Retorna todos os dados de um pedido (incluindo cliente, endereço e itens)
    para exibição no modal de detalhe.
    """

    serializer_class = OrderDetailSerializer

    def get_queryset(self):
        return Order.objects.select_related(
            "customer", "customer__address"
        ).prefetch_related("items", "items__product")


class ConfirmShippedAPIView(APIView):
    """
    POST /orders/api/v1/orders/<pk>/confirm-shipped/

    Chamado pelo cliente (browser) APÓS o QZ Tray confirmar impressão
    bem-sucedida. Marca o pedido como 'shipped'.
    """

    queryset = Order.objects.all()

    def post(self, request, pk, *args, **kwargs):
        try:
            order = Order.objects.get(pk=pk)
        except Order.DoesNotExist:
            return Response(
                {"error": ORDER_ERROR},
                status=status.HTTP_404_NOT_FOUND,
            )
        VolumeService.mark_shipped(order)
        cache.delete("orders_list_queryset")
        return Response({"success": True, "status": order.status})


class MarkFailedAPIView(APIView):
    """
    POST /orders/api/v1/orders/<pk>/mark-failed/

    Chamado pelo cliente quando o QZ Tray falha ou o usuário cancela.
    Marca o pedido como 'failed' para reprocessamento.
    """

    queryset = Order.objects.all()

    def post(self, request, pk, *args, **kwargs):
        try:
            order = Order.objects.get(pk=pk)
        except Order.DoesNotExist:
            return Response(
                {"error": ORDER_ERROR},
                status=status.HTTP_404_NOT_FOUND,
            )
        VolumeService.mark_failed(order)
        cache.delete("orders_list_queryset")
        return Response({"success": True, "status": order.status})


class OrderListAPIView(generics.ListAPIView):
    """
    Lista pedidos com filtro opcional por picking, pedido ou cliente.
    Usado pela tela de Orders para popular a tabela.
    """

    serializer_class = OrderSerializer

    def get_queryset(self):
        queryset = Order.objects.select_related("customer").order_by(
            "-created_at"
        )
        q = self.request.query_params.get("q", "").strip()
        status_filter = self.request.query_params.get("status", "")

        if q:
            queryset = queryset.filter(
                Q(picking__icontains=q)
                | Q(order_number__icontains=q)
                | Q(customer__name__icontains=q)
                | Q(customer__id_number__icontains=q)
            )
        if status_filter:
            queryset = queryset.filter(status=status_filter)

        return queryset


class ConfirmVolumesAPIView(APIView):
    """
    PATCH /orders/api/v1/<pk>/confirm-volumes/

    Confirma a quantidade de volumes de um pedido na tela de expedição.
    Apenas salva o total_volumes e atualiza o status para 'confirmed'.
    Não gera ZPL nem aciona impressão.
    """

    queryset = Order.objects.all()

    def patch(self, request, pk, *args, **kwargs):
        try:
            try:
                order = Order.objects.get(pk=pk)
            except Order.DoesNotExist:
                return Response(
                    {"error": ORDER_ERROR},
                    status=status.HTTP_404_NOT_FOUND,
                )

            total_volumes = request.data.get("total_volumes")
            if total_volumes is None:
                return Response(
                    {"total_volumes": ["Este campo é obrigatório."]},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            try:
                total_volumes = int(total_volumes)
                if total_volumes < 1:
                    raise ValueError
            except (ValueError, TypeError):
                return Response(
                    {"total_volumes": ["Deve ser um inteiro positivo."]},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            VolumeService.confirm_volumes(order, total_volumes)
            cache.delete("orders_list_queryset")

            return Response({
                "success": True,
                "order_id": order.pk,
                "total_volumes": order.total_volumes,
                "status": order.status,
            })

        except Exception as e:
            logger.exception("Error confirming volumes for order %s", pk)
            sentry_sdk.capture_exception(e)
            return Response(
                {
                    "error": "Erro interno ao confirmar volumes.",
                    "details": str(e),
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


class BulkProcessVolumesAPIView(APIView):
    """
    POST /orders/api/v1/volumes/process/

    Recebe uma lista de pedidos com suas quantidades de volumes já
    confirmadas, gera os comandos ZPL e retorna todos em sequência para
    impressão via QZ Tray.

    Payload esperado:
        {
            "orders": [
                {"order_id": 1, "total_volumes": 3},
                {"order_id": 5, "total_volumes": 2}
            ]
        }

    Response:
        {
            "success": true,
            "zpl_commands": ["^XA...^XZ", ...]
        }
    """

    queryset = Order.objects.all()

    def post(self, request, *args, **kwargs):
        orders_data = request.data.get("orders", [])

        if not orders_data or not isinstance(orders_data, list):
            return Response(
                {"error": "O campo 'orders' deve ser uma lista não vazia."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        zpl_commands: list[str] = []
        errors: list[dict] = []

        for entry in orders_data:
            order_id = entry.get("order_id")
            total_volumes = entry.get("total_volumes")

            try:
                total_volumes = int(total_volumes)
                if total_volumes < 1:
                    raise ValueError
            except (ValueError, TypeError):
                errors.append({
                    "order_id": order_id,
                    "error": "total_volumes deve ser um inteiro positivo.",
                })
                continue

            try:
                order = Order.objects.select_related(
                    "customer", "customer__address"
                ).get(pk=order_id)
            except Order.DoesNotExist:
                errors.append({
                    "order_id": order_id,
                    "error": "Pedido não encontrado.",
                })
                continue

            try:
                cmds = VolumeService.process_and_print(order, total_volumes)
                zpl_commands.extend(cmds)
            except Exception as e:
                logger.exception(
                    "Error processing order %s for printing", order_id
                )
                sentry_sdk.capture_exception(e)
                errors.append({"order_id": order_id, "error": str(e)})

        cache.delete("orders_list_queryset")

        if errors and not zpl_commands:
            return Response(
                {
                    "error": "Nenhum pedido pôde ser processado.",
                    "details": errors,
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        return Response({
            "success": True,
            "zpl_commands": zpl_commands,
            "errors": errors,
        })


class ConvertZPLToPDFAPIView(APIView):
    """
    POST /orders/api/v1/volumes/to-pdf/

    Recebe uma lista de strings ZPL e usa a Labelary API para
    retornar um PDF de múltiplas páginas com todas as etiquetas.
    """

    queryset = Order.objects.all()

    def post(self, request, *args, **kwargs):
        from django.http import HttpResponse

        from apps.ticket_printer.services.labelary_service import (
            LabelaryService,
        )

        zpl_commands = request.data.get("zpl_commands", [])

        if not zpl_commands or not isinstance(zpl_commands, list):
            return Response(
                {
                    "error": (
                        "JSON inválido. 'zpl_commands' "
                        "deve ser uma lista não vazia."
                    )
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            pdf_bytes = LabelaryService.generate_pdf(zpl_commands)

            response = HttpResponse(pdf_bytes, content_type="application/pdf")
            response["Content-Disposition"] = (
                'attachment; filename="etiquetas.pdf"'
            )
            return response
        except Exception as e:
            logger.exception("Erro ao converter ZPL para PDF")
            sentry_sdk.capture_exception(e)
            return Response(
                {
                    "error": (
                        "Falha de comunicação com o "
                        "serviço de renderização PDF."
                    )
                },
                status=status.HTTP_502_BAD_GATEWAY,
            )
