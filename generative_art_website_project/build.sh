#!/usr/bin/env bash
# build.sh - Chạy mỗi lần deploy trên Render: install, migrate, collectstatic, tạo superuser nếu cần

set -o errexit  # Dừng nếu có lỗi

# 1. Install dependencies (Render thường tự làm, nhưng an toàn)
pip install -r requirements.txt

# 2. Chạy migrate để đảm bảo tất cả bảng tồn tại (đã fix lỗi shop_product trước đó)
python manage.py migrate

# 3. Collect static files cho WhiteNoise phục vụ images/artwork
python manage.py collectstatic --noinput

# 4. Tạo superuser admin nếu chưa tồn tại (chạy an toàn một lần)
python manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser(
        username='admin',
        email='craftstudiovietnam@gmail.com',          # ← THAY BẰNG EMAIL THẬT CỦA BẠN
        password='Buzz046621974'        # ← THAY BẰNG MẬT KHẨU MẠNH BẠN MUỐN
    )
    print("Superuser 'admin' created successfully!")
else:
    print("Superuser 'admin' already exists.")
EOF

echo "Build hoàn tất!"
