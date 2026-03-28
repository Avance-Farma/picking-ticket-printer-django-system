
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.http import JsonResponse
from django.urls import include, path
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularRedocView,
    SpectacularSwaggerView,
)

API_PATH = "api/v1/"


def health_check(request):
    """Lightweight health check for Railway monitoring."""
    return JsonResponse({"status": "ok"})


urlpatterns = [
    path("health/", health_check, name="health-check"),
    path("admin/", admin.site.urls),
    # Auth
    path(API_PATH, include("apps.authentication.urls")),
    path(
        "login/",
        auth_views.LoginView.as_view(
            template_name="login.html"
        ),
        name="login",
    ),
    path("logout/", auth_views.LogoutView.as_view(), name="logout"),
    # Schema
    path(
        API_PATH + "schema/",
        SpectacularAPIView.as_view(),
        name="schema",
    ),
    path(
        API_PATH + "schema/swagger-ui/",
        SpectacularSwaggerView.as_view(url_name="schema"),
        name="swagger-ui",
    ),
    path(
        API_PATH + "schema/redoc/",
        SpectacularRedocView.as_view(url_name="schema"),
        name="redoc",
    ),
    # App Routers
    path("addresses/", include("apps.addresses.urls")),
    path("customers/", include("apps.customers.urls")),
    path("deliveries/", include("apps.deliveries.urls")),
    path("imports/", include("apps.imports.urls")),
    path("", include("apps.orders.urls")),
    path("products/", include("apps.products.urls")),
    path("printer/", include("apps.ticket_printer.urls")),
]

if settings.DEBUG:
    urlpatterns += static(
        settings.STATIC_URL, document_root=settings.STATIC_ROOT
    )
