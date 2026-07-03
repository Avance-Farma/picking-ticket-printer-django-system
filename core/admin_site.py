"""
SafeAdminSite — a fault-tolerant Django AdminSite for the admin dashboard.

WHY THIS EXISTS
---------------
Django's default AdminSite lets any unhandled exception in the index view
bubble up as a bare, unlogged 500 response.  This is especially painful
when the Unfold DASHBOARD_CALLBACK (core/admin_dashboard.py) raises an
error during startup or on the first request — the admin panel becomes
completely inaccessible with no indication of what went wrong.

SafeAdminSite is the safety net: it wraps the index view in a try-except
so that crashes are caught, logged with a full traceback, and converted
into a friendly error page instead of a silent failure.

WHAT IT DOES
------------
- Overrides AdminSite.index() with a try-except around the parent call.
- On any exception, calls logger.exception() so the full traceback is
  emitted to stdout (captured by Railway / any 12-factor log aggregator).
- Returns an HttpResponseServerError with a simple HTML message so the
  browser receives a meaningful 500 rather than a connection-level error.
- Includes a second fallback in case even the error template fails to
  render (e.g. the template loader itself is broken).

WHAT IT DOESN'T DO
------------------
- It does NOT wrap any other admin views (changelist, change form, etc.).
  Those views have their own error handling and are not affected here.
- It does NOT suppress or swallow exceptions silently — every caught
  exception is logged before the error response is returned.
- It does NOT attempt to recover or retry the failed operation.

HOW IT WORKS WITH PR #76 LOGGING
---------------------------------
PR #76 adds a LOGGING configuration to settings.py that routes all log
output to stdout so Railway captures it even when DEBUG=False.  Without
that configuration, logger.exception() calls here would be silently
discarded in production.  Together, the two changes ensure that:

  1. The admin dashboard never shows a blank 500 page (this file).
  2. The exact exception and traceback are always visible in Railway's
     log stream (PR #76 LOGGING config).

USAGE
-----
Instantiate SafeAdminSite instead of the default AdminSite and register
it in urls.py:

    from core.admin_site import SafeAdminSite
    admin_site = SafeAdminSite(name="admin")
    path("admin/", admin_site.urls),
"""
import logging

from django.contrib.admin import AdminSite
from django.http import HttpResponseServerError
from django.template.response import TemplateResponse

logger = logging.getLogger(__name__)


class SafeAdminSite(AdminSite):
    """
    A Django AdminSite subclass that adds exception handling to the admin
    index (dashboard) view.

    The standard AdminSite.index() propagates any unhandled exception
    directly to Django's 500 handler, which in production returns a bare
    error page with no log output.  SafeAdminSite intercepts those
    exceptions, logs them with full tracebacks via logger.exception(), and
    returns a graceful HttpResponseServerError so the browser always gets a
    meaningful response.

    Scope
    ~~~~~
    Only the index view is wrapped.  All other admin views (changelist,
    add/change forms, delete confirmations, etc.) are inherited unchanged
    from AdminSite and are not affected by this subclass.

    This is intentional: the index view is the only place where the Unfold
    DASHBOARD_CALLBACK is invoked, making it the most likely source of
    startup-time or request-time failures that would otherwise be invisible.

    Logging integration
    ~~~~~~~~~~~~~~~~~~~
    logger.exception() emits the exception message AND the full traceback
    at ERROR level.  When combined with the LOGGING configuration added in
    PR #76 (which routes all output to stdout), every crash in the admin
    dashboard is immediately visible in Railway's log stream without any
    additional configuration.
    """

    def index(self, request, extra_context=None):
        """
        Render the admin index page, catching and logging any exception.

        On success, delegates entirely to the parent AdminSite.index() so
        that all standard Unfold/Django admin behaviour is preserved.

        On failure:
          1. Logs the exception with a full traceback using logger.exception().
          2. Attempts to render the ``admin/error.html`` template with the
             error details so admins see a styled, informative error page.
          3. If the template render itself fails (e.g. the template is
             missing or the template engine is broken), falls back to a
             plain HttpResponseServerError with an inline HTML message.
             This double-fallback ensures a response is always returned.
        """
        try:
            logger.debug("SafeAdminSite.index: entering admin index view.")
            return super().index(request, extra_context=extra_context)
        except Exception as exc:
            # Log the full traceback so it appears in Railway's log stream.
            # logger.exception() automatically appends exc_info, so the
            # complete stack trace is included without any extra work.
            logger.exception(
                "SafeAdminSite.index: unhandled exception in admin index view: %s",
                exc,
            )
            try:
                # Attempt a styled error page using the admin/error.html
                # template.  Passing the exception message lets the template
                # display a human-readable description of what went wrong.
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
                # Last-resort fallback: return a minimal inline HTML response.
                # We deliberately avoid any further template or database calls
                # here because the environment may be in a broken state.
                return HttpResponseServerError(
                    "<h1>500 — Erro interno no painel de administração.</h1>"
                    "<p>Verifique os logs do servidor para mais detalhes.</p>"
                )
