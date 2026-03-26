#!/bin/bash

# 1. إعدادات الشبكة (تعيين الأي بي الافتراضي)
# يتم استلام الأي بي كمتغير من ملف الـ Workflow
lan_ip=${1:-"192.168.1.1"}
sed -i "s/192.168.1.1/$lan_ip/g" package/base-files/files/bin/config_generate

# 2. تغيير الثيم الافتراضي إلى Argon
# نقوم بحذف الثيم الافتراضي القديم وتفعيل Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 3. تعديل الـ Banner (بصمة ALIWRT)
cat <<EOF > package/base-files/files/etc/banner
      ___    __    ____  _   _  __ ____  ______
     /   |  / /   /  _/ | | /| / // __ \/_  __/
    / /| | / /    / /   | |/ |/ / //_/ / / /   
   / ___ |/ /____/ /    |  /|  / /_, _/ / /    
  /_/  |_/_____/___/    |__/|_//_/ |_| /_/     
 -------------------------------------------------
  ALIWRT STABLE | USB FIX | SD-RAM OPTIMIZED
  Device: Beelink GT1 Mini (S905X2)
 -------------------------------------------------
EOF

# 4. إصلاحات الـ USB والطاقة والشبكة (Full Duplex)
# ننشئ سكريبت يعمل عند أول إقلاع للجهاز لضبط الهاردوير
mkdir -p package/base-files/files/etc/uci-defaults
cat <<EOF > package/base-files/files/etc/uci-defaults/99-usb-stable-fix
#!/bin/sh
# تعطيل خاصية توفير الطاقة لمنع فصل الـ USB (Carrier: Absent)
for i in /sys/bus/usb/devices/*/power/autosuspend; do [ -e "\$i" ] && echo -1 > "\$i"; done
for i in /sys/bus/usb/devices/*/power/control; do [ -e "\$i" ] && echo on > "\$i"; done

# إجبار تحويلة USB to Ethernet على العمل بوضع Full Duplex وسرعة 100/1000
if command -v ethtool > /dev/null; then
    ethtool -s eth1 speed 100 duplex full autoneg on 2>/dev/null
fi

# إيقاظ المنفذ برمجياً
ip link set eth1 up 2>/dev/null
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-usb-stable-fix

# 5. حماية الـ SD Card (نقل السجلات إلى الرام)
# تعديل إعدادات النظام لتقليل عمليات الكتابة (I/O) على البطاقة
sed -i 's/log_proto "udp"/log_proto "internal"/g' package/base-files/files/etc/config/system
echo "System logs redirected to RAM (tmpfs)"

# 6. إدارة ملف الـ DTB (النسخ الذكي)
# السكريبت سيبحث عن ملفك المرفوع وينسخه لمجلد بناء النسخة
DTB_NAME="meson-g12a-gt1-mini-a.dtb"
# المسار النسبي من جذر المستودع
DTB_SOURCE="config/immortalwrt_master/\$DTB_NAME"

if [ -f "\$DTB_SOURCE" ]; then
    mkdir -p target/linux/amlogic/dts/amlogic/
    cp -f "\$DTB_SOURCE" target/linux/amlogic/dts/amlogic/
    echo "SUCCESS: DTB file copied to build directory."
else
    echo "WARNING: DTB not found in \$DTB_SOURCE, checking root..."
    [ -f "\$DTB_NAME" ] && cp -f "\$DTB_NAME" target/linux/amlogic/dts/amlogic/
fi

# 7. أوامر إضافية لضمان عدم توقف البناء (Non-interactive)
# حذف أي محاولات لفتح menuconfig برمجياً
sed -i '/menuconfig/d' Makefile 2>/dev/null

echo "DIY Part 2 script completed successfully!"
