#!/bin/sh
set -e

echo "Applying database migrations..."
python manage.py migrate --noinput

# Run the startup test
python manage.py run_startup_test

# Start the Django development server or run the provided command
if [ "$1" = "runserver" ]; then
    exec python manage.py runserver 0.0.0.0:8000
else
    # Execute the provided command
    exec "$@"
fi 