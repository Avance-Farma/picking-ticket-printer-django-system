import pytest

from apps.ticket_printer.services.zpl_service import ZPLGenerator
from tests.factories import OrderFactory


@pytest.mark.unit
@pytest.mark.django_db
class TestZPLGenerator:
    def test_generate_label(self):
        # Arrange — usa o model Order refatorado com related Customer + Address
        order = OrderFactory(picking="PCK-123", delivery__route="RT-01")
        # Atualiza o endereço do cliente para valores conhecidos
        addr = order.customer.address
        addr.street = "Rua ABC"
        addr.number = "123"
        addr.district = "Centro"
        addr.city = "São Paulo"
        addr.state = "SP"
        addr.zip_code = "01000000"
        addr.save()

        volume_num = 1
        total_volumes = 2

        # Act
        zpl = ZPLGenerator.generate_label(order, volume_num, total_volumes)

        # Assert
        assert "^XA" in zpl
        assert "^XZ" in zpl
        assert "^FO30,15^FR^FDPCK-123^FS" in zpl
        assert "^FO450,20^FR^FB330,1,0,R,0^FDRT-01^FS" in zpl
        assert "Rua ABC" in zpl
        assert "123" in zpl
        assert "Centro" in zpl
        assert "SÃO PAULO / SP - 01000000" in zpl
        assert "^FO0,323^FR^FB812,1,0,C^FD1/2^FS" in zpl
        # In other cities, city goes negative and district is normal text
        assert "^FO30,195^FB750,1,0,L,0^FDCentro^FS" in zpl
        assert "^FO20,240^GB770,45,45^FS" in zpl

    def test_generate_label_rio_de_janeiro(self):
        # Arrange
        order = OrderFactory(picking="PCK-999", delivery__route="RT-02")
        addr = order.customer.address
        addr.street = "Av Brasil"
        addr.number = "100"
        addr.district = "Copacabana"
        addr.city = "Rio de Janeiro"
        addr.state = "RJ"
        addr.zip_code = "20000000"
        addr.save()

        volume_num = 1
        total_volumes = 1

        # Act
        zpl = ZPLGenerator.generate_label(order, volume_num, total_volumes)

        # Assert
        assert "^FO30,15^FR^FDPCK-999^FS" in zpl
        assert "^FO450,20^FR^FB330,1,0,R,0^FDRT-02^FS" in zpl
        assert "Copacabana" in zpl
        assert "RIO DE JANEIRO" in zpl
        # In RJ, district goes negative and city is normal text
        assert "^FO20,190^GB770,50,50^FS" in zpl
        assert "^FO30,195^FR^FB750,1,0,L,0^FDCopacabana^FS" in zpl
        assert (
            "^FO30,250^FB750,1,0,L,0^FDRIO DE JANEIRO / RJ - 20000000^FS"
            in zpl
        )
