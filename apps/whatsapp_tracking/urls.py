from django.urls import path
from . import api
from . import views

app_name = "whatsapp_tracking"

urlpatterns = [
    path("dashboard/", views.dashboard_view, name="dashboard"),
    path("settings/", views.settings_view, name="settings"),
    path("api/webhook/", api.webhook_view, name="webhook"),
]

