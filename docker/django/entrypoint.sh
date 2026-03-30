#!/bin/sh
set -e

# Fix volume permissions if running as root (Railway volumes are mounted as root)
if [ "$(id -u)" = "0" ]; then
  chmod 755 /app/uploads 2>/dev/null || true
  chown -R django:django /app/uploads 2>/dev/null || true
fi

# ─── Apply database migrations & collect static files ────────────────────────
# On Railway, these are handled by the preDeployCommand in railway.toml.
# RAILWAY_ENVIRONMENT_NAME is automatically set by Railway.
if [ -z "$RAILWAY_ENVIRONMENT_NAME" ]; then
  # ─── Wait for PostgreSQL to be available ─────────────────────────────────────
  echo "Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT}..."
  until python -c "
import socket, sys
try:
    s = socket.create_connection(('${DB_HOST}', int('${DB_PORT}')), timeout=2)
    s.close()
    sys.exit(0)
except Exception:
    sys.exit(1)
" 2>/dev/null; do
    echo "  → PostgreSQL not ready yet, retrying in 2s..."
    sleep 2
  done
  echo "PostgreSQL is available!"

  echo "Running migrations..."
  python manage.py migrate --fake-initial --noinput

  echo "Collecting static files..."
  python manage.py collectstatic --noinput --clear
else
  echo "Railway environment detected — migrations handled by preDeployCommand"
fi
# ─── Start Application ────────────────────────────────────────────────────────
# If a command is passed to the container, execute it instead of the default uvicorn
if [ $# -gt 0 ]; then
  echo "Executing command: $@"
  exec "$@"
fi

# In Development we want reload enabled, in Production we run it normally
if [ "$DJANGO_ENV" = "development" ]; then
  echo "Starting Uvicorn in RELOAD mode (Development)..."
  exec uvicorn core.asgi:application \
    --host 0.0.0.0 \
    --port ${PORT:-8000} \
    --reload \
    --log-level ${UVICORN_LOG_LEVEL:-info}
else
  echo "Starting Uvicorn with multiple workers (Production)..."
  exec uvicorn core.asgi:application \
    --host 0.0.0.0 \
    --port ${PORT:-8000} \
    --workers ${UVICORN_WORKERS:-4} \
    --log-level ${UVICORN_LOG_LEVEL:-info}
fi
