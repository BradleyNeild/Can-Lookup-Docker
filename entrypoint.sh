#!/bin/sh
set -e

echo "Applying database migrations..."
python manage.py migrate --noinput

# Run the startup test
python manage.py run_startup_test

# Start the Django development server
exec python manage.py runserver 0.0.0.0:8000

# Then exec the container's main process (what's set as CMD in the Dockerfile or command in docker-compose.yml)
exec "$@" 