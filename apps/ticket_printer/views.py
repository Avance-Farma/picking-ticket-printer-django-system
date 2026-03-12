import base64
import logging
import os

import sentry_sdk
from django.conf import settings
from django.http import HttpResponse
from django.views import View

logger = logging.getLogger(__name__)

CERTS_DIR = os.path.join(settings.BASE_DIR, "certs")
TYPE_CONTENT = "text/plain"


class QzCertificateView(View):
    """
    Class-Based View (Django) para servir o certificado QZ Tray.
    """

    def get(self, request, *args, **kwargs):
        cert_path = os.path.join(CERTS_DIR, "digital-certificate.txt")
        try:
            with open(cert_path) as f:
                return HttpResponse(f.read(), content_type=TYPE_CONTENT)
        except FileNotFoundError:
            return HttpResponse("", content_type=TYPE_CONTENT, status=404)


class QzSignView(View):
    """
    Class-Based View para assinatura digital QZ Tray. Post de dados raw.
    """

    def post(self, request, *args, **kwargs):
        to_sign = request.body
        key_path = os.path.join(CERTS_DIR, "private-key.pem")

        if not os.path.exists(key_path):
            return HttpResponse("Private key not found", status=404)

        try:
            from cryptography.hazmat.primitives import hashes, serialization
            from cryptography.hazmat.primitives.asymmetric import (
                padding as asym_padding,
            )

            with open(key_path, "rb") as f:
                private_key = serialization.load_pem_private_key(
                    f.read(), password=None
                )

            sig = private_key.sign(
                to_sign, asym_padding.PKCS1v15(), hashes.SHA1()
            )
            return HttpResponse(
                base64.b64encode(sig).decode("ascii"),
                content_type=TYPE_CONTENT,
            )

        except ImportError as e:
            logger.critical(
                "Cryptography library is missing. QZ Tray signatures cannot be generated."  # noqa: E501
            )
            sentry_sdk.capture_exception(e)
            return HttpResponse(
                "Cryptography library is not available, signature failed.",
                status=500,
            )

        except Exception as e:
            logger.exception("Failed to sign request for QZ Tray")
            sentry_sdk.capture_exception(e)
            return HttpResponse(
                "Internal Error generating signature", status=500
            )
