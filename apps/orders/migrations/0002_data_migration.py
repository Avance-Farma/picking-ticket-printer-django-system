# Ficheiro gerado: apps/orders/migrations/0002_data_migration.py
from django.db import migrations


def extract_code_and_name(full_name, default_code):
    """
    Extracts code from names formatted as '123 - Name'.
    Returns (code, name).
    """
    if not full_name:
        return default_code, 'Sem Nome'
    
    if " - " in full_name:
        parts = full_name.split(" - ", 1)
        code_part = parts[0].strip()
        name_part = parts[1].strip()
        # Verificamos se a primeira parte é principalmente numérica
        if any(char.isdigit() for char in code_part):
            return code_part, name_part
            
    return default_code, full_name


def transferir_dados(apps, schema_editor):
    # 1. Carregar os NOVOS modelos do estado histórico
    Address = apps.get_model('addresses', 'Address')
    Customer = apps.get_model('customers', 'Customer')
    Order = apps.get_model('orders', 'Order')
    OrderItem = apps.get_model('orders', 'OrderItem')
    Product = apps.get_model('products', 'Product')
    ImportBatch = apps.get_model('imports', 'ImportBatch')

    # 2. Conexão direta à base de dados para ler as tabelas ANTIGAS
    with schema_editor.connection.cursor() as cursor:
        # Check available tables
        cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
        available_tables = [row[0] for row in cursor.fetchall()]
        print(f"\n[DEBUG] Tabelas disponíveis: {available_tables}")
        
        # --- MIGRAR PRODUTOS ---
        if 'pedido_itens' in available_tables:
            cursor.execute('SELECT DISTINCT codigo_produto, descricao FROM "pedido_itens" WHERE codigo_produto IS NOT NULL')
            rows = cursor.fetchall()
            print(f"[INFO] Processando {len(rows)} produtos únicos...")
            for row in rows:
                sku, desc = row
                Product.objects.get_or_create(
                    sku_code=sku,
                    defaults={'description': desc or '', 'price': 0}
                )

        # --- MIGRAR CLIENTES E ENDEREÇOS ---
        if 'pedidos' in available_tables:
            cursor.execute("""
                SELECT DISTINCT 
                    cliente_codigo, cliente_nome, cpf_cnpj, 
                    endereco_logradouro, endereco_numero, endereco_bairro, 
                    endereco_cidade, endereco_uf, endereco_cep 
                FROM "pedidos" 
            """)
            rows = cursor.fetchall()
            print(f"[INFO] Processando {len(rows)} combinações de cliente/endereço...")
            for row in rows:
                cod_orig, nome_orig, cpf, rua, num, bairro, cid, est, cep = row
                
                # Extração de código embutido no nome se o código explícito estiver ausente
                code, name = extract_code_and_name(nome_orig, cod_orig)
                
                # Garantia de um identificador único
                search_code = code or f"CUST-NAME-{name[:15]}" 
                
                # Deduplicação de Customer pelo código extraído/limpo
                customer_inst = Customer.objects.filter(code=search_code).first()
                if not customer_inst:
                    novo_endereco = Address.objects.create(
                        street=rua or '', number=num or '', district=bairro or '',
                        city=cid or '', state=est or '', zip_code=cep or '', country='Brasil'
                    )
                    customer_inst = Customer.objects.create(
                        code=search_code, name=name, 
                        id_number=cpf or '', address=novo_endereco
                    )

            # --- MIGRAR ENCOMENDAS (ORDERS) ---
            cursor.execute('SELECT id, picking, numero_pedido, rota, cliente_codigo, cliente_nome, criado_em FROM "pedidos"')
            pedidos_rows = cursor.fetchall()
            print(f"[INFO] Processando {len(pedidos_rows)} pedidos...")
            for row in pedidos_rows:
                old_id, picking, num_pedido, rota, cliente_cod, cliente_nome, criado_em = row
                
                # Mesma lógica de extração para localizar o cliente
                code, name = extract_code_and_name(cliente_nome, cliente_cod)
                search_code = code or f"CUST-NAME-{name[:15]}" 
                
                cliente_instancia = Customer.objects.filter(code=search_code).first()
                if not cliente_instancia:
                    print(f"[WARNING] Cliente não encontrado para pedido {num_pedido} (Cod: {search_code}). Pulando.")
                    continue

                # Obter volumes da tabela legada
                total_vols = None
                if 'pedido_volumes' in available_tables:
                    cursor.execute('SELECT MAX(total_volumes) FROM "pedido_volumes" WHERE pedido_id = %s', [old_id])
                    v_row = cursor.fetchone()
                    total_vols = v_row[0] if v_row else None

                # Criar Order
                order_inst, created = Order.objects.get_or_create(
                    picking=picking,
                    order_number=num_pedido,
                    defaults={
                        'order_route': rota or '', 'customer': cliente_instancia,
                        'total_volumes': total_vols, 'status': 'shipped',
                        'created_at': criado_em
                    }
                )

                # --- MIGRAR ITENS DO PEDIDO ---
                if 'pedido_itens' in available_tables:
                    cursor.execute('SELECT codigo_produto, quantidade FROM "pedido_itens" WHERE pedido_id = %s', [old_id])
                    itens_rows = cursor.fetchall()
                    for item_row in itens_rows:
                        sku, qtd = item_row
                        prod = Product.objects.filter(sku_code=sku).first()
                        if prod:
                            OrderItem.objects.get_or_create(
                                order=order_inst, product=prod,
                                defaults={'quantity': qtd}
                            )

        # --- MIGRAR IMPORT BATCHES ---
        if 'import_batches' in available_tables:
            cursor.execute('SELECT id, total_files, processed_files, status, errors, created_at FROM "import_batches"')
            batch_rows = cursor.fetchall()
            print(f"[INFO] Processando {len(batch_rows)} lotes de importação...")
            for row in batch_rows:
                bid, tot, proc, stat, err, created = row
                ImportBatch.objects.get_or_create(
                    id=bid,
                    defaults={
                        'total_files': tot, 'processed_files': proc, 
                        'status': stat, 'errors': err or '', 
                        'created_at': created
                    }
                )


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0001_initial'),
        ('customers', '0001_initial'),
        ('addresses', '0001_initial'),
        ('deliveries', '0001_initial'),
        ('products', '0001_initial'),
        ('imports', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(transferir_dados, reverse_code=migrations.RunPython.noop),
    ]
