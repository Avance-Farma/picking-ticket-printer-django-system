from django.urls import path
from . import api

app_name = "whatsapp_tracking"

urlpatterns = [
    # Webhooks (Evolution API pode adicionar sufixos na URL, ex: /api/webhook/qrcode-updated)
    path("api/webhook/", api.webhook_view, name="webhook"),
    path("api/webhook/<path:event_type>", api.webhook_view, name="webhook_with_event"),
    path("api/preview-tags/", api.preview_contacts_by_tags, name="preview_tags"),
    path("api/preview-csv/", api.preview_csv, name="preview_csv"),
]
