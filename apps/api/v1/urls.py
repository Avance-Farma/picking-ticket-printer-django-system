from django.urls import path

from .views import (
    APIHealthCheckView,
    VolumeDetailAPIView,
    VolumeListAPIView,
)

urlpatterns = [
    path(
        "volumes/",
        VolumeListAPIView.as_view(),
        name="volume-list",
    ),
    path(
        "volumes/<str:order_number>/",
        VolumeDetailAPIView.as_view(),
        name="volume-detail",
    ),
    path(
        "health/",
        APIHealthCheckView.as_view(),
        name="api-health",
    ),
]
