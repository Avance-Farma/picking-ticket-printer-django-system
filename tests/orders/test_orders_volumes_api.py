from unittest.mock import patch

import pytest
from django.urls import reverse
from rest_framework.test import APIClient

from tests.factories import OrderFactory


@pytest.fixture(autouse=True)
def mock_erp_task_delay():
    with patch("apps.orders.services.volume_service.push_volume_to_erp_task.delay") as mock:
        yield mock


@pytest.mark.api
@pytest.mark.django_db
class TestConfirmVolumesAPI:
    def test_confirm_volumes_success(self, auth_client: APIClient):
        # Arrange
        order = OrderFactory(order_number="PED-12345", status="pending")
        url = reverse("api-confirm-volumes", kwargs={"pk": order.pk})
        data = {"total_volumes": 3}

        # Act
        response = auth_client.patch(url, data, format="json")

        # Assert
        assert response.status_code == 200
        assert response.data["success"] is True
        assert response.data["total_volumes"] == 3
        assert response.data["status"] == "confirmed"
        assert response.data.get("erp_warning") is None

        order.refresh_from_db()
        assert order.total_volumes == 3
        assert order.status == "confirmed"

    def test_confirm_volumes_api_warning_on_push_failure(self, auth_client: APIClient, mock_erp_task_delay):
        """RED: Response deve conter erp_warning se o enfileiramento falhar."""
        order = OrderFactory(status="pending")
        url = reverse("api-confirm-volumes", kwargs={"pk": order.pk})
        mock_erp_task_delay.side_effect = Exception("Redis down")
        
        response = auth_client.patch(url, {"total_volumes": 3}, format="json")
        
        assert response.status_code == 200
        assert response.data["success"] is True
        assert response.data["erp_warning"] is not None
        assert "sincronizar" in response.data["erp_warning"]

    def test_confirm_volumes_invalid_param(self, auth_client: APIClient):
        # Arrange
        order = OrderFactory(order_number="PED-99999", status="pending")
        url = reverse("api-confirm-volumes", kwargs={"pk": order.pk})
        data = {"total_volumes": 0}

        # Act
        response = auth_client.patch(url, data, format="json")

        # Assert
        assert response.status_code == 400

    def test_confirm_volumes_not_found(self, auth_client: APIClient):
        # Arrange
        url = reverse("api-confirm-volumes", kwargs={"pk": 999999})
        data = {"total_volumes": 1}

        # Act
        response = auth_client.patch(url, data, format="json")

        # Assert
        assert response.status_code == 404


@pytest.mark.api
@pytest.mark.django_db
class TestBulkProcessVolumesAPI:
    def test_bulk_process_success(self, auth_client: APIClient):
        # Arrange
        order1 = OrderFactory(order_number="PED-001", status="confirmed")
        order2 = OrderFactory(order_number="PED-002", status="confirmed")
        url = reverse("api-process-volumes")
        data = {
            "orders": [
                {"order_id": order1.pk, "total_volumes": 2},
                {"order_id": order2.pk, "total_volumes": 1},
            ]
        }

        # Act
        response = auth_client.post(url, data, format="json")

        # Assert
        assert response.status_code == 200
        assert response.data["success"] is True
        # 2 + 1 = 3 ZPL commands total
        assert len(response.data["zpl_commands"]) == 3

        order1.refresh_from_db()
        # process_and_print now sets in_progress;
        # shipped is confirmed client-side
        assert order1.status == "in_progress"
        assert order1.total_volumes == 2

    def test_bulk_process_empty_orders(self, auth_client: APIClient):
        # Arrange
        url = reverse("api-process-volumes")
        data = {"orders": []}

        # Act
        response = auth_client.post(url, data, format="json")

        # Assert
        assert response.status_code == 400

    def test_bulk_process_not_found(self, auth_client: APIClient):
        # Arrange
        url = reverse("api-process-volumes")
        data = {"orders": [{"order_id": 999999, "total_volumes": 1}]}

        # Act
        response = auth_client.post(url, data, format="json")

        # Assert
        assert response.status_code == 400
        assert "details" in response.data


@pytest.mark.api
@pytest.mark.django_db
class TestConfirmShippedAPI:
    def test_confirm_shipped_success(self, auth_client: APIClient):
        order = OrderFactory(order_number="PED-SHIP-01", status="in_progress", total_volumes=1)
        url = reverse("api-confirm-shipped", kwargs={"pk": order.pk})
        response = auth_client.post(url, format="json")
        assert response.status_code == 200
        assert response.data["success"] is True
        assert response.data.get("erp_warning") is None
        order.refresh_from_db()
        assert order.status == "shipped"

    def test_confirm_shipped_no_longer_pushes_to_erp(self, auth_client: APIClient, mock_erp_task_delay):
        """Fix #2: mark_shipped não deve disparar push ao ERP."""
        order = OrderFactory(status="in_progress", total_volumes=1)
        url = reverse("api-confirm-shipped", kwargs={"pk": order.pk})
        
        response = auth_client.post(url, format="json")
        
        assert response.status_code == 200
        assert response.data["success"] is True
        assert response.data.get("erp_warning") is None
        mock_erp_task_delay.assert_not_called()

    def test_confirm_shipped_not_found(self, auth_client: APIClient):
        url = reverse("api-confirm-shipped", kwargs={"pk": 999999})
        response = auth_client.post(url, format="json")
        assert response.status_code == 404


@pytest.mark.api
@pytest.mark.django_db
class TestMarkFailedAPI:
    def test_mark_failed_success(self, auth_client: APIClient):
        order = OrderFactory(order_number="PED-FAIL-01", status="in_progress")
        url = reverse("api-mark-failed", kwargs={"pk": order.pk})
        response = auth_client.post(url, format="json")
        assert response.status_code == 200
        assert response.data["success"] is True
        order.refresh_from_db()
        assert order.status == "failed"

    def test_mark_failed_not_found(self, auth_client: APIClient):
        url = reverse("api-mark-failed", kwargs={"pk": 999999})
        response = auth_client.post(url, format="json")
        assert response.status_code == 404
