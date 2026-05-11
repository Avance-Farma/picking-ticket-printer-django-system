import pytest
from django.utils import timezone
from apps.erp_sync.services.erp_importer import ERPOrderImporter
from apps.orders.models import Order
from tests.factories import OrderFactory, OrderItemFactory

@pytest.fixture
def sample_api_order():
    """JSON de pedido conforme retornado pela API ERP."""
    return {
        "orderId": 12345,
        "preNoteId": 67890,
        "clientId": 100,
        "clientName": "Farmácia Teste",
        "clientState": "RJ",
        "clientCity": "Rio de Janeiro",
        "clientZipCode": "20040-020",
        "clientNeighborhood": "Centro",
        "clientAddress": "Av. Rio Branco",
        "clientAddressNumber": "156",
        "clientAddressComplement": "Sala 1001",
        "clientRoute": "RJ-CENTRO",
        "orderDate": "2026-05-06T10:00:00",
        "preNoteDate": "2026-05-06T09:00:00",
        "scheduledDate": "2026-05-07T00:00:00",
        "orderPackages": 3,
        "orderStatus": "Conferido",
        "invoiceNumber": "NF-001",
        "invoiceValue": 1500.50,
        "invoiceAccessKey": None,
        "stockBranchId": 27,
        "stockBranchName": "Filial RJ",
        "items": [
            {"productId": 1001, "product": "Produto A", "quantity": 10.0, "barCode": "789"},
            {"productId": 1002, "product": "Produto B", "quantity": 5.0, "barCode": "790"},
        ],
    }

@pytest.fixture
def importer():
    return ERPOrderImporter()

@pytest.mark.django_db
def test_first_sync_creates_pending_order(importer, sample_api_order):
    """Pedido novo deve ser criado com status=PENDING."""
    order, created = importer.save_order(sample_api_order)

    assert created is True
    assert order.status == Order.StatusChoices.PENDING
    assert order.total_volumes == 3  # orderPackages
    assert order.confirmed_at is None
    assert order.shipped_at is None

@pytest.mark.django_db
def test_sync_does_not_reset_confirmed_status(importer, sample_api_order):
    """RED: Sync NÃO deve resetar status=confirmed."""
    # Cria pedido via sync
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345", picking="67890")

    # Operador confirma
    order.status = Order.StatusChoices.CONFIRMED
    order.total_volumes = 5
    order.confirmed_at = timezone.now()
    order.save()

    # Sync novamente
    importer.save_order(sample_api_order)
    order.refresh_from_db()

    assert order.status == Order.StatusChoices.CONFIRMED
    assert order.confirmed_at is not None

@pytest.mark.django_db
def test_sync_does_not_reset_shipped_status(importer, sample_api_order):
    """RED: Sync NÃO deve resetar status=shipped."""
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345", picking="67890")

    order.status = Order.StatusChoices.SHIPPED
    order.shipped_at = timezone.now()
    order.save()

    importer.save_order(sample_api_order)
    order.refresh_from_db()

    assert order.status == Order.StatusChoices.SHIPPED
    assert order.shipped_at is not None

@pytest.mark.django_db
def test_sync_does_not_overwrite_confirmed_volumes(importer, sample_api_order):
    """RED: total_volumes confirmado pelo operador NÃO deve ser sobrescrito."""
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345", picking="67890")

    order.total_volumes = 7  # operador corrigiu
    order.status = Order.StatusChoices.CONFIRMED
    order.save()

    # API manda orderPackages=3, mas operador confirmou 7
    importer.save_order(sample_api_order)
    order.refresh_from_db()

    assert order.total_volumes == 7

@pytest.mark.django_db
def test_sync_updates_remote_fields(importer, sample_api_order):
    """Campos remotos devem ser atualizados normalmente."""
    importer.save_order(sample_api_order)

    # Alterar dados na API
    sample_api_order["orderStatus"] = "Faturado"
    sample_api_order["invoiceNumber"] = "NF-789"

    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345", picking="67890")

    assert order.situation == "Faturado"
    assert order.invoice_number == "NF-789"

@pytest.mark.django_db
def test_sync_preserves_xlsx_fields(importer, sample_api_order):
    """RED: Campos XLSX não devem ser zerados pela sync."""
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345", picking="67890")

    # Simula dados vindos de XLSX ou edição manual
    order.condition = "30/60/90"
    order.salesperson = "João Silva"
    order.net_weight = 15.5
    order.save()

    importer.save_order(sample_api_order)
    order.refresh_from_db()

    assert order.condition == "30/60/90"
    assert order.salesperson == "João Silva"
    assert float(order.net_weight) == 15.5

@pytest.mark.django_db
def test_full_flow_sync_confirm_ship_resync(importer, sample_api_order):
    """RED: Fluxo completo — sync → confirmar → expedir → resync."""
    # 1. Sync cria pedido
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345", picking="67890")
    assert order.status == Order.StatusChoices.PENDING

    # 2. Operador confirma
    order.status = Order.StatusChoices.CONFIRMED
    order.total_volumes = 5
    order.confirmed_at = timezone.now()
    order.save()

    # 3. Operador expede
    order.status = Order.StatusChoices.SHIPPED
    order.shipped_at = timezone.now()
    order.save()

    confirmed_at_orig = order.confirmed_at
    shipped_at_orig = order.shipped_at

    # 4. Sync roda novamente
    sample_api_order["orderStatus"] = "Faturado"
    importer.save_order(sample_api_order)
    order.refresh_from_db()

    # Tudo deve persistir
    assert order.status == Order.StatusChoices.SHIPPED
    assert order.total_volumes == 5
    assert order.confirmed_at == confirmed_at_orig
    assert order.shipped_at == shipped_at_orig
    assert order.situation == "Faturado"  # campo remoto atualizado

@pytest.mark.django_db
def test_import_orders_stats_correct(importer, sample_api_order):
    """Stats devem diferenciar criados vs atualizados."""
    # Primeira sync: cria
    stats = importer.import_orders([sample_api_order])
    assert stats == {"created": 1, "updated": 0, "errors": 0}

    # Segunda sync: atualiza
    stats = importer.import_orders([sample_api_order])
    assert stats == {"created": 0, "updated": 1, "errors": 0}

@pytest.mark.django_db
def test_sync_updates_volumes_when_pending(importer, sample_api_order):
    """ERP deve poder atualizar volumes se o pedido ainda está PENDING."""
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345")
    assert order.total_volumes == 3

    # ERP muda para 10 volumes
    sample_api_order["orderPackages"] = 10
    importer.save_order(sample_api_order)
    order.refresh_from_db()

    assert order.total_volumes == 10

@pytest.mark.django_db
def test_sync_protects_volumes_when_confirmed(importer, sample_api_order):
    """[RED] ERP NÃO deve sobrescrever volumes se o pedido já foi CONFIRMED."""
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345")
    
    # Operador confirma 5 volumes
    order.status = Order.StatusChoices.CONFIRMED
    order.total_volumes = 5
    order.save()

    # ERP manda 0 volumes (ex: erro no ERP ou re-processamento)
    sample_api_order["orderPackages"] = 0
    importer.save_order(sample_api_order)
    order.refresh_from_db()

    assert order.total_volumes == 5  # Protegido
    assert order.status == Order.StatusChoices.CONFIRMED

@pytest.mark.django_db
def test_sync_does_not_overwrite_sync_status(importer, sample_api_order):
    """[RED] Sync do ERP não deve resetar o erp_volume_sync_status."""
    importer.save_order(sample_api_order)
    order = Order.objects.get(order_number="12345")
    
    order.erp_volume_sync_status = Order.ERPSyncStatus.SENT
    order.save()

    importer.save_order(sample_api_order)
    order.refresh_from_db()

    assert order.erp_volume_sync_status == Order.ERPSyncStatus.SENT
