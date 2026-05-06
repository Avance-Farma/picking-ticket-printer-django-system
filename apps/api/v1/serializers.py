from drf_spectacular.utils import extend_schema_field
from rest_framework import serializers

from apps.orders.models import Order


class VolumeInfoSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(
        source="customer.name", read_only=True
    )
    route = serializers.SerializerMethodField()

    class Meta:
        model = Order
        fields = [
            "order_number",
            "customer_name",
            "route",
            "total_volumes",
            "status",
            "confirmed_at",
            "shipped_at",
            "updated_at",
        ]
        read_only_fields = fields

    @extend_schema_field(serializers.CharField(allow_null=True))
    def get_route(self, obj) -> str | None:
        return obj.delivery.route if obj.delivery else None
