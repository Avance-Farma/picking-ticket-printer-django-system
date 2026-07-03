import logging
import traceback

from django.contrib.admin import AdminSite
from django.http import HttpResponseServerError
from django.template.loader import render_to_string

logger = logging.getLogger(__name__)


class SafeAdminSite(AdminSite):
    """
    A custom AdminSite that wraps the admin index view with error handling
    and structured logging.

    Any unhandled exception raised while rendering the admin index is caught
    here, logged with a full traceback, and a graceful 500 response is
    returned instead of letting Django's bare error handler take over.
    This makes production debugging significantly easier.
    """

    def index(self, request, extra_context=None):
        try:
            return super().index(request, extra_context=extra_context)
        except Exception as exc:
            logger.error(
                "SafeAdminSite: unhandled exception in admin index view: %s\n%s",
                exc,
                traceback.format_exc(),
            )
            try:
                html = render_to_string(
                    "admin/500.html",
                    request=request,
                )
            except Exception:
                html = (
                    "<h1>Erro interno do servidor</h1>"
                    "<p>Ocorreu um erro inesperado. "
                    "Consulte os logs para mais detalhes.</p>"
                )
            return HttpResponseServerError(html)
