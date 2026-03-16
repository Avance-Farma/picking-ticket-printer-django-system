#!/bin/sh
set -e

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

# ─── Apply database migrations ───────────────────────────────────────────────
echo "Running migrations..."
python manage.py migrate --fake-initial --noinput

# ─── Collect static files ────────────────────────────────────────────────────
# Static files are always collected so Nginx can pick them up via volume
echo "Collecting static files..."
python manage.py collectstatic --noinput --clear

# ─── Start Application ────────────────────────────────────────────────────────
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
    --port 8000 \
    --reload \
    --log-level ${UVICORN_LOG_LEVEL:-info}
else
  echo "Starting Uvicorn with multiple workers (Production)..."
  exec uvicorn core.asgi:application \
    --host 0.0.0.0 \
    --port 8000 \
    --workers ${UVICORN_WORKERS:-4} \
    --log-level ${UVICORN_LOG_LEVEL:-info}
fi
