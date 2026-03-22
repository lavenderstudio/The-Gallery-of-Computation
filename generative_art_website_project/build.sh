#!/usr/bin/env bash
set -o errexit

pip install -r ../requirements.txt  # Vì requirements.txt ở root repo, dùng ../ để truy cập

python manage.py migrate

python manage.py collectstatic --noinput
