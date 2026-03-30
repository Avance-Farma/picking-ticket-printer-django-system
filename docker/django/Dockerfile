# ─── Node.js builder stage (Tailwind CSS) ────────────────────────────────────
FROM node:22-alpine AS node-builder

# Mirror the project layout so the relative @source path in styles.css resolves
# correctly inside the container.
# On the host, styles.css is at:  <project>/theme/static_src/src/styles.css
# @source "../../../**/*"  →  resolves to  <project>/
# Inside the container we replicate this by setting WORKDIR to /app/theme/static_src,
# so that "../../../"  →  /app/  (the project root, containing apps/ and core/).
WORKDIR /app/theme/static_src

# Copy only package manifests first (leverages Docker layer cache)
COPY theme/static_src/package.json theme/static_src/package-lock.json ./

# Install node dependencies
RUN npm ci

# Copy the full theme source (CSS entry point)
COPY theme/static_src/ ./

# Copy templates and Python source so Tailwind can scan for utility classes
COPY apps/ /app/apps/
COPY core/ /app/core/

# Run the production build: cleans dist dir and compiles minified CSS
RUN npm run build

# ─── Base stage ──────────────────────────────────────────────────────────────
FROM python:3.13-slim AS base

# Prevents Python from writing .pyc files and enables stdout/stderr logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_PROJECT_ENVIRONMENT=/app/.venv \
    PATH="/app/.venv/bin:/usr/local/bin:$PATH" \
    STATIC_ROOT=/staticfiles \
    MEDIA_ROOT=/media

# Install uv from the official image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Non-root user created early so COPY --chown can reference it
RUN addgroup --system django && adduser --system --ingroup django django

WORKDIR /app

# Install system dependencies required by psycopg2 and certificate signing
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    openssl \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# ─── Dependencies stage ──────────────────────────────────────────────────────
FROM base AS deps

# Receive build argument to determine if dev dependencies should be installed
ARG INSTALL_DEV=false

# Copy only dependency manifests first (leverages Docker layer cache)
COPY pyproject.toml uv.lock README.md ./

# Conditionally install dependencies (with or without dev group)
RUN if [ "$INSTALL_DEV" = "true" ]; then \
    uv sync --frozen; \
    else \
    uv sync --frozen --no-dev; \
    fi

# ─── Runtime stage ───────────────────────────────────────────────────────────
FROM base AS runtime

# Copy installed virtual environment from deps stage
COPY --from=deps /app/.venv /app/.venv

# Copy application source — owned by the django user from the start
COPY --chown=django:django . .

# Copy pre-built Tailwind CSS from the node-builder stage.
# node-builder built CSS to /app/theme/static_src/../static/css/dist/
# which equals /app/theme/static/css/dist/
COPY --chown=django:django --from=node-builder /app/theme/static/ /app/theme/static/

# Copy entrypoint, convert CRLF→LF (Windows line endings), and set executable
COPY --chown=django:django docker/django/entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh && chmod +x /entrypoint.sh

# Create volume mount points and set ownership to django user
# This allows the named volumes from docker-compose to inherit correct permissions
RUN mkdir -p /staticfiles /media && chown django:django /staticfiles /media

# Ensure upload volume is writable by django user
RUN mkdir -p /app/uploads && chown django:django /app/uploads

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
