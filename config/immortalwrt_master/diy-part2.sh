#!/bin/bash

# 1. تعيين الأي بي الافتراضي (192.168.1.1)
sed -i "s/192.168.1.1/${1:-"192.168.1.1"}/g" package/base-files/files/bin/config_generate

# 2. تغيير الثيم الافتراضي إلى Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 3. إضافة بانر بسيط (اختياري)
echo "ALIWRT MINIMAL BUILD - KERNEL 5.15" > package/base-files/files/etc/banner

# 4. تعطيل أوامر الهاردوير المتقدمة مؤقتاً
# تركنا أوامر ethtool و USB Fix جانباً الآن لضمان إقلاع النواة بدون أخطاء.
# سنقوم بتطبيقها يدوياً عبر Putty بعد التأكد من أن الجهاز يعمل.

echo "DIY Part 2 (Minimal) completed."
