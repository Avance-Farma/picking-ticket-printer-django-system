from django.urls import path
from products import views

urlpatterns = [
    path(
        "products/list/", views.ProductListView.as_view(), name="product_list"
    ),
    path(
        "products/detail/<int:pk>/",
        views.ProductDetailView.as_view(),
        name="product_detail",
    ),
]
