#!/usr/bin/env bash
# build.sh - Chạy mỗi lần deploy để install, migrate, collectstatic

set -o errexit  # Dừng nếu có lỗi

# Install dependencies (Render đã chạy pip install, nhưng an toàn)
pip install -r requirements.txt

# Chạy migrate (tạo bảng nếu chưa có)
python generative_art_website_project/manage.py migrate

# Collect static files (WhiteNoise cần)
python generative_art_website_project/manage.py collectstatic --noinput

# (Tùy chọn: Tạo superuser tự động nếu chưa có – chỉ chạy lần đầu)
# python generative_art_website_project/manage.py createsuperuser --noinput || true
