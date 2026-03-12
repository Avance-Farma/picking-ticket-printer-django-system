from abc import ABC, abstractmethod
from decimal import Decimal, InvalidOperation
from typing import Any

import docx
import pandas as pd
import pdfplumber


class ProcessingError(Exception):
    pass


class FileProcessor(ABC):
    COMMON_LABELS = [
        "Picking",
        "N[º°]",
        "Pedido",
        "Nr",
        "Cliente",
        "Cód. Cliente",
        "CPF/CNPJ",
        "Endereço",
        "Bairro",
        "Cidade",
        "Estado",
        "Cep",
        "Telefone",
        "Ref.",
        "Volumes",
        "Peso Líquido",
        "Transportadora",
        "Entrega",
        "Romaneio",
        "Digitação",
        "Digitacao",
        "Liberação",
        "Liberacao",
        "Pré[ \t]*-?[ \t]*Nota",
        "Pre-Nota",
        "Data Programada",
        "Situação",
        "Situacao",
        "Pendência",
        "Pendencia",
        "NF",
        "Condição",
        "Condicao",
        "Operação",
        "Operacao",
        "Origem",
        "Vendedor",
        "Digitador",
        "Liberador",
        "Veículo",
        "Motorista",
        "Ajudante",
    ]

    @abstractmethod
    def read(self, path: Any) -> dict[str, Any]:
        """Reads a file and returns the standardized order data dictionary."""
        pass

    def _clean_value(self, value: Any) -> str:
        if value is None:
            return ""

        # Converte para string se não for
        s = str(value).strip()

        if not s:
            return ""

        # Tenta encontrar outros labels conhecidos dentro do valor
        import re

        # Busca por label: ou label [espaço] dependendo do contexto
        labels_pattern = r"(?i)(" + "|".join(self.COMMON_LABELS) + r")[:\s]"

        # Loop para limpar labels repetidos ou extras
        while s:
            match = re.search(labels_pattern, s)
            if not match:
                break

            if match.start() == 0:
                # Começa com rótulo, removemos e continuamos
                s = s[match.end() :].strip()
            else:
                # Encontrou rótulo no meio, corta ali
                s = s[: match.start()].strip()
                break

        return s.strip(" :")


class ExcelProcessor(FileProcessor):
    def read(self, path: Any) -> dict[str, Any]:
        try:
            xl = pd.ExcelFile(path)
        except Exception as e:
            msg = f"Could not read the Excel file: {e}"
            raise ProcessingError(msg) from e

        header_df = None
        for sheet_name in xl.sheet_names:
            df = xl.parse(sheet_name, header=None)
            if (
                self._df_contains(df, "DADOS DO PEDIDO")
                or self._df_contains(df, "DADOS")
                or self._df_contains(df, "PEDIDO")
            ):
                header_df = df
                break

        if header_df is None:
            header_df = xl.parse(xl.sheet_names[0], header=None)

        order_data = self._extract_order_data(header_df)

        products = self._extract_products(header_df)
        if products:
            order_data["products"] = products
        else:
            for sheet_name in xl.sheet_names:
                df = xl.parse(sheet_name, header=None)
                products = self._extract_products(df)
                if products:
                    order_data["products"] = products
                    break

        xl.close()
        return order_data

    def _extract_order_data(self, header_df: pd.DataFrame) -> dict[str, Any]:
        cliente_full = (self._find_after(header_df, "Cliente") or "").strip()
        customer_code = (
            self._find_after(header_df, "Cód. Cliente")
            or self._find_after(header_df, "Cod. Cliente")
            or ""
        ).strip()
        customer_name = cliente_full

        if not customer_code and " - " in cliente_full:
            parts = cliente_full.split(" - ", 1)
            customer_code = parts[0].strip()
            customer_name = parts[1].strip()

        return {
            "order_number": self._normalize_digits(
                self._find_after(header_df, "Nº")
                or self._find_after(header_df, "Nr")
                or ""
            ),
            "picking": self._normalize_digits(
                self._find_after(header_df, "Picking") or ""
            ),
            "route": (self._find_after(header_df, "Rota") or "").strip(),
            "customer_code": customer_code,
            "customer_name": customer_name,
            "address_street": (
                self._find_after(header_df, "Endereço")
                or self._find_after(header_df, "Endereco")
                or ""
            ).strip(),
            "address_number": "",
            "address_district": (
                self._find_after(header_df, "Bairro")
                or self._find_after(header_df, "Bairro")
                or ""
            ).strip(),
            "address_state": (
                self._find_after(header_df, "Estado")
                or self._find_after(header_df, "Estado")
                or ""
            ).strip(),
            "address_city": self._clean_value(
                self._find_after(header_df, "Cidade")
            ),
            "address_zip_code": self._clean_value(
                self._find_after(header_df, "Cep")
                or self._find_after(header_df, "CEP")
            ),
            "id_number": self._clean_value(
                self._find_after(header_df, "CPF/CNPJ")
            ),
            "total_volumes": self._try_parse_int(
                self._find_after(header_df, "Volumes")
            ),
            "typing_date": self._clean_value(
                self._find_after(header_df, "Digitação")
                or self._find_after(header_df, "Digitacao")
                or self._find_after(header_df, "Data Digitação")
            ),
            "release_date": self._clean_value(
                self._find_after(header_df, "Liberação")
                or self._find_after(header_df, "Liberacao")
                or self._find_after(header_df, "Data Liberação")
            ),
            "pre_invoice_date": self._clean_value(
                self._find_after(header_df, "Pré - Nota")
                or self._find_after(header_df, "Pré-Nota")
                or self._find_after(header_df, "Pre-Nota")
            ),
            "invoice_number": self._clean_value(
                self._find_after(header_df, "NF")
                or self._find_after(header_df, "NF:")
            ),
            "scheduled_date": self._clean_value(
                self._find_after(header_df, "Data Programada")
                or self._find_after(header_df, "Programada")
            ),
            "condition": self._clean_value(
                self._find_after(header_df, "Condição")
            ),
            "operation": self._clean_value(
                self._find_after(header_df, "Operação")
            ),
            "origin": self._clean_value(self._find_after(header_df, "Origem")),
            "typist": self._clean_value(
                self._find_after(header_df, "Digitador")
            ),
            "salesperson": self._clean_value(
                self._find_after(header_df, "Vendedor")
            ),
            "releaser": self._clean_value(
                self._find_after(header_df, "Liberador")
            ),
            "situation": self._clean_value(
                self._find_after(header_df, "Situação")
            ),
            "pending_payment": self._clean_value(
                self._find_after(header_df, "Pendência")
            ),
            "net_weight": self._find_after(header_df, "Peso Líquido"),
            "phone": self._clean_value(
                self._find_after(header_df, "Telefone")
            ),
            "customer_reference": self._clean_value(
                self._find_after(header_df, "Ref.")
            ),
            "products": [],
        }

    def _df_contains(self, df: pd.DataFrame, needle: str) -> bool:
        needle = needle.strip().lower()
        for col in df.columns:
            mask = (
                df[col].astype(str).str.lower().str.contains(needle, na=False)
            )
            if mask.any():
                return True
        return False

    def _get_str(self, df: pd.DataFrame, r: int, c: int) -> str:
        if 0 <= r < len(df.index) and 0 <= c < len(df.columns):
            val = df.iat[r, c]
            if pd.isna(val):
                return ""
            return str(val)
        return ""

    def _find_after(self, df: pd.DataFrame, label: str) -> str | None:
        lbl = label.strip().lower()
        rows, cols = df.shape
        for r in range(rows):
            for c in range(cols):
                res = self._check_cell_for_label(df, r, c, lbl, cols)
                if res:
                    # Se o resultado for igual ao label, ignorar e
                    # continuar procurando
                    if res.lower().strip(" :") == lbl:
                        continue
                    return res
        return None

    def _check_cell_for_label(
        self, df: pd.DataFrame, r: int, c: int, lbl: str, cols: int
    ) -> str | None:
        raw = self._get_str(df, r, c)
        if not raw or not raw.strip():
            return None

        s = raw.strip()
        low = s.lower()

        if (lbl in ("nº", "nr")) and "nº" in low and ":" in low:
            return self._extract_after_colon(s)

        if self._matches_label(low, lbl):
            after = self._extract_after_colon(s)
            if after:
                return after

            return self._search_adjacent_cells(df, r, c, cols)

        return None

    def _matches_label(self, low: str, lbl: str) -> bool:
        # Rótulos comuns que podem aparecer como valores em outros campos
        # (ex: Origem: Vendedor). Para esses, exigimos o dois pontos ou
        # que não seja a célula inteira sem sinalização.
        ambiguous = [
            "vendedor",
            "digitador",
            "liberador",
            "situação",
            "origem",
            "pendência",
        ]
        if lbl in ambiguous:
            return (lbl + ":") in low or (lbl + " :") in low

        return (
            low.startswith(lbl)
            or (lbl + ":") in low
            or (lbl + " :") in low
            or low == lbl
        )

    def _extract_after_colon(self, s: str) -> str | None:
        idx = s.find(":")
        if 0 <= idx < len(s) - 1:
            after = s[idx + 1 :].strip()
            if after:
                return after
        return None

    def _search_adjacent_cells(
        self, df: pd.DataFrame, r: int, c: int, cols: int
    ) -> str | None:
        # Procuramos até 15 células à frente.
        import re

        labels_pattern = r"(?i)^(" + "|".join(self.COMMON_LABELS) + r")[:\s]"

        for i in range(1, 16):
            if c + i >= cols:
                break
            v = self._get_str(df, r, c + i).strip()
            if v:
                # Se encontrarmos algo que parece ser OUTRO rótulo conhecido,
                # assumimos que o campo atual está vazio e paramos a busca.
                if re.search(labels_pattern, v):
                    return None

                return v
        return None

    def _extract_products(self, df: pd.DataFrame) -> list[dict[str, Any]]:
        header_row, col_cod, col_desc, col_qtd, col_preco = (
            self._find_items_header(df)
        )
        if header_row < 0:
            return []

        items = []
        rows, _ = df.shape
        for r in range(header_row + 1, rows):
            product_code = self._get_str(df, r, col_cod).strip()
            description = self._get_str(df, r, col_desc).strip()
            quantity_str = self._get_str(df, r, col_qtd).strip()

            if not product_code and not description:
                break
            if not description:
                continue

            items.append({
                "product_code": product_code if product_code else None,
                "description": description,
                "quantity": self._try_parse_decimal(quantity_str),
                "price": self._try_parse_decimal(
                    self._get_str(df, r, col_preco).strip()
                )
                if col_preco != -1
                else Decimal("0"),
                "unit": "",
                "source_line": r + 1,
            })
        return items

    def _find_items_header(self, df: pd.DataFrame):
        rows, cols = df.shape
        for r in range(rows):
            header_info = self._analyze_header_row(df, r, cols)
            if header_info:
                return header_info
        return -1, -1, -1, -1, -1

    def _analyze_header_row(self, df: pd.DataFrame, r: int, cols: int):
        col_cod, col_desc, col_qtd, col_preco = -1, -1, -1, -1
        for c in range(cols):
            s = self._get_str(df, r, c).strip().lower()
            if not s:
                continue
            if col_cod == -1 and self._is_code_column(s):
                col_cod = c
            if col_desc == -1 and self._is_desc_column(s):
                col_desc = c
            if col_qtd == -1 and self._is_qtd_column(s):
                col_qtd = c
            if col_preco == -1 and self._is_price_column(s):
                col_preco = c
        if col_cod != -1 and col_desc != -1 and col_qtd != -1:
            return r, col_cod, col_desc, col_qtd, col_preco
        return None

    def _is_code_column(self, s: str) -> bool:
        return "cód" in s or "codigo" in s or s == "cod" or "cod." in s

    def _is_desc_column(self, s: str) -> bool:
        return (
            "descr" in s
            or "descricao" in s
            or "descrição" in s
            or "produto" in s
        )

    def _is_qtd_column(self, s: str) -> bool:
        return s.startswith("qt") or "qtd" in s or "qtde" in s or "quant" in s

    def _is_price_column(self, s: str) -> bool:
        return "preço" in s or "preco" in s

    def _try_parse_int(self, s: str | None) -> int:
        if not s:
            return 0
        try:
            return int(float(s.strip()))
        except ValueError:
            return 0

    def _try_parse_decimal(self, s: str) -> Decimal:
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

    def _normalize_digits(self, s: str) -> str:
        if not s or not s.strip():
            return ""
        digits = "".join(c for c in s if c.isdigit())
        return digits if digits else s.strip()


class PDFProcessor(FileProcessor):
    def read(self, path: Any) -> dict[str, Any]:
        """Reads PDF file and extracts basic order info.

        To be expanded based on PDF layout.
        """
        text = ""
        try:
            with pdfplumber.open(path) as pdf:
                for page in pdf.pages:
                    text += (page.extract_text() or "") + "\n"

            import re

            def extract_regex(pattern, t, default=""):
                match = re.search(pattern, t, re.IGNORECASE)
                return match.group(1).strip() if match else default

            order_data = {
                "order_number": extract_regex(
                    r"(?:Pedido|N[º°]?):\s*([^\s]+)", text
                ),
                "picking": self._clean_value(
                    extract_regex(r"Picking:\s*([^\s]+)", text)
                ),
                "route": self._clean_value(
                    extract_regex(r"Rota:\s*([^\n]+)", text)
                ),
                "customer_code": self._clean_value(
                    extract_regex(r"Cliente:\s*(\d+)", text)
                ),
                "customer_name": self._clean_value(
                    extract_regex(r"Cliente:\s*\d+\s*-\s*([^\n]+)", text)
                ),
                "address_street": self._clean_value(
                    extract_regex(r"Endereço:\s*([^\nBairro:]+)", text)
                ),
                "address_district": self._clean_value(
                    extract_regex(r"Bairro:\s*([^\n]+)", text)
                ),
                "address_state": self._clean_value(
                    extract_regex(r"Estado:\s*([A-Za-z]+)", text)
                ),
                "address_city": self._clean_value(
                    extract_regex(r"Cidade:\s*([^\nEstado:]+)", text)
                ),
                "address_zip_code": self._clean_value(
                    extract_regex(r"Cep:\s*([\d-]+)", text)
                ),
                "id_number": self._clean_value(
                    extract_regex(r"CPF/CNPJ:\s*([\d./-]+)", text)
                ),
                "phone": self._clean_value(
                    extract_regex(r"Telefone:\s*([\d\s-]+)", text)
                ),
                "customer_reference": self._clean_value(
                    extract_regex(r"Ref\.:\s*([^\n]*)", text)
                ),
                "total_volumes": 0,
                "typing_date": self._clean_value(
                    extract_regex(
                        r"Digita[çc][ãa]o:\s*([\d/]+ - [\d:]+)", text
                    )
                ),
                "release_date": self._clean_value(
                    extract_regex(
                        r"Libera[çc][ãa]o:\s*([\d/]+ - [\d:]+)", text
                    )
                ),
                "pre_invoice_date": self._clean_value(
                    extract_regex(
                        r"Pr[ée]\s*-\s*Nota:\s*([\d/]+ - [\d:]+)", text
                    )
                ),
                "invoice_number": self._clean_value(
                    extract_regex(r"NF:\s*([^\n]*)", text)
                ),
                "scheduled_date": self._clean_value(
                    extract_regex(r"Data Programada:\s*([^\n]*)", text)
                ),
                "condition": self._clean_value(
                    extract_regex(
                        r"Condição:\s*([^\n\r]*?)(?=[ \t]{2,}|\r?\n|$)", text
                    )
                ),
                "operation": self._clean_value(
                    extract_regex(
                        r"Operação:\s*([^\n\r]*?)(?=[ \t]{2,}|\r?\n|$)", text
                    )
                ),
                "origin": self._clean_value(
                    extract_regex(
                        r"Origem:[ \t]*([^\n\r]*?(?:(?:\r?\n[ \t]+)"
                        r"(?!Digitador:)[^\n\r]+?)*?)(?=[ \t]{2,}|\r?\n|$)",
                        text,
                    )
                ),
                "typist": self._clean_value(
                    extract_regex(
                        r"Digitador:[ \t]*([^\n\r]*?)(?=[ \t]{2,}|\r?\n|$)",
                        text,
                    )
                ),
                "salesperson": self._clean_value(
                    extract_regex(
                        r"Vendedor:[ \t]*([^\n\r]*?)(?=[ \t]{2,}|\r?\n|$)",
                        text,
                    )
                ),
                "releaser": self._clean_value(
                    extract_regex(
                        r"Liberador:[ \t]*([^\n\r]*?(?:(?:\r?\n[ \t]+)"
                        r"(?!Vendedor:)(?!Volumes:)[^\n\r]+?)*?)"
                        r"(?=[ \t]{2,}|\r?\n|$)",
                        text,
                    )
                ),
                "situation": self._clean_value(
                    extract_regex(r"Situação:\s*([^\s]+)", text)
                ),
                "pending_payment": self._clean_value(
                    extract_regex(
                        r"Pendência:\s*([^\n\r]*?)(?=[ \t]{2,}|\r?\n|$)", text
                    )
                ),
                "net_weight": extract_regex(
                    r"Peso Líquido:\s*([\d,.]+)", text
                ),
                "carrier": extract_regex(r"Transportadora:\s*([^\n]*)", text)
                .split("Entrega:")[0]
                .strip(),
                "delivery": extract_regex(r"Entrega:\s*([^\n]*)", text)
                .split("Romaneio:")[0]
                .strip(),
                "manifest": extract_regex(r"Romaneio:\s*([^\n]*)", text),
                "vehicle": extract_regex(r"Veículo:\s*([^\n]+)", text)
                .split("Motorista:")[0]
                .strip(),
                "driver": extract_regex(r"Motorista:\s*([^\n]+)", text)
                .split("Ajudante:")[0]
                .strip(),
                "helper": extract_regex(r"Ajudante:\s*([^\n]*)", text),
                "products": self._extract_products_regex(text),
            }

            volumes_str = extract_regex(r"Volumes:\s*(\d+)", text)
            if volumes_str:
                order_data["total_volumes"] = int(volumes_str)

        except Exception as e:
            raise ProcessingError(f"Error processing PDF: {e}") from e
        return order_data

    def _extract_products_regex(self, text: str) -> list[dict[str, Any]]:
        """Extrai produtos do texto do PDF usando regex.
        Procura por padrões como: Código Descrição Quantidade
        Exemplo: 12345 PRODUTO TESTE 10,000
        """
        import re

        products = []

        # Padrão: Início da linha ou espaço, seguido por código numérico,
        # seguido por descrição (letras/espaços), seguido por quantidade
        # (número com vírgula/ponto). Este padrão tenta capturar a linha de
        # itens comum em relatórios. Ajustado para ser mais flexível com o
        # que vem depois da quantidade.
        pattern = (
            r"(?m)^\s*(\d{4,10})\s+([A-Z0-9\s\.-]{10,60})\s+(\d+[,.]\d{2,3})"
        )

        matches = re.finditer(pattern, text)
        for match in matches:
            code = match.group(1).strip()
            desc = match.group(2).strip()
            qty_str = match.group(3).strip().replace(",", ".")

            try:
                quantity = Decimal(qty_str)
                products.append({
                    "product_code": code,
                    "description": desc,
                    "quantity": quantity,
                    "price": Decimal(
                        "0.00"
                    ),  # PDF as vezes não tem preço fácil de pegar
                })
            except (InvalidOperation, ValueError):
                continue

        return products


class DocxProcessor(FileProcessor):
    def read(self, path: Any) -> dict[str, Any]:
        """Reads Docx file and extracts basic order info."""
        order_data: dict[str, Any] = {
            "order_number": "",
            "picking": "",
            "route": "",
            "customer_code": "",
            "customer_name": "",
            "address_street": "",
            "address_district": "",
            "address_state": "",
            "address_city": "",
            "address_zip_code": "",
            "id_number": "",
            "phone": "",
            "customer_reference": "",
            "total_volumes": 0,
            "typing_date": None,
            "release_date": None,
            "pre_invoice_date": None,
            "invoice_number": "",
            "scheduled_date": "",
            "condition": "",
            "operation": "",
            "origin": "",
            "typist": "",
            "salesperson": "",
            "releaser": "",
            "situation": "",
            "pending_payment": "",
            "net_weight": 0,
            "carrier": "",
            "delivery": "",
            "manifest": "",
            "vehicle": "",
            "driver": "",
            "helper": "",
            "products": [],
        }
        try:
            doc = docx.Document(path)
            full_text = []
            for para in doc.paragraphs:
                full_text.append(para.text)
            # Add parsing logic...
        except Exception as e:
            raise ProcessingError(f"Error processing DOCX: {e}") from e
        return order_data
