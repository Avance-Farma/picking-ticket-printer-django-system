from django.db import migrations, models


def migrate_routes_to_deliveries(apps, schema_editor):
    Order = apps.get_model("orders", "Order")
    Delivery = apps.get_model("deliveries", "Delivery")

    for order in Order.objects.all():
        if order.order_route:
            # If the order already has a delivery, ensure the route is set
            if order.delivery:
                if not order.delivery.route:
                    order.delivery.route = order.order_route
                    order.delivery.save()
            else:
                # If no delivery, create one or find one matching the route
                # We use the same logic as the importer: if no manifest/carrier, 
                # we treat the route as the identifier for now.
                delivery, created = Delivery.objects.get_or_create(
                    route=order.order_route,
                    defaults={
                        "manifest": "",
                        "carrier": "",
                    }
                )
                order.delivery = delivery
                order.save()


class Migration(migrations.Migration):

    atomic = False

    dependencies = [
        ("orders", "0002_data_migration"),
        ("deliveries", "0001_initial"),
    ]

    operations = [
        # 1. Run Python code to migrate data
        migrations.RunPython(migrate_routes_to_deliveries),
        # 2. Remove the field
        migrations.RemoveField(
            model_name="order",
            name="order_route",
        ),
    ]
