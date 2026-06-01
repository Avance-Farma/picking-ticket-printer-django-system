from unittest.mock import Mock, patch

import pytest

from apps.erp_sync.services.order_service import ERPOrderService


@pytest.mark.django_db
class TestERPOrderService:

    @patch("apps.erp_sync.services.order_service.requests.get")
    @patch("apps.erp_sync.services.order_service.ERPAuthService.get_valid_token", return_value="tok")
    def test_fetch_orders_with_order_id_sends_correct_params(self, mock_auth, mock_get):
        mock_get.return_value = Mock(status_code=200, json=lambda: [])
        ERPOrderService.fetch_orders(branch_id=27, order_id="12345")
        params = mock_get.call_args[1]["params"]
        
        assert params["relatedOrderId"] == "12345"
        assert "beginDate" not in params
        assert "endDate" not in params
        assert params["relationalBranchId"] == 27

    @patch("apps.erp_sync.services.order_service.requests.get")
    @patch("apps.erp_sync.services.order_service.ERPAuthService.get_valid_token", return_value="tok")
    def test_fetch_orders_with_prenote_id_sends_correct_params(self, mock_auth, mock_get):
        mock_get.return_value = Mock(status_code=200, json=lambda: [])
        ERPOrderService.fetch_orders(branch_id=27, prenote_id="67890")
        params = mock_get.call_args[1]["params"]
        
        assert params["relatedPreNoteId"] == "67890"
        assert "beginDate" not in params
        assert "endDate" not in params

    @patch("apps.erp_sync.services.order_service.requests.get")
    @patch("apps.erp_sync.services.order_service.ERPAuthService.get_valid_token", return_value="tok")
    def test_fetch_orders_with_dates_sends_all_date_params(self, mock_auth, mock_get):
        mock_get.return_value = Mock(status_code=200, json=lambda: [])
        ERPOrderService.fetch_orders(branch_id=27, begin_date="2026-05-10", end_date="2026-05-12", date_type=2)
        params = mock_get.call_args[1]["params"]
        
        assert params["beginDate"] == "2026-05-10"
        assert params["endDate"] == "2026-05-12"
        assert params["dateType"] == 2

    @patch("apps.erp_sync.services.order_service.ERPOrderService.fetch_orders")
    def test_fetch_orders_with_filters_iterates_branch_ids(self, mock_fetch):
        mock_fetch.return_value = []
        ERPOrderService.fetch_orders_with_filters(
            branch_ids=[27, 19], 
            order_id="123"
        )
        assert mock_fetch.call_count == 2
        mock_fetch.assert_any_call(27, order_id="123", begin_date=None, end_date=None, date_type=1, prenote_id=None)
        mock_fetch.assert_any_call(19, order_id="123", begin_date=None, end_date=None, date_type=1, prenote_id=None)

    @patch("apps.erp_sync.services.order_service.requests.get")
    @patch("apps.erp_sync.services.order_service.ERPAuthService.get_valid_token", return_value="tok")
    def test_fetch_orders_legacy_behavior_remains(self, mock_auth, mock_get):
        # O comportamento legado passava date_str como segundo argumento posicional
        mock_get.return_value = Mock(status_code=200, json=lambda: [])
        ERPOrderService.fetch_orders(27, "2026-05-12")
        params = mock_get.call_args[1]["params"]
        
        assert params["beginDate"] == "2026-05-12"
        assert params["endDate"] == "2026-05-12"
        assert params["dateType"] == 1
