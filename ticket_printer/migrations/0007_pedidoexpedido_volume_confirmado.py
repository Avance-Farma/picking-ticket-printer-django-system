from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("ticket_printer", "0006_remove_pedido_pedidos_picking_numero_pedido_key_and_more"),
    ]

    operations = [
        migrations.AddField(
            model_name="pedido",
            name="volume_confirmado",
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="pedido",
            name="volume_confirmado_em",
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.CreateModel(
            name="PedidoExpedido",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("total_volumes", models.IntegerField()),
                ("expedido_em", models.DateTimeField(auto_now_add=True)),
                (
                    "pedido",
                    models.OneToOneField(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="expedido",
                        to="ticket_printer.pedido",
                    ),
                ),
            ],
            options={
                "db_table": "pedidos_expedidos",
            },
        ),
    ]
