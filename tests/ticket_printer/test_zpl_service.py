import pytest

from apps.ticket_printer.services.zpl_service import ZPLGenerator
from tests.factories import OrderFactory


@pytest.mark.unit
@pytest.mark.django_db
class TestZPLGeneratorTwoColumnLayout:
    """Testes para o layout de duas colunas da etiqueta ZPL."""

    def _generate(self, order=None, volume_num=1, total_volumes=1):
        """Helper para gerar ZPL com defaults."""
        if order is None:
            order = OrderFactory()
        return ZPLGenerator.generate_label(order, volume_num, total_volumes)

    def test_label_contains_zpl_envelope(self):
        zpl = self._generate()
        assert zpl.startswith("^XA") or "^XA" in zpl
        assert "^XZ" in zpl
        assert "^CI28" in zpl  # encoding UTF-8

    def test_header_section_picking_and_route(self):
        order = OrderFactory(picking="PCK-123", delivery__route="RT-01")
        zpl = self._generate(order=order)
        # Header invertido com fontes maiores
        assert "^FO20,10^GB770,55,55^FS" in zpl  # fundo preto header
        assert "^FO30,12^FR^FDPCK-123^FS" in zpl  # picking invertido
        assert "RT-01" in zpl

    def test_left_column_customer_name(self):
        order = OrderFactory()
        order.customer.name = "Farmácia São João Batista do Centro LTDA"
        order.customer.save()
        zpl = self._generate(order=order)
        # Nome do cliente, fonte 32,24
        assert "^FO30,75^FB445,2" in zpl
        assert "Farmácia São João Batista do Centro LTDA" in zpl

    def test_left_column_street_and_number(self):
        order = OrderFactory()
        addr = order.customer.address
        addr.street = "Rua Voluntários da Pátria"
        addr.number = "1234"
        addr.save()
        zpl = self._generate(order=order)
        # Rua e número, fonte 28,20, Y=135
        assert "^FO30,135^FB445,2" in zpl
        assert "Rua Voluntários da Pátria, 1234" in zpl

    def test_left_column_complement_present(self):
        order = OrderFactory()
        addr = order.customer.address
        addr.complement = "Sala 301, Bloco B"
        addr.save()
        zpl = self._generate(order=order)
        # Complemento, fonte 24,18, Y=185
        assert "^FO30,185^FB445,1" in zpl
        assert "Sala 301, Bloco B" in zpl

    def test_left_column_complement_absent(self):
        order = OrderFactory()
        addr = order.customer.address
        addr.complement = ""
        addr.save()
        zpl = self._generate(order=order)
        # Sem bloco de complemento no ZPL se não houver complemento
        assert "^FO30,185" not in zpl

    def test_right_column_district_normal_city(self):
        order = OrderFactory()
        addr = order.customer.address
        addr.city = "São Paulo"
        addr.district = "Centro"
        addr.save()
        zpl = self._generate(order=order)
        # Bairro na coluna direita sem inversão
        assert "Centro" in zpl
        assert "^FO500,75^GB290,40,40^FS" not in zpl
        # Cidade deve ficar com fundo invertido para cidades fora do RJ
        assert "^FO500,120^GB290,36,36^FS" in zpl
        assert "^FO505,125^FR^FB280,1" in zpl

    def test_right_column_district_rio_inverted(self):
        order = OrderFactory()
        addr = order.customer.address
        addr.city = "Rio de Janeiro"
        addr.district = "Copacabana"
        addr.save()
        zpl = self._generate(order=order)
        # Bairro na coluna direita com inversão para RJ Capital
        assert "^FO500,75^GB290,40,40^FS" in zpl  # fundo preto bairro
        assert "^FO505,80^FR^FB280,1" in zpl  # bairro invertido
        assert "Copacabana" in zpl
        # Cidade não deve ter fundo invertido se for RJ Capital
        assert "^FO500,120^GB290,36,36^FS" not in zpl

    def test_right_column_city_state_cep(self):
        order = OrderFactory()
        addr = order.customer.address
        addr.city = "Campinas"
        addr.state = "SP"
        addr.zip_code = "13000000"
        addr.save()
        zpl = self._generate(order=order)
        # Cidade/UF invertido (Campinas não é RJ)
        assert "^FO500,120^GB290,36,36^FS" in zpl
        assert "^FO505,125^FR^FB280,1" in zpl
        assert "CAMPINAS / SP" in zpl
        assert "^FO505,165^FB280,1" in zpl
        assert "CEP: 13000000" in zpl

    def test_right_column_order_number(self):
        order = OrderFactory(order_number="ORD-5678")
        zpl = self._generate(order=order)
        # Número do pedido na coluna direita, Y=195
        assert "^FO505,195^FB280,1" in zpl
        assert "ORD-5678" in zpl

    def test_vertical_separator(self):
        zpl = self._generate()
        # Separador vertical
        assert "^FO490,75^GB3,220,3^FS" in zpl

    def test_footer_volume_centered(self):
        zpl = self._generate(volume_num=2, total_volumes=5)
        # Volume centralizado e invertido no footer, Y=320, fonte 55,45
        assert "^FO20,315^GB770,60,60^FS" in zpl
        assert "^FO0,320^FR^FB812,1,0,C" in zpl
        assert "2/5" in zpl

    def test_horizontal_separator_before_footer(self):
        zpl = self._generate()
        # Separador horizontal antes do footer
        assert "^FO20,300^GB770,3,3^FS" in zpl

    def test_edge_case_missing_address(self):
        order = OrderFactory()
        addr = order.customer.address
        addr.street = ""
        addr.number = ""
        addr.district = ""
        addr.city = ""
        addr.state = ""
        addr.zip_code = ""
        addr.save()
        zpl = self._generate(order=order)
        assert "^XA" in zpl
        assert "^XZ" in zpl

    def test_edge_case_missing_delivery(self):
        order = OrderFactory(delivery=None)
        zpl = self._generate(order=order)
        assert "^XA" in zpl
        assert "^XZ" in zpl

    def test_edge_case_long_customer_name_wraps(self):
        order = OrderFactory()
        order.customer.name = "A" * 80
        order.customer.save()
        zpl = self._generate(order=order)
        assert "^FB445,2" in zpl
