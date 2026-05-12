from django.urls import path

from .views import ERPSyncHeartbeatView, ERPSyncStatusView, ERPSyncTriggerView

urlpatterns = [
    path(
        "trigger/",
        ERPSyncTriggerView.as_view(),
        name="erp-sync-trigger",
    ),
    path(
        "status/<int:log_id>/",
        ERPSyncStatusView.as_view(),
        name="erp-sync-status",
    ),
    path(
        "heartbeat/",
        ERPSyncHeartbeatView.as_view(),
        name="erp-sync-heartbeat",
    ),
]

