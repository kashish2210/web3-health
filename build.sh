#!/usr/bin/env bash
# Exit on error
@echo off
echo Building project...
set -o errexit

# Modify this line as needed for your package manager (pip, poetry, etc.)
pip install -r requirements.txt

# Convert static asset files
python manage.py collectstatic --no-input

# Apply any outstanding database migrations
python manage.py migrate
gunicorn healthchain.asgi:application -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000 --check-config
