from django.db import migrations


def reset_importbatch_sequence(apps, schema_editor):
    if schema_editor.connection.vendor != "postgresql":
        return

    with schema_editor.connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT setval(
                pg_get_serial_sequence('imports_importbatch', 'id'),
                COALESCE((SELECT MAX(id) FROM imports_importbatch), 0) + 1,
                false
            )
            """
        )


class Migration(migrations.Migration):

    dependencies = [
        ("imports", "0001_initial"),
    ]

    operations = [
        migrations.RunPython(
            reset_importbatch_sequence,
            reverse_code=migrations.RunPython.noop,
        ),
    ]
