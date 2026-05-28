from django.db import migrations


def migrate_routes_to_deliveries(apps, schema_editor):
    Order = apps.get_model("orders", "Order")
    Delivery = apps.get_model("deliveries", "Delivery")

    with schema_editor.connection.cursor() as cursor:
        cursor.execute("""
            SELECT column_name
            FROM information_schema.columns
            WHERE table_name='orders' AND column_name='order_route'
        """)
        has_route_col = bool(cursor.fetchone())

    if not has_route_col:
        # If the column has already been removed in this database instance
        # (e.g., due to a previous migration run before a dump/restore),
        # skip the data migration safely.
        return

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
        # 2. Remove the field safely, using IF EXISTS for the database operation
        migrations.SeparateDatabaseAndState(
            state_operations=[
                migrations.RemoveField(
                    model_name="order",
                    name="order_route",
                ),
            ],
            database_operations=[
                migrations.RunSQL(
                    sql="ALTER TABLE orders DROP COLUMN IF EXISTS order_route CASCADE;",
                    reverse_sql="ALTER TABLE orders ADD COLUMN order_route varchar(50) DEFAULT '';"
                ),
            ],
        ),
    ]
