from decimal import Decimal, InvalidOperation
from typing import Any

import pandas as pd
from django.db import transaction

from apps.addresses.models import Address
from apps.customers.models import Customer
from apps.orders.models import Order, OrderItem
from apps.products.models import Product


class ProcessingError(Exception):
    pass


class ExcelReader:
    @staticmethod
    def ler(path: Any) -> dict[str, Any]:
        try:
            dfs = pd.read_excel(path, sheet_name=None, header=None)
        except Exception as e:
            msg = f"Não foi possível ler o arquivo Excel: {e}"
            raise ProcessingError(msg)  # noqa: B904

        header_df = ExcelReader._find_best_header_df(dfs)
        if header_df is None:
            header_df = list(dfs.values())[0]

        date_order = ExcelReader._extract_date_order(header_df)

        for _, df in dfs.products():
            products = ExcelReader._extract_products(df)
            if products:
                date_order["products"] = products
                break

        return date_order

    @staticmethod
    def _extract_date_order(header_df: pd.DataFrame) -> dict[str, Any]:
        return {
            "order_number": ExcelReader._normalize_digits(
                ExcelReader._find_after(header_df, "Nº")
                or ExcelReader._find_after(header_df, "Nr")
                or ""
            ),
            "picking": ExcelReader._normalize_digits(
                ExcelReader._find_after(header_df, "Picking") or ""
            ),
            "route": (
                ExcelReader._find_after(header_df, "Rota") or ""
            ).strip(),  # noqa: E501
            "customer_code": (
                ExcelReader._find_after(header_df, "Cód. Cliente")
                or ExcelReader._find_after(header_df, "Cod. Cliente")
                or ""
            ).strip(),
            "customer_name": (
                ExcelReader._find_after(header_df, "Cliente") or ""
            ).strip(),
            "address_street": (
                ExcelReader._find_after(header_df, "Endereço")
                or ExcelReader._find_after(header_df, "Endereco")
                or ""
            ).strip(),
            "address_number": "",
            "address_district": (
                ExcelReader._find_after(header_df, "Bairro")
                or ExcelReader._find_after(header_df, "Bairro")
                or ""
            ).strip(),
            "address_state": (
                ExcelReader._find_after(header_df, "Estado")
                or ExcelReader._find_after(header_df, "Estado")
                or ""
            ).strip(),
            "address_city": (
                ExcelReader._find_after(header_df, "Cidade") or ""
            ).strip(),
            "address_zip_code": (
                ExcelReader._find_after(header_df, "Cep")
                or ExcelReader._find_after(header_df, "CEP")
                or ""
            ).strip(),
            "id_number": (
                ExcelReader._find_after(header_df, "CPF/CNPJ")
                or ExcelReader._find_after(header_df, "CPF/CNPJ")
                or ""
            ).strip(),
            "total_volumes": ExcelReader._try_parse_int(
                ExcelReader._find_after(header_df, "Volumes")
            ),
            "products": [],
        }

    @staticmethod
    def _find_best_header_df(
        dfs: dict[str, pd.DataFrame],
    ) -> pd.DataFrame | None:
        for df in dfs.values():
            if (
                ExcelReader._df_contains(df, "DADOS DO PEDIDO")
                or ExcelReader._df_contains(df, "DADOS")
                or ExcelReader._df_contains(df, "PEDIDO")
            ):
                return df
        return None

    @staticmethod
    def _df_contains(df: pd.DataFrame, needle: str) -> bool:
        needle = needle.strip().lower()
        for col in df.columns:
            mask = (
                df[col].astype(str).str.lower().str.contains(needle, na=False)
            )
            if mask.any():
                return True
        return False

    @staticmethod
    def _get_str(df: pd.DataFrame, r: int, c: int) -> str:
        if 0 <= r < len(df.index) and 0 <= c < len(df.columns):
            val = df.iat[r, c]
            if pd.isna(val):
                return ""
            return str(val)
        return ""

    @staticmethod
    def _find_after(df: pd.DataFrame, label: str) -> str | None:
        lbl = label.strip().lower()
        rows, cols = df.shape
        for r in range(rows):
            for c in range(cols):
                res = ExcelReader._check_cell_for_label(df, r, c, lbl, cols)
                if res:
                    return res
        return None

    @staticmethod
    def _check_cell_for_label(
        df: pd.DataFrame, r: int, c: int, lbl: str, cols: int
    ) -> str | None:
        raw = ExcelReader._get_str(df, r, c)
        if not raw or not raw.strip():
            return None

        s = raw.strip()
        low = s.lower()

        if (lbl in ("nº", "nr")) and "nº" in low and ":" in low:
            return ExcelReader._extract_after_colon(s)

        if ExcelReader._matches_label(low, lbl):
            after = ExcelReader._extract_after_colon(s)
            if after:
                return after

            return ExcelReader._search_adjacent_cells(df, r, c, cols)

        return None

    @staticmethod
    def _matches_label(low: str, lbl: str) -> bool:
        return (
            low.startswith(lbl)
            or (lbl + ":") in low
            or (lbl + " :") in low
            or low == lbl
        )

    @staticmethod
    def _extract_after_colon(s: str) -> str | None:
        idx = s.find(":")
        if 0 <= idx < len(s) - 1:
            after = s[idx + 1 :].strip()
            if after:
                return after
        return None

    @staticmethod
    def _search_adjacent_cells(
        df: pd.DataFrame, r: int, c: int, cols: int
    ) -> str | None:
        for i in range(1, 21):
            if c + i >= cols:
                break
            v = ExcelReader._get_str(df, r, c + i).strip()
            if v:
                return v
        return None

    @staticmethod
    def _extract_items(df: pd.DataFrame) -> list[dict[str, Any]]:
        header_row, col_cod, col_desc, col_qtd = (
            ExcelReader._find_items_header(df)
        )
        if header_row < 0:
            return []

        itens = []
        rows, _ = df.shape
        for r in range(header_row + 1, rows):
            codigo = ExcelReader._get_str(df, r, col_cod).strip()
            desc = ExcelReader._get_str(df, r, col_desc).strip()
            qtd_str = ExcelReader._get_str(df, r, col_qtd).strip()

            if not codigo and not desc:
                break
            if not desc:
                continue

            itens.append({
                "codigo_produto": codigo if codigo else None,
                "descricao": desc,
                "quantidade": ExcelReader._try_parse_decimal(qtd_str),
                "unidade": "",
                "linha_origem": r + 1,
            })
        return itens

    @staticmethod
    def _find_items_header(df: pd.DataFrame):
        rows, cols = df.shape
        for r in range(rows):
            header_info = ExcelReader._analyze_header_row(df, r, cols)
            if header_info:
                return header_info
        return -1, -1, -1, -1

    @staticmethod
    def _analyze_header_row(df: pd.DataFrame, r: int, cols: int):
        col_cod, col_desc, col_qtd = -1, -1, -1
        for c in range(cols):
            s = ExcelReader._get_str(df, r, c).strip().lower()
            if not s:
                continue
            if col_cod == -1 and ExcelReader._is_code_column(s):
                col_cod = c
            if col_desc == -1 and ExcelReader._is_desc_column(s):
                col_desc = c
            if col_qtd == -1 and ExcelReader._is_qtd_column(s):
                col_qtd = c
        if col_cod != -1 and col_desc != -1 and col_qtd != -1:
            return r, col_cod, col_desc, col_qtd
        return None

    @staticmethod
    def _is_code_column(s: str) -> bool:
        return "cód" in s or "codigo" in s or s == "cod" or "cod." in s

    @staticmethod
    def _is_desc_column(s: str) -> bool:
        return (
            "descr" in s
            or "descricao" in s
            or "descrição" in s
            or "produto" in s
        )

    @staticmethod
    def _is_qtd_column(s: str) -> bool:
        return s.startswith("qt") or "qtd" in s or "qtde" in s or "quant" in s

    @staticmethod
    def _try_parse_int(s: str | None) -> int:
        if not s:
            return 0
        try:
            return int(float(s.strip()))
        except ValueError:
            return 0

    @staticmethod
    def _try_parse_decimal(s: str) -> Decimal:
        if not s or not s.strip():
            return Decimal("0")
        s = s.strip()
        if "," in s and "." in s:
            s = s.replace(".", "").replace(",", ".")
        elif "," in s:
            s = s.replace(",", ".")
        try:
            return Decimal(s)
        except InvalidOperation:
            return Decimal("0")

    @staticmethod
    def _normalize_digits(s: str) -> str:
        if not s or not s.strip():
            return ""
        digits = "".join(c for c in s if c.isdigit())
        return digits if digits else s.strip()


class DatabaseImporter:
    @staticmethod
    def salvar_pedido_completo(pedido_data: dict[str, Any]):
        with transaction.atomic():
            numero_pedido = pedido_data.get("numero_pedido", "")
            picking = pedido_data.get("picking", "")
            cpf_cnpj = pedido_data.get("cpf_cnpj", "")

            # Create or get Address
            address, _ = Address.objects.get_or_create(
                street=pedido_data.get("endereco_logradouro", ""),
                number=pedido_data.get("endereco_numero", ""),
                district=pedido_data.get("endereco_bairro", ""),
                city=pedido_data.get("endereco_cidade", ""),
                state=pedido_data.get("endereco_uf", ""),
                zip_code=pedido_data.get("endereco_cep", ""),
                defaults={"country": "Brasil"},
            )

            # Create or get Customer
            customer_code = pedido_data.get("cliente_codigo", "")
            customer, _ = Customer.objects.get_or_create(
                id_number=cpf_cnpj,
                defaults={
                    "code": customer_code,
                    "name": pedido_data.get("cliente_nome", ""),
                    "address": address,
                },
            )

            order = Order.objects.filter(
                order_number=numero_pedido, picking=picking
            ).first()

            if order:
                # Ao reimportar, zera os volumes confirmados anteriormente
                # para que o operador confirme novamente na tela de expedição.
                OrderItem.objects.filter(order=order).delete()

                order.order_route = pedido_data.get("rota", "")
                order.customer = customer
                order.total_volumes = None
                order.status = "pending"
                order.save()
            else:
                order = Order.objects.create(
                    picking=picking,
                    order_number=numero_pedido,
                    order_route=pedido_data.get("rota", ""),
                    customer=customer,
                )

            itens_data = pedido_data.get("itens", [])
            for item_data in itens_data:
                sku = item_data.get("codigo_produto", "")
                description = item_data.get("descricao", "")

                product, _ = Product.objects.get_or_create(
                    sku=sku,
                    defaults={
                        "description": description,
                        "price": Decimal("0.00"),
                    },
                )

                OrderItem.objects.create(
                    order=order,
                    product=product,
                    quantity=item_data.get("quantidade", 0),
                )

            # Note: We do not trigger Volume creation here,
            # that belongs to VolumeService.
            return order
