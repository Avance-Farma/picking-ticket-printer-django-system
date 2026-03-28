"""
Data migration that loads seed data from init.sql using psycopg2's copy_expert,
which supports PostgreSQL's native COPY protocol.

Only INSERT data is extracted from the SQL dump (COPY blocks).
DDL statements (CREATE TABLE, ALTER TABLE, etc.) are skipped since
Django's 0001_initial migration already creates the schema.

The SQL dump may include columns (e.g. cpf_cnpj in pedidos) that do not exist
in the Django model. Those columns are automatically dropped before inserting.

If you need to re-run only the seed, execute:
  python manage.py migrate ticket_printer zero
  python manage.py migrate ticket_printer
"""
import io
import os
import re

from django.db import migrations

# Columns present in the dump that are NOT in the Django model.
# They will be stripped from the COPY data before importing.
_STRIP_COLUMNS = {
    "public.pedidos": {"cpf_cnpj"},
    "pedidos": {"cpf_cnpj"},
}


def _parse_copy_blocks(sql_text):
    """
    Extracts COPY ... FROM stdin blocks from a pg_dump SQL file.
    Returns a list of (table_name, columns, data_lines) tuples.

    table_name  - e.g. 'public.pedidos'
    columns     - list of column names in order
    data_lines  - list of raw tab-separated row strings (no trailing newline)
    """
    pattern = re.compile(
        r"COPY\s+(\S+)\s*\(([^)]+)\)\s+FROM\s+stdin\s*;\n(.*?)\n\\\.(?:\n|$)",
        re.IGNORECASE | re.DOTALL,
    )
    blocks = []
    for m in pattern.finditer(sql_text):
        table = m.group(1).strip()
        columns = [c.strip() for c in m.group(2).split(",")]
        data_raw = m.group(3)
        data_lines = [line for line in data_raw.splitlines() if line.strip()]
        if data_lines:
            blocks.append((table, columns, data_lines))
    return blocks


def _parse_setval_statements(sql_text):
    """
    Extracts SELECT pg_catalog.setval(...) statements from the dump.
    Returns a list of SQL strings.
    """
    pattern = re.compile(
        r"SELECT\s+pg_catalog\.setval\([^)]+\)\s*;",
        re.IGNORECASE,
    )
    return [m.group(0) for m in pattern.finditer(sql_text)]


def _build_copy_stream(table, columns, data_lines, strip_cols):
    """
    Returns (copy_sql, BytesIO stream) with unwanted columns removed.
    If strip_cols is empty, rows are passed through unchanged.
    """
    # Figure out which column indices to keep
    keep_indices = [
        i for i, col in enumerate(columns) if col not in strip_cols
    ]
    kept_columns = [columns[i] for i in keep_indices]

    copy_sql = f"COPY {table} ({', '.join(kept_columns)}) FROM STDIN"

    buf = io.StringIO()
    for line in data_lines:
        if not strip_cols:
            buf.write(line + "\n")
        else:
            parts = line.split("\t")
            kept_parts = [parts[i] for i in keep_indices]
            buf.write("\t".join(kept_parts) + "\n")
    buf.write("\\.\n")

    return copy_sql, io.BytesIO(buf.getvalue().encode("utf-8"))


def load_sql_file(apps, schema_editor):
    sql_path = os.path.join(os.path.dirname(__file__), "init.sql")
    with open(sql_path, encoding="utf-8") as f:
        sql_text = f.read()

    copy_blocks = _parse_copy_blocks(sql_text)
    setval_stmts = _parse_setval_statements(sql_text)

    conn = schema_editor.connection.connection  # underlying psycopg2 connection
    with conn.cursor() as cursor:
        for table, columns, data_lines in copy_blocks:
            strip_cols = _STRIP_COLUMNS.get(table, set())
            copy_sql, stream = _build_copy_stream(table, columns, data_lines, strip_cols)
            cursor.copy_expert(copy_sql, stream)

        # Reset sequences so future INSERTs don't collide with seeded IDs
        for stmt in setval_stmts:
            cursor.execute(stmt)


def unload_seed_data(apps, schema_editor):
    with schema_editor.connection.cursor() as cursor:
        cursor.execute("DELETE FROM volume_itens;")
        cursor.execute("DELETE FROM pedido_volumes;")
        cursor.execute("DELETE FROM pedido_itens;")
        cursor.execute("DELETE FROM pedidos;")


class Migration(migrations.Migration):

    dependencies = [
        ("ticket_printer", "0001_initial"),
    ]

    operations = [
        migrations.RunPython(load_sql_file, reverse_code=unload_seed_data),
    ]
