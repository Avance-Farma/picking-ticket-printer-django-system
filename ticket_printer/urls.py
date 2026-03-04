from django.urls import path
from . import views

urlpatterns = [
    path("", views.search_order_view, name="search_order"),
    path("process/", views.process_volumes_view, name="process_volumes"),
]
