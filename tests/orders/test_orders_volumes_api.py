import pytest
from django.urls import reverse
from rest_framework.test import APIClient

from tests.factories import OrderFactory


@pytest.mark.api
@pytest.mark.django_db
class TestConfirmVolumesAPI:
    def test_confirm_volumes_success(self, api_client: APIClient):
        # Arrange
        order = OrderFactory(order_number="PED-12345", status="pending")
        url = reverse("api-confirm-volumes", kwargs={"pk": order.pk})
        data = {"total_volumes": 3}

        # Act
        response = api_client.patch(url, data, format="json")

        # Assert
        assert response.status_code == 200
        assert response.data["success"] is True
        assert response.data["total_volumes"] == 3
        assert response.data["status"] == "confirmed"

        order.refresh_from_db()
        assert order.total_volumes == 3
        assert order.status == "confirmed"

    def test_confirm_volumes_invalid_param(self, api_client: APIClient):
        # Arrange
        order = OrderFactory(order_number="PED-99999", status="pending")
        url = reverse("api-confirm-volumes", kwargs={"pk": order.pk})
        data = {"total_volumes": 0}

        # Act
        response = api_client.patch(url, data, format="json")

        # Assert
        assert response.status_code == 400

    def test_confirm_volumes_not_found(self, api_client: APIClient):
        # Arrange
        url = reverse("api-confirm-volumes", kwargs={"pk": 999999})
        data = {"total_volumes": 1}

        # Act
        response = api_client.patch(url, data, format="json")

        # Assert
        assert response.status_code == 404


@pytest.mark.api
@pytest.mark.django_db
class TestBulkProcessVolumesAPI:
    def test_bulk_process_success(self, api_client: APIClient):
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
        response = api_client.post(url, data, format="json")

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

    def test_bulk_process_empty_orders(self, api_client: APIClient):
        # Arrange
        url = reverse("api-process-volumes")
        data = {"orders": []}

        # Act
        response = api_client.post(url, data, format="json")

        # Assert
        assert response.status_code == 400

    def test_bulk_process_not_found(self, api_client: APIClient):
        # Arrange
        url = reverse("api-process-volumes")
        data = {"orders": [{"order_id": 999999, "total_volumes": 1}]}

        # Act
        response = api_client.post(url, data, format="json")

        # Assert
        assert response.status_code == 400
        assert "details" in response.data


@pytest.mark.api
@pytest.mark.django_db
class TestConfirmShippedAPI:
    def test_confirm_shipped_success(self, api_client: APIClient):
        order = OrderFactory(order_number="PED-SHIP-01", status="in_progress")
        url = reverse("api-confirm-shipped", kwargs={"pk": order.pk})
        response = api_client.post(url, format="json")
        assert response.status_code == 200
        assert response.data["success"] is True
        order.refresh_from_db()
        assert order.status == "shipped"

    def test_confirm_shipped_not_found(self, api_client: APIClient):
        url = reverse("api-confirm-shipped", kwargs={"pk": 999999})
        response = api_client.post(url, format="json")
        assert response.status_code == 404


@pytest.mark.api
@pytest.mark.django_db
class TestMarkFailedAPI:
    def test_mark_failed_success(self, api_client: APIClient):
        order = OrderFactory(order_number="PED-FAIL-01", status="in_progress")
        url = reverse("api-mark-failed", kwargs={"pk": order.pk})
        response = api_client.post(url, format="json")
        assert response.status_code == 200
        assert response.data["success"] is True
        order.refresh_from_db()
        assert order.status == "failed"

    def test_mark_failed_not_found(self, api_client: APIClient):
        url = reverse("api-mark-failed", kwargs={"pk": 999999})
        response = api_client.post(url, format="json")
        assert response.status_code == 404
