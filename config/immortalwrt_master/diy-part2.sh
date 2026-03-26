#!/bin/bash

# 1. ضبط الـ IP الافتراضي (يمكنك تغييره لـ 192.168.1.1 إذا أردت)
sed -i "s/192.168.1.1/192.168.1.1/g" package/base-files/files/bin/config_generate

# 2. ضبط كلمة مرور الجذر الافتراضية إلى 'password'
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# 3. شعار ALIWRT عند الدخول للنظام (Banner)
echo "      ___    __    _________ _      _______  ______" > package/base-files/files/etc/banner
echo "     /   |  / /   /  _/ | | /| /  / __ \/_  __/" >> package/base-files/files/etc/banner
echo "    / /| | / /    / /   | |/ |/  / /_/ / / /   " >> package/base-files/files/etc/banner
echo "   / ___ |/ /____/ /    |  /|   / _, _/ / /    " >> package/base-files/files/etc/banner
echo "  /_/  |_/_____/___/    |__/|__/_/ |_| /_/     " >> package/base-files/files/etc/banner
echo " -------------------------------------------------" >> package/base-files/files/etc/banner
echo "   STABLE USB EDITION | BEELINK GT1 MINI (S905X2) " >> package/base-files/files/etc/banner
echo " -------------------------------------------------" >> package/base-files/files/etc/banner

# 4. إصلاح مشكلة الـ Carrier (منع خمول الـ USB وتعطيل توفير الطاقة)
# هذه الأوامر ستنفذ تلقائياً عند كل إقلاع للجهاز
mkdir -p package/base-files/files/etc/uci-defaults
cat <<EOF > package/base-files/files/etc/uci-defaults/99-usb-power-fix
#!/bin/sh
# تعطيل تعليق الطاقة التلقائي لمنافذ USB
for i in /sys/bus/usb/devices/*/power/autosuspend; do echo -1 > "\$i"; done
for i in /sys/bus/usb/devices/*/power/control; do echo on > "\$i"; done
# تفعيل واجهة الشبكة بقوة
ip link set eth1 up
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-usb-power-fix

# 5. الإبقاء على ملفات الـ DTB الخاصة بمعالج جهازك فقط لتقليل الحجم ومنع التداخل
find target/linux/amlogic/dts/amlogic/ -type f ! -name "*g12a*" -delete
