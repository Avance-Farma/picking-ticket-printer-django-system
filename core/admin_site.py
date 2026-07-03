"""
Custom AdminSite that wraps the index view with error handling so that
initialization-time exceptions produce a useful log entry instead of a
bare 500 response.
"""
import logging

from django.contrib.admin import AdminSite
from django.http import HttpResponseServerError
from django.template.response import TemplateResponse

logger = logging.getLogger(__name__)


class SafeAdminSite(AdminSite):
    """
    An AdminSite subclass that catches unhandled exceptions in the index
    view and logs them with full tracebacks before returning a graceful
    error response.  All other admin views are unaffected — only the
    dashboard entry-point is wrapped here because that is where the
    Unfold DASHBOARD_CALLBACK is invoked.
    """

    def index(self, request, extra_context=None):
        try:
            logger.debug("SafeAdminSite.index: entering admin index view.")
            return super().index(request, extra_context=extra_context)
        except Exception as exc:
            logger.exception(
                "SafeAdminSite.index: unhandled exception in admin index view: %s",
                exc,
            )
            try:
                return TemplateResponse(
                    request,
                    "admin/error.html",
                    {
                        "title": "Erro no Painel",
                        "error": str(exc),
                    },
                    status=500,
                )
            except Exception:
                # Fallback if the error template itself is missing
                return HttpResponseServerError(
                    "<h1>500 — Erro interno no painel de administração.</h1>"
                    "<p>Verifique os logs do servidor para mais detalhes.</p>"
                )
