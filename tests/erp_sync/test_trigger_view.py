import pytest
from rest_framework.test import APIClient
from django.contrib.auth.models import User
from apps.erp_sync.models import ERPSyncLog

from unittest.mock import patch

@pytest.fixture
def auth_client():
    user = User.objects.create_user(username="testuser", password="password")
    client = APIClient()
    client.force_authenticate(user=user)
    return client

@pytest.mark.django_db
@patch("apps.erp_sync.tasks.sync_erp_orders_task.apply_async")
class TestERPSyncTriggerView:


    def test_trigger_mode_date_returns_202(self, mock_task, auth_client):


        resp = auth_client.post("/api/v1/erp-sync/trigger/", {
            "search_mode": "date", "begin_date": "2026-05-10",
            "end_date": "2026-05-12", "date_type": 1
        }, format="json")
        assert resp.status_code == 202
        assert "log_id" in resp.data

    def test_trigger_mode_order_returns_202(self, mock_task, auth_client):
        resp = auth_client.post("/api/v1/erp-sync/trigger/", {
            "search_mode": "order", "order_id": "12345"
        }, format="json")
        assert resp.status_code == 202
        log = ERPSyncLog.objects.get(id=resp.data["log_id"])
        assert log.search_mode == "order"

    def test_trigger_mode_prenote_returns_202(self, mock_task, auth_client):
        resp = auth_client.post("/api/v1/erp-sync/trigger/", {
            "search_mode": "prenote", "prenote_id": "67890"
        }, format="json")
        assert resp.status_code == 202

    def test_trigger_mode_date_missing_end_date_returns_400(self, mock_task, auth_client):
        resp = auth_client.post("/api/v1/erp-sync/trigger/", {
            "search_mode": "date", "begin_date": "2026-05-10"
        }, format="json")
        assert resp.status_code == 400

    def test_trigger_mode_order_missing_id_returns_400(self, mock_task, auth_client):
        resp = auth_client.post("/api/v1/erp-sync/trigger/", {
            "search_mode": "order"
        }, format="json")
        assert resp.status_code == 400

    def test_trigger_legacy_payload_returns_202(self, mock_task, auth_client):
        resp = auth_client.post("/api/v1/erp-sync/trigger/", {
            "date": "2026-05-12"
        }, format="json")
        assert resp.status_code == 202

    def test_trigger_branch_ids_override(self, mock_task, auth_client):
        resp = auth_client.post("/api/v1/erp-sync/trigger/", {
            "search_mode": "order", "order_id": "123", "branch_ids": [27]
        }, format="json")
        assert resp.status_code == 202
        log = ERPSyncLog.objects.get(id=resp.data["log_id"])
        assert log.branch_ids == "27"

    def test_trigger_creates_log_with_triggered_by_manual(self, mock_task, auth_client):
        auth_client.post("/api/v1/erp-sync/trigger/", {
            "search_mode": "order", "order_id": "123"
        }, format="json")
        log = ERPSyncLog.objects.first()
        assert log.triggered_by == "manual"
