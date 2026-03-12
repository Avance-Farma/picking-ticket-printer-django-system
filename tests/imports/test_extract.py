import re

import pandas as pd
import pdfplumber


class ExcelExtractorTester:
    def __init__(self, path):
        self.path = path

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
            if pd.isna(val) or val is None:
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
            idx = s.find(":")
            return s[idx + 1 :].strip() if idx >= 0 else None

        if (
            low.startswith(lbl)
            or (lbl + ":") in low
            or (lbl + " :") in low
            or low == lbl
        ):
            idx = s.find(":")
            if 0 <= idx < len(s) - 1:
                after = s[idx + 1 :].strip()
                if after:
                    return after
            for i in range(1, 21):
                if c + i >= cols:
                    break
                v = self._get_str(df, r, c + i).strip()
                if v:
                    return v
        return None

    def read(self):
        xl = pd.ExcelFile(self.path)
        header_df = None
        for sheet_name in xl.sheet_names:
            df = xl.parse(sheet_name, header=None)
            if self._df_contains(df, "DADOS DO PEDIDO"):
                header_df = df
                break

        # New fields extraction
        d = {
            "typing_date": self._find_after(header_df, "Digitação"),
            "release_date": self._find_after(header_df, "Liberação"),
            "pre_invoice_date": self._find_after(header_df, "Pré - Nota"),
            "invoice_number": self._find_after(header_df, "NF"),
            "scheduled_date": self._find_after(header_df, "Data Programada"),
            "condition": self._find_after(header_df, "Condição"),
            "operation": self._find_after(header_df, "Operação"),
            "origin": self._find_after(header_df, "Origem"),
            "typist": self._find_after(header_df, "Digitador"),
            "salesperson": self._find_after(header_df, "Vendedor"),
            "releaser": self._find_after(header_df, "Liberador"),
            "status": self._find_after(header_df, "Situação"),
            "pending_payment": self._find_after(header_df, "Pendência"),
            "net_weight": self._find_after(header_df, "Peso Líquido"),
            "phone": self._find_after(header_df, "Telefone"),
            "customer_reference": self._find_after(header_df, "Ref."),
        }
        print("XLS Extraction:")
        for k, v in d.items():
            print(f"  {k}: {v}")


class PDFExtractorTester:
    def __init__(self, path):
        self.path = path

    def read(self):
        text = ""
        with pdfplumber.open(self.path) as pdf:
            for page in pdf.pages:
                text += (page.extract_text() or "") + "\n"

        # very basic regex extraction
        def find_after(label, text, eol=False):
            # looks for label: <value>
            # pattern = rf"{label}:\s*(.*)"
            # some labels might not have colon
            if not eol:
                pattern = rf"{label}:?\s+([^\n]+)"
            else:
                pattern = rf"{label}:?\s*(.*)$"
            match = re.search(pattern, text, re.MULTILINE | re.IGNORECASE)
            if match:
                return match.group(1).strip()
            return None

        # Custom extraction based on observed text
        def extract_regex(pattern):
            match = re.search(pattern, text, re.IGNORECASE)
            return match.group(1).strip() if match else None

        d = {
            "typing_date": extract_regex(r"Digitação:\s*([\d/]+ - [\d:]+)"),
            "release_date": extract_regex(r"Liberação:\s*([\d/]+ - [\d:]+)"),
            "pre_invoice_date": extract_regex(
                r"Pré - Nota:\s*([\d/]+ - [\d:]+)"
            ),
            "invoice_number": extract_regex(r"NF:\s*([^\n]*)"),
            "scheduled_date": extract_regex(r"Data Programada:\s*([^\n]*)"),
            "condition": extract_regex(r"Condição:\s*([^\n]+)"),
            "operation": extract_regex(r"Operação:\s*([^\n]+)"),
            "origin": extract_regex(r"Origem:\s*([^\n]+)"),
            "typist": extract_regex(r"Digitador:\s*([^\n]+)"),
            "salesperson": extract_regex(r"Vendedor:\s*([^\n]+)"),
            "releaser": extract_regex(r"Liberador:\s*([^\n]+)"),
            "status": extract_regex(r"Situação:\s*([^\s]+)"),
            "pending_payment": extract_regex(r"Pendência:\s*([^\n]+)"),
            "net_weight": extract_regex(r"Peso Líquido:\s*([\d,.]+)"),
            "phone": extract_regex(r"Telefone:\s*([\d \-]+)"),
            "customer_reference": extract_regex(r"Ref\.:\s*([^\n]*)"),
            "carrier": extract_regex(r"Transportadora:\s*([^\n]*)"),
            "delivery": extract_regex(r"Entrega:\s*([^\n]*)"),
            "manifest": extract_regex(r"Romaneio:\s*([^\n]*)"),
            "vehicle": extract_regex(r"Veículo:\s*([^\n]+)"),
            "driver": extract_regex(r"Motorista:\s*([^\n]+)"),
            "helper": extract_regex(r"Ajudante:\s*([^\n]*)"),
            "route": extract_regex(r"Rota:\s*([^\n]+)"),
        }

        print("PDF Extraction:")
        for k, v in d.items():
            print(f"  {k}: {v}")


print("Testing XLS...")
ExcelExtractorTester("data/0442739.xls").read()
print("Testing PDF...")
PDFExtractorTester("data/0442739.pdf").read()
