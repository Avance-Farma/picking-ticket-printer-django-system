"""
ERPAuthService — gerencia autenticação com a API ERP.

Fluxo:
  1. get_valid_token() consulta o cache Redis.
  2. Se não há token ou está próximo de expirar (< TOKEN_REFRESH_MARGIN_SECONDS),
     tenta fazer refresh; se não houver refresh token, faz login completo.
  3. O par (token, refresh_token, expires_at) fica salvo no Redis com TTL.

Configuração (via Django settings):
  ERP_API_BASE_URL    — base URL da API
  ERP_API_USERNAME    — usuário de login
  ERP_API_PASSWORD    — senha de login
"""

import logging
from datetime import UTC, datetime, timedelta

import requests
from django.conf import settings
from django.core.cache import cache

logger = logging.getLogger(__name__)

# ── Constantes ────────────────────────────────────────────────────────────────
CACHE_KEY = "erp_api:token_data"

# Renova o token quando restar menos de X segundos para expirar
TOKEN_REFRESH_MARGIN_SECONDS = 300  # 5 minutos


def _parse_expire_date(expire_date_str: str | None) -> datetime | None:
    """
    Converte a string de expiração retornada pela API para datetime UTC.

    A API retorna no formato: "28/04/2026 18:34:08" (horário local do servidor).
    Tratamos como UTC para simplificar; a margem de 5 min absorve eventuais
    diferenças de fuso.
    """
    if not expire_date_str:
        return None
    for fmt in ("%d/%m/%Y %H:%M:%S", "%d/%m/%Y %H:%M"):
        try:
            naive = datetime.strptime(expire_date_str.strip(), fmt)
            return naive.replace(tzinfo=UTC)
        except ValueError:
            continue
    logger.warning("ERP Auth: formato de expireDate desconhecido: %r", expire_date_str)
    return None


class ERPAuthService:
    """
    Serviço stateless de autenticação.
    Todos os métodos são de classe para facilitar o uso sem instância.
    """

    @classmethod
    def _base_url(cls) -> str:
        return getattr(settings, "ERP_API_BASE_URL", "http://187.117.44.93:55050")

    @classmethod
    def _credentials(cls) -> tuple[str, str]:
        username = getattr(settings, "ERP_API_USERNAME", "avance")
        password = getattr(settings, "ERP_API_PASSWORD", "")
        return username, password

    # ── Login completo ────────────────────────────────────────────────────────

    @classmethod
    def login(cls) -> dict:
        """
        Faz login completo na API e retorna o dict de tokens.

        Retorna:
            {
                "token": str,
                "refresh_token": str,
                "expires_at": datetime (UTC),
            }
        """
        username, password = cls._credentials()
        url = f"{cls._base_url()}/api/Login"
        payload = {"username": username, "password": password}

        logger.info("ERP Auth: realizando login completo...")
        resp = requests.post(url, json=payload, timeout=30)
        resp.raise_for_status()

        data = resp.json()
        token = data["token"]
        refresh_token = data["refreshToken"]
        expires_at = _parse_expire_date(data.get("expireDate")) or (
            datetime.now(UTC) + timedelta(hours=1)
        )

        token_data = {
            "token": token,
            "refresh_token": refresh_token,
            "expires_at": expires_at.isoformat(),
        }

        # Salva no cache até 30s antes da expiração
        ttl = max(int((expires_at - datetime.now(UTC)).total_seconds()) - 30, 60)
        cache.set(CACHE_KEY, token_data, timeout=ttl)

        logger.info(
            "ERP Auth: login OK — expira em %s (TTL cache: %ds)",
            expires_at.isoformat(),
            ttl,
        )
        return token_data

    # ── Refresh token ─────────────────────────────────────────────────────────

    @classmethod
    def refresh(cls, token: str, refresh_token: str) -> dict:
        """
        Renova o token usando o refresh_token.

        Retorna o mesmo formato que login().
        """
        url = f"{cls._base_url()}/api/Login/Refresh"
        headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json",
        }
        payload = {"token": token, "refreshToken": refresh_token}

        logger.info("ERP Auth: renovando token via refresh...")
        resp = requests.post(url, json=payload, headers=headers, timeout=30)
        resp.raise_for_status()

        data = resp.json()
        new_token = data["token"]
        new_refresh = data["refreshToken"]
        expires_at = _parse_expire_date(data.get("expireDate")) or (
            datetime.now(UTC) + timedelta(hours=1)
        )

        token_data = {
            "token": new_token,
            "refresh_token": new_refresh,
            "expires_at": expires_at.isoformat(),
        }

        ttl = max(int((expires_at - datetime.now(UTC)).total_seconds()) - 30, 60)
        cache.set(CACHE_KEY, token_data, timeout=ttl)

        logger.info(
            "ERP Auth: refresh OK — expira em %s (TTL cache: %ds)",
            expires_at.isoformat(),
            ttl,
        )
        return token_data

    # ── Token válido (ponto de entrada principal) ─────────────────────────────

    @classmethod
    def get_valid_token(cls) -> str:
        """
        Retorna um token Bearer válido, renovando automaticamente se necessário.

        Estratégia:
          1. Busca token_data no Redis.
          2. Se não existe → login completo.
          3. Se expira em menos de TOKEN_REFRESH_MARGIN_SECONDS → refresh ou login.
          4. Caso contrário → retorna o token em cache.
        """
        token_data: dict | None = cache.get(CACHE_KEY)

        if token_data is None:
            logger.info("ERP Auth: cache vazio — fazendo login completo.")
            return cls.login()["token"]

        expires_at = datetime.fromisoformat(token_data["expires_at"])
        seconds_left = (expires_at - datetime.now(UTC)).total_seconds()

        if seconds_left < TOKEN_REFRESH_MARGIN_SECONDS:
            logger.info(
                "ERP Auth: token expira em %.0fs — renovando...", seconds_left
            )
            try:
                return cls.refresh(
                    token_data["token"], token_data["refresh_token"]
                )["token"]
            except Exception as exc:
                logger.warning(
                    "ERP Auth: refresh falhou (%s) — fazendo login completo.", exc
                )
                return cls.login()["token"]

        return token_data["token"]

    @classmethod
    def invalidate_cache(cls) -> None:
        """Remove o token do cache (útil em caso de 401 inesperado)."""
        cache.delete(CACHE_KEY)
        logger.info("ERP Auth: cache de token invalidado.")
