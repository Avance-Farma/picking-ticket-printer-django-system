# ─── MkDocs Documentation Server ─────────────────────────────────────────────
# Lightweight image dedicated to serving project documentation.
FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install uv for fast dependency management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy dependency manifests and install WITH dev deps (mkdocs lives there)
COPY pyproject.toml uv.lock README.md ./
RUN uv sync --frozen

# Copy documentation source and config
COPY docs/ ./docs/
COPY mkdocs.yml ./

# Non-root user
RUN addgroup --system docs && adduser --system --ingroup docs docs
USER docs

EXPOSE 8001

CMD ["/app/.venv/bin/mkdocs", "serve", "-a", "0.0.0.0:8001"]
