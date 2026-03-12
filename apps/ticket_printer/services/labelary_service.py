import logging

import requests

logger = logging.getLogger(__name__)


class LabelaryService:
    """
    Serviço de integração com a API pública do Labelary.
    Gera as etiquetas recebidas (ZPL) num arquivo final (PDF).
    """

    LABELARY_API_URL = "http://api.labelary.com/v1/printers/8dpmm/labels/4x2/"

    @classmethod
    def generate_pdf(cls, zpl_commands: list[str]) -> bytes:
        """
        Gera um PDF enviando os comandos ZPL via Labelary API.

        Se enviada uma lista de strings ZPL, cada item será
        concatenado adequadamente. O Labelary suporta nativamente
        receber múltiplos comandos ^XA ... ^XZ para criar PDFs multi-página.

        Args:
            zpl_commands: Lista de comandos ZPL.

        Returns:
            bytes: O binário contendo os dados do arquivo PDF.

        Raises:
            requests.RequestException se a API do Labelary falhar.
        """
        combined_zpl = "\n".join(zpl_commands)

        headers = {
            "Accept": "application/pdf",
        }

        try:
            response = requests.post(
                cls.LABELARY_API_URL,
                headers=headers,
                data=combined_zpl.encode("utf-8"),
                timeout=12,
            )
            response.raise_for_status()
            logger.info(
                "PDF generated via Labelary API (length=%d)",
                len(response.content),
            )
            return response.content
        except requests.RequestException as e:
            logger.error("Error communicating with Labelary API: %s", e)
            raise
