from unittest.mock import MagicMock, patch

import pytest
import requests

from apps.ticket_printer.services.labelary_service import LabelaryService


@pytest.mark.unit
class TestLabelaryService:
    @patch("apps.ticket_printer.services.labelary_service.requests.post")
    def test_generate_pdf_success(self, mock_post):
        # Arrange
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.content = b"PDF Content Bytes"
        mock_post.return_value = mock_response

        # Act
        zpl_commands = ["^XA^FD1^FS^XZ", "^XA^FD2^FS^XZ"]
        result = LabelaryService.generate_pdf(zpl_commands)

        # Assert
        assert result == b"PDF Content Bytes"
        mock_post.assert_called_once()
        args, kwargs = mock_post.call_args
        assert (
            args[0] == "http://api.labelary.com/v1/printers/8dpmm/labels/4x2/"
        )
        assert kwargs["headers"]["Accept"] == "application/pdf"
        assert kwargs["data"] == b"^XA^FD1^FS^XZ\n^XA^FD2^FS^XZ"

    @patch("apps.ticket_printer.services.labelary_service.requests.post")
    def test_generate_pdf_http_error(self, mock_post):
        # Arrange
        mock_response = MagicMock()
        mock_response.raise_for_status.side_effect = (
            requests.exceptions.HTTPError("404 Client Error")
        )
        mock_post.return_value = mock_response

        # Act & Assert
        with pytest.raises(requests.exceptions.HTTPError):
            LabelaryService.generate_pdf(["^XA^XZ"])

    @patch("apps.ticket_printer.services.labelary_service.requests.post")
    def test_generate_pdf_connection_error(self, mock_post):
        # Arrange
        mock_post.side_effect = requests.exceptions.ConnectionError(
            "Connection Failed"
        )

        # Act & Assert
        with pytest.raises(requests.exceptions.ConnectionError):
            LabelaryService.generate_pdf(["^XA^XZ"])
