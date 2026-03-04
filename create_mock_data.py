import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "core.settings")
django.setup()

from ticket_printer.models import Pedido, PedidoItem


def run():
    if Pedido.objects.filter(numero_pedido="12345").exists():
        print("Dados mock já existem.")
        return

    pedido = Pedido.objects.create(
        numero_pedido="12345",
        cliente_nome="Empresa ABC Ltda",
        endereco_logradouro="Rua dos Bobos",
        endereco_numero="0",
        endereco_bairro="Centro",
        endereco_cidade="São Paulo",
        endereco_uf="SP",
        endereco_cep="01000-000",
        rota="ZONA LESTE 01",
    )

    PedidoItem.objects.create(
        pedido=pedido,
        codigo_produto="PROD-001",
        descricao="Caixa de Ferramentas",
        quantidade=5,
    )
    PedidoItem.objects.create(
        pedido=pedido,
        codigo_produto="PROD-002",
        descricao="Parafusadeira Elétrica",
        quantidade=2,
    )
    PedidoItem.objects.create(
        pedido=pedido,
        codigo_produto="PROD-003",
        descricao="Kit de Brocas",
        quantidade=10,
    )

    # Adicionando um segundo pedido para teste
    pedido2 = Pedido.objects.create(
        numero_pedido="98765",
        cliente_nome="Loja XYZ",
        endereco_logradouro="Av. Paulista",
        endereco_numero="1500",
        endereco_bairro="Bela Vista",
        endereco_cidade="São Paulo",
        endereco_uf="SP",
        endereco_cep="01310-100",
        rota="CENTRO 02",
    )

    PedidoItem.objects.create(
        pedido=pedido2, codigo_produto="PC-100", descricao='Monitor 24"', quantidade=1
    )
    PedidoItem.objects.create(
        pedido=pedido2,
        codigo_produto="PC-101",
        descricao="Teclado Mecânico",
        quantidade=2,
    )

    print(
        "Dados mock criados com sucesso! Use os números de pedido: '12345' ou '98765'"
    )


if __name__ == "__main__":
    run()
