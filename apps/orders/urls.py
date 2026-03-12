from django.urls import path

from .api_views import (
    BulkProcessVolumesAPIView,
    ConfirmShippedAPIView,
    ConfirmVolumesAPIView,
    ConvertZPLToPDFAPIView,
    MarkFailedAPIView,
    OrderDetailByPkAPIView,
    OrderListAPIView,
    OrderRetrieveAPIView,
)
from .views import OrdersListView

urlpatterns = [
    # Tela principal de expedição
    path("", OrdersListView.as_view(), name="orders-list"),
    # REST API — listagem e consulta
    path("api/v1/orders/", OrderListAPIView.as_view(), name="api-orders-list"),
    path(
        "api/v1/orders/<str:order_number>/",
        OrderRetrieveAPIView.as_view(),
        name="api-order-detail",
    ),
    # Confirmação de volumes (pending → confirmed)
    path(
        "api/v1/orders/<int:pk>/confirm-volumes/",
        ConfirmVolumesAPIView.as_view(),
        name="api-confirm-volumes",
    ),
    # Expedição (in_progress → shipped / failed)
    path(
        "api/v1/orders/<int:pk>/confirm-shipped/",
        ConfirmShippedAPIView.as_view(),
        name="api-confirm-shipped",
    ),
    path(
        "api/v1/orders/<int:pk>/mark-failed/",
        MarkFailedAPIView.as_view(),
        name="api-mark-failed",
    ),
    # Processamento em lote (gera ZPL + seta in_progress)
    path(
        "api/v1/volumes/process/",
        BulkProcessVolumesAPIView.as_view(),
        name="api-process-volumes",
    ),
    # Detalhe completo por PK (para o modal)
    path(
        "api/v1/orders/detail/<int:pk>/",
        OrderDetailByPkAPIView.as_view(),
        name="api-order-detail-pk",
    ),
    # Proxy para conversão das etiquetas em PDF pelo Labelary
    path(
        "api/v1/volumes/to-pdf/",
        ConvertZPLToPDFAPIView.as_view(),
        name="api-convert-pdf",
    ),
]
