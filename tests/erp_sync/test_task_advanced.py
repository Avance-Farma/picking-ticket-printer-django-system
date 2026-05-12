import pytest
from unittest.mock import patch, Mock
from apps.erp_sync.tasks import sync_erp_orders_task
from apps.erp_sync.models import ERPSyncLog
from datetime import date

@pytest.mark.django_db
class TestSyncERPOrdersTaskAdvanced:

    @patch("apps.erp_sync.tasks.ERPOrderService.fetch_orders_for_all_branches")
    def test_task_without_search_mode_uses_legacy_path(self, mock_fetch):
        mock_fetch.return_value = []
        sync_erp_orders_task(sync_date="2026-05-12")
        mock_fetch.assert_called_once_with("2026-05-12")

    @patch("apps.erp_sync.tasks.ERPOrderService.fetch_orders_with_filters")
    def test_task_with_search_mode_date_uses_filters(self, mock_fetch_filters):
        mock_fetch_filters.return_value = []
        sync_erp_orders_task(
            search_mode="date",
            begin_date="2026-05-10",
            end_date="2026-05-12",
            date_type=2
        )
        mock_fetch_filters.assert_called_once()
        args, kwargs = mock_fetch_filters.call_args
        assert kwargs["begin_date"] == "2026-05-10"
        assert kwargs["end_date"] == "2026-05-12"
        assert kwargs["date_type"] == 2

    @patch("apps.erp_sync.tasks.ERPOrderService.fetch_orders_with_filters")
    def test_task_with_search_mode_order_uses_filters(self, mock_fetch_filters):
        mock_fetch_filters.return_value = []
        sync_erp_orders_task(
            search_mode="order",
            order_id="12345"
        )
        mock_fetch_filters.assert_called_once()
        assert mock_fetch_filters.call_args[1]["order_id"] == "12345"

    @patch("apps.erp_sync.tasks.ERPOrderService.fetch_orders_with_filters")
    @patch("apps.erp_sync.tasks.ERPOrderImporter.import_orders")
    def test_task_saves_log_with_search_mode_and_filters(self, mock_import, mock_fetch_filters):
        mock_fetch_filters.return_value = [{"order": "data"}]
        mock_import.return_value = {"created": 1, "updated": 0, "errors": 0}
        
        sync_erp_orders_task(
            search_mode="order",
            order_id="999",
            branch_ids_override=[27]
        )
        
        log = ERPSyncLog.objects.first()
        assert log.search_mode == "order"
        assert log.search_filters == {
            "begin_date": None,
            "end_date": None,
            "date_type": 1,
            "order_id": "999",
            "prenote_id": None,
        }
        assert log.branch_ids == "27"


    @patch("apps.erp_sync.tasks.ERPOrderService.fetch_orders_with_filters")
    def test_task_with_branch_ids_override(self, mock_fetch_filters):
        mock_fetch_filters.return_value = []
        sync_erp_orders_task(
            search_mode="date",
            begin_date="2026-05-12",
            end_date="2026-05-12",
            branch_ids_override=[27]
        )
        assert mock_fetch_filters.call_args[1]["branch_ids"] == [27]
