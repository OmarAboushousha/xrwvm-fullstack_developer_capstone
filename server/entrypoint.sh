#!/bin/sh
set -e  # Exit if any command fails
set -x  # Print commands as they run (helps debugging in kubectl logs)

echo "Running Django migrations and collecting static files..."

python manage.py makemigrations --noinput
python manage.py migrate --run-syncdb --noinput
python manage.py collectstatic --noinput

echo "Starting server..."
exec "$@"