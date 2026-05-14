import pytest
from datetime import date
from apps.erp_sync.models import ERPSyncLog

@pytest.mark.django_db
class TestERPSyncLog:
    def test_erpsynclog_accepts_null_sync_date(self):
        log = ERPSyncLog.objects.create(sync_date=None, branch_ids="27")
        assert log.pk is not None
        assert log.sync_date is None

    def test_erpsynclog_search_mode_default(self):
        log = ERPSyncLog.objects.create(sync_date=date.today(), branch_ids="27")
        assert log.search_mode == "date"

    def test_erpsynclog_triggered_by_default(self):
        log = ERPSyncLog.objects.create(sync_date=date.today(), branch_ids="27")
        assert log.triggered_by == "auto"

    def test_erpsynclog_search_filters_stores_json(self):
        log = ERPSyncLog.objects.create(
            sync_date=None, branch_ids="27",
            search_mode="order", search_filters={"order_id": "123"}
        )
        assert log.search_filters["order_id"] == "123"

    def test_erpsynclog_allows_duplicate_date_branch(self):
        # Constraint removed — two lines with same date+branch is OK
        ERPSyncLog.objects.create(sync_date=date.today(), branch_ids="27", triggered_by="auto")
        ERPSyncLog.objects.create(sync_date=date.today(), branch_ids="27", triggered_by="manual")
        assert ERPSyncLog.objects.filter(sync_date=date.today()).count() == 2
