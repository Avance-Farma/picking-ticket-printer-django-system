from datetime import datetime
from decimal import Decimal
from typing import Any

from django.db import transaction
from django.utils.timezone import make_aware

from apps.addresses.models import Address
from apps.customers.models import Customer
from apps.deliveries.models import Delivery
from apps.orders.models import Order, OrderItem
from apps.products.models import Product


def _parse_date(date_str: str | None) -> datetime | None:
    if not date_str:
        return None
    date_str = str(date_str).strip()

    # Excel OLE date serial (e.g. "46078.4375") — xlrd/pandas gives raw floats
    try:
        serial = float(date_str)
        # Excel serials are always > 1 (day 1 = 1900-01-01)
        # and < 2958466 (9999-12-31)
        if 1.0 < serial < 2958466.0:
            import xlrd

            dt = xlrd.xldate_as_datetime(serial, 0)
            return make_aware(dt)
    except (ValueError, OverflowError):
        pass

    formats = [
        "%Y-%m-%d %H:%M:%S",
        "%d/%m/%Y - %H:%M",
        "%d/%m/%Y %H:%M",
        "%d/%m/%Y",
        "%Y-%m-%dT%H:%M:%S",
    ]
    for fmt in formats:
        try:
            dt = datetime.strptime(date_str, fmt)
            return make_aware(dt)
        except ValueError:
            pass
    return None


def _parse_decimal(val) -> Decimal | None:
    if val is None or val == "":
        return None
    try:
        # Note: file_processor already parses to Decimal for products,
        # but string extracted properties might need parsing here if we
        # didn't parse them yet.
        if isinstance(val, Decimal):
            return val
        s = (
            str(val).replace(".", "").replace(",", ".")
            if "," in str(val) and "." in str(val)
            else str(val).replace(",", ".")
        )
        return Decimal(s)
    except Exception:
        return None


class DatabaseImporter:
    @staticmethod
    def save_complete_order(order_data: dict[str, Any]) -> Order:
        with transaction.atomic():
            order_number = order_data.get("order_number", "")
            picking = order_data.get("picking", "")
            id_number = order_data.get("id_number", "")

            # Create or get Address (thread-safe update_or_create)
            address, _ = Address.objects.update_or_create(
                street=order_data.get("address_street", ""),
                number=order_data.get("address_number", ""),
                district=order_data.get("address_district", ""),
                city=order_data.get("address_city", ""),
                state=order_data.get("address_state", ""),
                zip_code=order_data.get("address_zip_code", ""),
                defaults={
                    "country": "Brasil",
                    "complement": order_data.get("customer_reference") or "",
                },
            )

            # Create or get Customer (thread-safe update_or_create)
            customer_code = order_data.get("customer_code", "")
            customer, _ = Customer.objects.update_or_create(
                id_number=id_number,
                defaults={
                    "code": customer_code,
                    "name": order_data.get("customer_name", ""),
                    "address": address,
                    "phone": order_data.get("phone", ""),
                },
            )

            # Handle delivery (thread-safe update_or_create)
            delivery = None
            manifest = order_data.get("manifest", "")
            carrier = order_data.get("carrier", "")
            route = order_data.get("route", "")

            if manifest or carrier or route:
                # Use manifest/carrier if available,
                # otherwise use route as a fallback key
                # if we want to ensure uniqueness of "routes without manifest"
                # For now, if no manifest/carrier, we just create/get by route.
                if manifest or carrier:
                    delivery, _ = Delivery.objects.update_or_create(
                        manifest=manifest,
                        carrier=carrier,
                        defaults={
                            "delivery": order_data.get("delivery", ""),
                            "route": route,
                            "vehicle": order_data.get("vehicle", ""),
                            "driver": order_data.get("driver", ""),
                            "helper": order_data.get("helper", ""),
                        },
                    )
                else:
                    # Search by route if manifest/carrier are empty
                    delivery, _ = Delivery.objects.update_or_create(
                        route=route,
                        defaults={
                            "delivery": order_data.get("delivery", ""),
                            "vehicle": order_data.get("vehicle", ""),
                            "driver": order_data.get("driver", ""),
                            "helper": order_data.get("helper", ""),
                        },
                    )

            # Create or update Order (thread-safe update_or_create)
            order, _ = Order.objects.update_or_create(
                order_number=order_number,
                picking=picking,
                defaults={
                    "customer": customer,
                    "delivery": delivery,
                    "total_volumes": order_data.get("total_volumes", None),
                    "status": "pending",
                    "situation": order_data.get("situation") or "",
                    "typing_date": _parse_date(order_data.get("typing_date")),
                    "release_date": _parse_date(
                        order_data.get("release_date")
                    ),
                    "pre_invoice_date": _parse_date(
                        order_data.get("pre_invoice_date")
                    ),
                    "invoice_number": order_data.get("invoice_number") or "",
                    "scheduled_date": order_data.get("scheduled_date") or "",
                    "condition": order_data.get("condition") or "",
                    "operation": order_data.get("operation") or "",
                    "origin": order_data.get("origin") or "",
                    "typist": order_data.get("typist") or "",
                    "salesperson": order_data.get("salesperson") or "",
                    "releaser": order_data.get("releaser") or "",
                    "pending_payment": order_data.get("pending_payment") or "",
                    "net_weight": _parse_decimal(order_data.get("net_weight")),
                },
            )

            # Reset previous items for re-importing
            OrderItem.objects.filter(order=order).delete()

            products_data = order_data.get("products", [])
            # Sort products by SKU to prevent deadlocks on "produtos" table
            # when multiple orders share the same products.
            products_data.sort(key=lambda x: str(x.get("product_code", "")))

            for product_data in products_data:
                sku_code = str(product_data.get("product_code", "")).strip()
                description = product_data.get("description", "")
                price = _parse_decimal(product_data.get("price")) or Decimal(
                    "0.00"
                )

                if not sku_code:
                    continue

                # Create or update Product (thread-safe update_or_create)
                product, _ = Product.objects.update_or_create(
                    sku_code=sku_code,
                    defaults={
                        "description": description,
                        "price": price if price > 0 else 0,
                    },
                )

                OrderItem.objects.create(
                    order=order,
                    product=product,
                    quantity=product_data.get("quantity", Decimal("0")),
                )

            return order
