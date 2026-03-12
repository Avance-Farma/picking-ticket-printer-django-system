from unittest.mock import patch

import pytest
from django.urls import reverse
from rest_framework.test import APIClient


@pytest.mark.api
class TestConvertZPLToPDFAPI:
    @patch(
        "apps.ticket_printer.services.labelary_service.LabelaryService.generate_pdf"
    )
    def test_convert_zpl_to_pdf_success(
        self, mock_generate_pdf, api_client: APIClient
    ):
        # Arrange
        url = reverse("api-convert-pdf")
        data = {"zpl_commands": ["^XA^FO50,50^ADN,36,20^FDTest^FS^XZ"]}
        mock_generate_pdf.return_value = b"%PDF-1.4 mock pdf content"

        # Act
        response = api_client.post(url, data, format="json")

        # Assert
        assert response.status_code == 200
        assert response.headers["Content-Type"] == "application/pdf"
        assert (
            response.headers["Content-Disposition"]
            == 'attachment; filename="etiquetas.pdf"'
        )
        assert response.content == b"%PDF-1.4 mock pdf content"
        mock_generate_pdf.assert_called_once_with([
            "^XA^FO50,50^ADN,36,20^FDTest^FS^XZ"
        ])

    def test_convert_zpl_to_pdf_invalid_payload_empty(
        self, api_client: APIClient
    ):
        # Arrange
        url = reverse("api-convert-pdf")
        data = {"zpl_commands": []}

        # Act
        response = api_client.post(url, data, format="json")

        # Assert
        assert response.status_code == 400
        assert "error" in response.data

    def test_convert_zpl_to_pdf_invalid_payload_missing(
        self, api_client: APIClient
    ):
        url = reverse("api-convert-pdf")
        data = {}

        response = api_client.post(url, data, format="json")

        assert response.status_code == 400
        assert "error" in response.data

    @patch(
        "apps.ticket_printer.services.labelary_service.LabelaryService.generate_pdf"
    )
    def test_convert_zpl_to_pdf_service_error(
        self, mock_generate_pdf, api_client: APIClient
    ):
        url = reverse("api-convert-pdf")
        data = {"zpl_commands": ["^XA^XZ"]}
        mock_generate_pdf.side_effect = Exception("Service unavailable")

        response = api_client.post(url, data, format="json")

        assert response.status_code == 502
        assert (
            response.data["error"]
            == "Falha de comunicação com o serviço de renderização PDF."
        )
