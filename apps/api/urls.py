from django.urls import include, path

app_name = "public_api"

urlpatterns = [
    path("", include("apps.api.v1.urls")),
]
