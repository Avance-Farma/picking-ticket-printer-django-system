from datetime import UTC, datetime, timedelta

import pytest
from django.contrib.auth.models import User
from rest_framework.test import APIClient

from apps.erp_sync.models import ERPSyncLog


@pytest.fixture
def auth_client():
    user = User.objects.create_user(username="testuser", password="password")
    client = APIClient()
    client.force_authenticate(user=user)
    return client

@pytest.mark.django_db
class TestERPSyncHeartbeatView:
    def test_heartbeat_no_logs_returns_200_with_warning(self, auth_client):
        resp = auth_client.get("/api/v1/erp-sync/heartbeat/")
        assert resp.status_code == 200
        assert resp.data["status"] == "unknown"

    def test_heartbeat_with_recent_success_returns_ok(self, auth_client):
        ERPSyncLog.objects.create(
            status=ERPSyncLog.StatusChoices.SUCCESS,
            orders_fetched=10,
            finished_at=datetime.now(UTC) - timedelta(minutes=5)
        )
        resp = auth_client.get("/api/v1/erp-sync/heartbeat/")
        assert resp.status_code == 200
        assert resp.data["status"] == "ok"
        assert resp.data["last_sync"]["orders_fetched"] == 10

    def test_heartbeat_with_recent_error_returns_error(self, auth_client):
        ERPSyncLog.objects.create(
            status=ERPSyncLog.StatusChoices.ERROR,
            finished_at=datetime.now(UTC) - timedelta(minutes=5)
        )
        resp = auth_client.get("/api/v1/erp-sync/heartbeat/")
        assert resp.status_code == 200
        assert resp.data["status"] == "error"

    def test_heartbeat_stats_24h(self, auth_client):
        # Log hoje
        ERPSyncLog.objects.create(
            status=ERPSyncLog.StatusChoices.SUCCESS,
            orders_fetched=5,
            finished_at=datetime.now(UTC)
        )
        # Log ontem (fora das 24h se rodar exatamente agora, mas vamos garantir)
        ERPSyncLog.objects.create(
            status=ERPSyncLog.StatusChoices.SUCCESS,
            orders_fetched=10,
            finished_at=datetime.now(UTC) - timedelta(hours=25)
        )
        
        resp = auth_client.get("/api/v1/erp-sync/heartbeat/")
        assert resp.data["stats_24h"]["total_orders"] == 5
