from rest_framework import serializers

from apps.addresses.models import Address
from apps.customers.models import Customer

from .models import Order, OrderItem


class OrderItemSerializer(serializers.ModelSerializer):
    # Product fields: description + sku_code
    # (Product model has no 'name'/'code')
    product_description = serializers.CharField(
        source="product.description", read_only=True
    )
    product_sku = serializers.CharField(
        source="product.sku_code", read_only=True
    )

    class Meta:
        model = OrderItem
        fields = [
            "id",
            "product",
            "product_sku",
            "product_description",
            "quantity",
        ]


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = Order
        fields = "__all__"


class AddressDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = [
            "street",
            "number",
            "complement",
            "district",
            "city",
            "state",
            "zip_code",
            "country",
        ]


class CustomerDetailSerializer(serializers.ModelSerializer):
    address = AddressDetailSerializer(read_only=True)

    class Meta:
        model = Customer
        fields = ["code", "name", "id_number", "phone", "address"]


class OrderDetailSerializer(serializers.ModelSerializer):
    customer = CustomerDetailSerializer(read_only=True)
    items = OrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = Order
        fields = [
            "id",
            "picking",
            "order_number",
            "order_route",
            "customer",
            "status",
            "situation",
            "invoice_number",
            "scheduled_date",
            "typing_date",
            "release_date",
            "pre_invoice_date",
            "condition",
            "operation",
            "origin",
            "typist",
            "salesperson",
            "releaser",
            "pending_payment",
            "net_weight",
            "total_volumes",
            "created_at",
            "updated_at",
            "items",
        ]
