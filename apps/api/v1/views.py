import logging

from drf_spectacular.utils import OpenApiParameter, extend_schema
from rest_framework import generics, status
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.throttling import ScopedRateThrottle
from rest_framework.views import APIView
from rest_framework_simplejwt.authentication import JWTAuthentication

from apps.orders.models import Order

from .filters import apply_volume_filters
from .pagination import StandardResultsSetPagination
from .serializers import VolumeInfoSerializer

logger = logging.getLogger(__name__)


class VolumeListAPIView(generics.ListAPIView):
    """
    Lista pedidos com informações de volumes.
    Suporta filtros por status, order_number, picking e intervalo de datas.
    """
    queryset = Order.objects.all().select_related("customer", "delivery")
    serializer_class = VolumeInfoSerializer
    pagination_class = StandardResultsSetPagination
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]
    throttle_classes = [ScopedRateThrottle]
    throttle_scope = "erp"

    @extend_schema(
        tags=["volumes-public"],
        summary="Listar volumes de pedidos",
        description="Retorna lista paginada de pedidos com dados de volume para o ERP.",
        parameters=[
            OpenApiParameter("status", str, description="Filtro por status (ex: shipped, pending)"),
            OpenApiParameter("order_number", str, description="Número do pedido (NF)"),
            OpenApiParameter("picking", str, description="Código da onda de picking"),
            OpenApiParameter("date_from", str, description="Data mínima de criação (YYYY-MM-DD)"),
            OpenApiParameter("date_to", str, description="Data máxima de criação (YYYY-MM-DD)"),
            OpenApiParameter("has_volumes", bool, description="Filtrar pedidos com/sem volumes (true/false)"),
        ],
    )
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)

    def get_queryset(self):
        queryset = super().get_queryset()
        return apply_volume_filters(queryset, self.request.query_params)


class VolumeDetailAPIView(generics.RetrieveAPIView):
    """
    Detalhes de volumes de um pedido específico.
    """
    @extend_schema(
        tags=["volumes-public"],
        summary="Detalhes de volume por pedido",
        description="Retorna dados de volume de um pedido específico usando o order_number.",
    )
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)

    queryset = Order.objects.all()
    serializer_class = VolumeInfoSerializer
    lookup_field = "order_number"
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]
    throttle_classes = [ScopedRateThrottle]
    throttle_scope = "erp"


class APIHealthCheckView(APIView):
    """
    GET /api/v1/health/
    Health check da API pública.
    """
    permission_classes = [AllowAny]
    throttle_classes = []

    @extend_schema(
        tags=["system"],
        summary="Health check da API",
        description=(
            "Endpoint público para verificar a disponibilidade "
            "do serviço de API."
        ),
        responses={
            200: {
                "type": "object",
                "properties": {
                    "status": {"type": "string"},
                    "version": {"type": "string"}
                }
            }
        }
    )
    def get(self, request, *args, **kwargs):
        return Response(
            {"status": "ok", "api_version": "v1"},
            status=status.HTTP_200_OK,
        )
