import pytest
from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework.test import APIClient

from tests.factories import OrderFactory


@pytest.fixture
def auth_client(db):
    user = User.objects.create_user(
        username="erp_user", password="password123"
    )
    client = APIClient()
    # Mock JWT authentication by just forcing auth for simplicity in these tests
    # In production, it uses JWTAuthentication
    client.force_authenticate(user=user)
    return client


@pytest.mark.django_db
class TestVolumeAPI:
    """
    Testes para a API Passiva (PULL) de volumes.
    Estes testes devem falhar inicialmente (RED).
    """

    def test_volume_list_returns_200(self, auth_client):
        OrderFactory.create_batch(3)
        url = reverse("public_api:volume-list")
        response = auth_client.get(url)
        assert response.status_code == 200
        assert "results" in response.data
        assert len(response.data["results"]) == 3

    def test_volume_detail_returns_200(self, auth_client):
        order = OrderFactory(order_number="PED-123456")
        url = reverse("public_api:volume-detail", kwargs={"order_number": "PED-123456"})
        response = auth_client.get(url)
        assert response.status_code == 200
        assert response.data["order_number"] == "PED-123456"

    def test_volume_detail_not_found(self, auth_client):
        url = reverse("public_api:volume-detail", kwargs={"order_number": "NON-EXISTENT"})
        response = auth_client.get(url)
        assert response.status_code == 404

    def test_volume_list_filter_by_status(self, auth_client):
        OrderFactory(status="shipped")
        OrderFactory(status="pending")
        url = reverse("public_api:volume-list")
        response = auth_client.get(url, {"status": "shipped"})
        assert response.status_code == 200
        assert len(response.data["results"]) == 1
        assert response.data["results"][0]["status"] == "shipped"

    def test_volume_list_filter_by_order_number(self, auth_client):
        OrderFactory(order_number="PED-MATCH")
        OrderFactory(order_number="PED-OTHER")
        url = reverse("public_api:volume-list")
        response = auth_client.get(url, {"order_number": "MATCH"})
        assert response.status_code == 200
        assert len(response.data["results"]) == 1
        assert response.data["results"][0]["order_number"] == "PED-MATCH"

    def test_volume_list_pagination(self, auth_client):
        OrderFactory.create_batch(60)  # Standard pagination is 50
        url = reverse("public_api:volume-list")
        response = auth_client.get(url)
        assert response.status_code == 200
        assert len(response.data["results"]) == 50
        assert response.data["next"] is not None

    def test_unauthenticated_returns_401(self):
        client = APIClient()
        url = reverse("public_api:volume-list")
        response = client.get(url)
        # Should be 401 because we use JWTAuthentication which returns 401 for anonymous
        assert response.status_code == 401
