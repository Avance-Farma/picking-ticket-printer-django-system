import pytest
from rest_framework.test import APIClient


from django.contrib.auth.models import User


@pytest.fixture
def user(db):
    return User.objects.create_superuser(username="testuser", password="password", email="test@example.com")


@pytest.fixture
def api_client() -> APIClient:
    return APIClient()


@pytest.fixture
def auth_client(user) -> APIClient:
    client = APIClient()
    client.force_authenticate(user=user)
    return client
