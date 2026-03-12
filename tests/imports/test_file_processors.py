import pytest

from apps.imports.services.file_processors import ExcelProcessor
from apps.imports.services.processor_factory import ProcessorFactory


@pytest.mark.unit
class TestFileProcessors:
    def test_normalize_digits(self):
        # Arrange
        processor = ExcelProcessor()
        raw = "abc-123.45xy"

        # Act
        normalized = processor._normalize_digits(raw)

        # Assert
        assert normalized == "12345"

    def test_try_parse_decimal(self):
        # Arrange
        import decimal

        processor = ExcelProcessor()

        # Act & Assert
        assert processor._try_parse_decimal("1.234,56") == decimal.Decimal(
            "1234.56"
        )
        assert processor._try_parse_decimal("1234.56") == decimal.Decimal(
            "1234.56"
        )
        assert processor._try_parse_decimal("50,5") == decimal.Decimal("50.5")
        assert processor._try_parse_decimal("") == decimal.Decimal("0")

    def test_factory_returns_correct_processor(self):
        # Act & Assert
        from apps.imports.services.file_processors import (
            DocxProcessor,
            PDFProcessor,
        )

        assert isinstance(
            ProcessorFactory.get_processor("file.xlsx"), ExcelProcessor
        )
        assert isinstance(
            ProcessorFactory.get_processor("file.pdf"), PDFProcessor
        )
        assert isinstance(
            ProcessorFactory.get_processor("file.docx"), DocxProcessor
        )

    def test_factory_raises_error_for_invalid_extension(self):
        # Act & Assert
        from apps.imports.services.file_processors import ProcessingError

        with pytest.raises(ProcessingError):
            ProcessorFactory.get_processor("file.txt")
