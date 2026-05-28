"""
ERPOrderImporter — converte o JSON da API ERP e salva no banco de dados.

Segue o mesmo padrão do DatabaseImporter (apps/imports/services/db_importer.py),
reutilizando os mesmos modelos: Address, Customer, Delivery, Order, OrderItem, Product.

Mapeamento de campos:
┌─────────────────────────────────┬──────────────────────────────────────────┐
│ Campo da API                    │ Campo no modelo                          │
├─────────────────────────────────┼──────────────────────────────────────────┤
│ clientId                        │ Customer.code + Customer.id_number       │
│ clientName                      │ Customer.name                            │
│ clientState                     │ Address.state                            │
│ clientCity                      │ Address.city                             │
│ clientZipCode                   │ Address.zip_code                         │
│ clientNeighborhood              │ Address.district                         │
│ clientAddress                   │ Address.street                           │
│ clientAddressNumber             │ Address.number                           │
│ clientAddressComplement         │ Address.complement                       │
│ clientRoute                     │ Delivery.route                           │
│ orderId                         │ Order.order_number                       │
│ preNoteId                       │ Order.picking                            │
│ orderDate                       │ Order.typing_date                        │
│ preNoteDate                     │ Order.pre_invoice_date                   │
│ scheduledDate                   │ Order.scheduled_date                     │
│ orderPackages                   │ Order.total_volumes                      │
│ orderStatus                     │ Order.situation                          │
│ invoiceNumber                   │ Order.invoice_number                     │
│ invoiceValue                    │ (reservado para uso futuro)              │
│ invoiceAccessKey                │ (reservado para uso futuro)              │
│ items[].productId               │ Product.sku_code                         │
│ items[].product                 │ Product.description                      │
│ items[].quantity                │ OrderItem.quantity                       │
│ items[].barCode                 │ (reservado para uso futuro)              │
│ stockBranchId                   │ (reservado para uso futuro)              │
│ stockBranchName                 │ (reservado para uso futuro)              │
└─────────────────────────────────┴──────────────────────────────────────────┘

Campos marcados como "reservado para uso futuro" estão mapeados no código mas
ignorados por ora — assim que a API começar a retorná-los com dados relevantes,
basta descomentar/ativar as linhas correspondentes.
"""

import logging
from datetime import datetime
from decimal import Decimal
from typing import Any

from django.db import IntegrityError, transaction
from django.utils.timezone import make_aware

from apps.addresses.models import Address
from apps.customers.models import Customer
from apps.deliveries.models import Delivery
from apps.orders.models import Order, OrderItem
from apps.products.models import Product

logger = logging.getLogger(__name__)


# ── Utilitários de parsing ────────────────────────────────────────────────────


def _parse_api_datetime(value: str | None) -> datetime | None:
    """
    Converte datas retornadas pela API (ISO 8601 ou datetime com fuso).

    Exemplos: "2026-04-28T10:56:00", "2026-04-28T13:52:00"
    """
    if not value:
        return None
    value = str(value).strip()
    formats = [
        "%Y-%m-%dT%H:%M:%S",
        "%Y-%m-%dT%H:%M",
        "%Y-%m-%d %H:%M:%S",
        "%Y-%m-%d",
    ]
    for fmt in formats:
        try:
            naive = datetime.strptime(value, fmt)
            return make_aware(naive)
        except ValueError:
            continue
    logger.warning("ERP Importer: não foi possível parsear data: %r", value)
    return None


def _to_str(value: Any) -> str:
    """Converte qualquer valor para string segura (None → '')."""
    if value is None:
        return ""
    return str(value).strip()


def _to_int(value: Any) -> int | None:
    """Converte valor para inteiro, retornando None em caso de falha."""
    if value is None:
        return None
    try:
        return int(value)
    except (TypeError, ValueError):
        return None


def _to_decimal(value: Any) -> Decimal:
    """Converte valor para Decimal, retornando Decimal('0') em caso de falha."""
    if value is None:
        return Decimal("0")
    try:
        return Decimal(str(value))
    except Exception:
        return Decimal("0")


# ── Importer principal ────────────────────────────────────────────────────────


class ERPOrderImporter:
    """
    Converte pedidos recebidos da API ERP e persiste no banco de dados.

    Uso:
        importer = ERPOrderImporter()
        stats = importer.import_orders(orders_json)
        # stats = {"created": int, "updated": int, "errors": int}
    """

    def import_orders(self, orders: list[dict]) -> dict[str, int]:
        """
        Itera sobre a lista de pedidos e chama save_order() para cada um.

        Retorna um dict com contadores: created, updated, errors.
        """
        stats = {"created": 0, "updated": 0, "errors": 0}

        for order_json in orders:
            order_id = order_json.get("orderId", "?")
            try:
                _, created = self.save_order(order_json)
                if created:
                    stats["created"] += 1
                else:
                    stats["updated"] += 1
            except IntegrityError:
                logger.exception(
                    "ERP Importer: IntegrityError ao salvar orderId=%s", order_id
                )
                stats["errors"] += 1
            except Exception:
                logger.exception(
                    "ERP Importer: erro inesperado ao salvar orderId=%s", order_id
                )
                stats["errors"] += 1

        logger.info(
            "ERP Importer: concluído — criados=%d atualizados=%d erros=%d",
            stats["created"],
            stats["updated"],
            stats["errors"],
        )
        return stats

    @staticmethod
    def save_order(order_json: dict) -> tuple[Order, bool]:
        """
        Cria ou atualiza um pedido e seus itens a partir do JSON da API.

        Retorna:
            (order, created) — igual à semântica do update_or_create do Django.

        Campos mapeados mas reservados para uso futuro (API ainda não retorna
        ou não são relevantes agora) estão comentados com "# [FUTURO]".
        """
        with transaction.atomic():
            # ── Chaves de negócio ─────────────────────────────────────────────
            order_number = _to_str(order_json.get("orderId"))
            picking = _to_str(order_json.get("preNoteId"))

            # ── Endereço ──────────────────────────────────────────────────────
            street = _to_str(order_json.get("clientAddress"))
            number = _to_str(order_json.get("clientAddressNumber"))
            complement = _to_str(order_json.get("clientAddressComplement"))
            district = _to_str(order_json.get("clientNeighborhood"))
            city = _to_str(order_json.get("clientCity"))
            state = _to_str(order_json.get("clientState"))
            zip_code = _to_str(order_json.get("clientZipCode"))

            address, _ = Address.objects.update_or_create(
                street=street,
                number=number,
                district=district,
                city=city,
                state=state,
                zip_code=zip_code,
                defaults={
                    "complement": complement,
                    "country": "Brasil",
                },
            )

            # ── Cliente ───────────────────────────────────────────────────────
            client_id = _to_str(order_json.get("clientId"))
            client_name = _to_str(order_json.get("clientName"))

            # id_number = CPF/CNPJ — a API ainda não retorna esse campo.
            # Usamos o clientId como chave temporária para manter a unicidade.
            # [FUTURO] Substituir por: _to_str(order_json.get("clientCnpj"))
            id_number_fallback = client_id

            customer, _ = Customer.objects.update_or_create(
                id_number=id_number_fallback,
                defaults={
                    "code": client_id,
                    "name": client_name,
                    "address": address,
                    # [FUTURO] "phone": _to_str(order_json.get("clientPhone")),
                    "phone": _to_str(order_json.get("clientPhone")),
                },
            )

            # ── Entrega / Romaneio ────────────────────────────────────────────
            route = _to_str(order_json.get("clientRoute"))

            delivery: Delivery | None = None
            if route:
                # [FUTURO] Quando a API retornar carrier/manifest/vehicle/driver/helper:
                # carrier  = _to_str(order_json.get("carrier"))
                # manifest = _to_str(order_json.get("manifest"))
                # if carrier or manifest:
                #     delivery, _ = Delivery.objects.update_or_create(
                #         manifest=manifest, carrier=carrier,
                #         defaults={"route": route, ...}
                #     )
                # else:
                delivery, _ = Delivery.objects.update_or_create(
                    route=route,
                    defaults={
                        # [FUTURO] "vehicle": _to_str(order_json.get("vehicle")),
                        # [FUTURO] "driver":  _to_str(order_json.get("driver")),
                        # [FUTURO] "helper":  _to_str(order_json.get("helper")),
                        "vehicle": "",
                        "driver": "",
                        "helper": "",
                    },
                )

            # ── Pedido ────────────────────────────────────────────────────────
            invoice_number = _to_str(order_json.get("invoiceNumber"))
            order_status_api = _to_str(order_json.get("orderStatus"))

            # [FUTURO] Quando a API retornar peso, condição, operação, etc.:
            # net_weight   = _to_decimal(order_json.get("netWeight"))
            # condition    = _to_str(order_json.get("condition"))
            # operation    = _to_str(order_json.get("operation"))
            # origin       = _to_str(order_json.get("origin"))
            # typist       = _to_str(order_json.get("typist"))
            # salesperson  = _to_str(order_json.get("salesperson"))
            # releaser     = _to_str(order_json.get("releaser"))
            # pending_payment = _to_str(order_json.get("pendingPayment"))

            # invoiceValue e invoiceAccessKey: reservados para uso futuro
            # [FUTURO] invoice_value  = _to_decimal(order_json.get("invoiceValue"))
            # [FUTURO] invoice_access_key = _to_str(order_json.get("invoiceAccessKey"))

            # ── Campos remotos (vindos da API ERP) ────────────────────────────
            remote_fields = {
                "customer": customer,
                "delivery": delivery,
                "import_source": "api",
                "situation": order_status_api,
                "invoice_number": invoice_number,
                "typing_date": _parse_api_datetime(order_json.get("orderDate")),
                "pre_invoice_date": _parse_api_datetime(
                    order_json.get("preNoteDate")
                ),
                "scheduled_date": _to_str(
                    order_json.get("scheduledDate") or ""
                ),
            }

            existing = Order.objects.filter(
                order_number=order_number, picking=picking,
            ).first()

            if existing is None:
                order = Order.objects.create(
                    order_number=order_number,
                    picking=picking,
                    status=Order.StatusChoices.PENDING,
                    total_volumes=_to_int(order_json.get("orderPackages")),
                    release_date=None,
                    condition="",
                    operation="",
                    origin="",
                    typist="",
                    salesperson="",
                    releaser="",
                    pending_payment="",
                    net_weight=None,
                    **remote_fields,
                )
                created = True
            else:
                # Atualiza campos remotos básicos
                for field, value in remote_fields.items():
                    setattr(existing, field, value)

                # Campos locais (picking): permitir atualização se ainda for PENDING,
                # mas proteger se já estiver CONFIRMED ou SHIPPED.
                update_fields = [*remote_fields.keys(), "updated_at"]
                
                if existing.status == Order.StatusChoices.PENDING:
                    new_volumes = _to_int(order_json.get("orderPackages"))
                    if new_volumes is not None and existing.total_volumes != new_volumes:
                        existing.total_volumes = new_volumes
                        update_fields.append("total_volumes")
                
                # Garantir que erp_volume_sync_status NUNCA seja sobrescrito pelo ERP
                # (já está fora do remote_fields, mas adicionamos esta nota por clareza)

                existing.save(update_fields=update_fields)
                order = existing
                created = False

            # ── Itens do pedido ───────────────────────────────────────────────
            # Apaga os itens anteriores para reimportar (mesmo padrão do XLSX)
            OrderItem.objects.filter(order=order).delete()

            items: list[dict] = order_json.get("items") or []
            # Ordena por SKU para evitar deadlocks em transações paralelas
            items_sorted = sorted(
                items,
                key=lambda x: _to_str(x.get("productId")),
            )

            for item in items_sorted:
                # productId pode vir como string ou número
                sku_code = _to_str(item.get("productId"))
                if not sku_code:
                    continue

                description = _to_str(item.get("product"))
                quantity = _to_decimal(item.get("quantity", 0))

                # [FUTURO] barCode = _to_str(item.get("barCode"))
                # [FUTURO] unitPrice = _to_decimal(item.get("unitPrice"))

                product, _ = Product.objects.update_or_create(
                    sku_code=sku_code,
                    defaults={
                        "description": description[:100] if description else "",
                        "price": Decimal("0.00"),  # API não retorna preço por item
                    },
                )

                OrderItem.objects.create(
                    order=order,
                    product=product,
                    quantity=quantity,
                )

        action = "criado" if created else "atualizado"
        logger.debug(
            "ERP Importer: pedido orderId=%s preNoteId=%s %s com %d item(s).",
            order_number,
            picking,
            action,
            len(items),
        )
        return order, created
