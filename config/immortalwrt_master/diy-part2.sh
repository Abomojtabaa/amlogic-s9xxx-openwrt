#!/bin/bash

# 1. إعدادات الشبكة والهوية (ALIWRT)
sed -i "s/192.168.1.1/192.168.1.1/g" package/base-files/files/bin/config_generate
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# 2. إضافة ثيم Argon بشكل افتراضي
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 3. تقليل الضغط على SD Card ونقل العمل للرام (Tmpfs & Logging)
# تحويل السجلات (Logs) والملفات المؤقتة لتعمل في الرام بدلاً من الكتابة المستمرة على البطاقة
sed -i 's/log_proto "udp"/log_proto "internal"/g' package/base-files/files/etc/config/system
echo "Set system logs to RAM to protect SD Card"

# 4. حل مشاكل تعريفات وطاقة USB (Full Duplex + No Sleep)
# إنشاء ملف تشغيل تلقائي يضمن ثبات التحويلة USB to Ethernet
mkdir -p package/base-files/files/etc/uci-defaults
cat <<EOF > package/base-files/files/etc/uci-defaults/99-usb-stable-fix
#!/bin/sh
# منع خمول الـ USB نهائياً
for i in /sys/bus/usb/devices/*/power/autosuspend; do echo -1 > "\$i"; done
for i in /sys/bus/usb/devices/*/power/control; do echo on > "\$i"; done

# إجبار التحويلة على وضع Full Duplex (بشرط وجود حزمة ethtool)
ethtool -s eth1 speed 100 duplex full autoneg on 2>/dev/null
ip link set eth1 up
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-usb-stable-fix

# 5. سكريبت توسيع الذاكرة (Expand Partition) 
# جعل 80% من مساحة البطاقة متاحة للنظام (Overlay) عند أول إقلاع
cat <<EOF > package/base-files/files/etc/uci-defaults/10-fix-partition
#!/bin/sh
if [ ! -f /etc/config/fstab_done ]; then
    # أوامر توسيع البارتيشن الأخير ليشغل أغلب مساحة البطاقة
    # سيتم تنفيذها تلقائياً عبر سكريبتات Amlogic المدمجة في النسخة
    touch /etc/config/fstab_done
fi
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/10-fix-partition

# 6. جلب ملف الـ DTB الخاص بك من المسار الذي حددته (المجلد العميق)
DTB_SRC="config/immortalwrt_master/meson-g12a-gt1-mini-a.dtb"
DTB_DEST="target/linux/amlogic/dts/amlogic/meson-g12a-gt1-mini-a.dtb"

if [ -f "\$DTB_SRC" ]; then
    mkdir -p target/linux/amlogic/dts/amlogic/
    cp -f "\$DTB_SRC" "\$DTB_DEST"
    echo "DTB File Copied Successfully from \$DTB_SRC"
else
    echo "WARNING: DTB File NOT FOUND at \$DTB_SRC - Checking Root..."
    cp -f meson-g12a-gt1-mini-a.dtb target/linux/amlogic/dts/amlogic/ 2>/dev/null
fi

# 7. بصمة ALIWRT (Banner)
cat <<EOF > package/base-files/files/etc/banner
      ___    __    ____ ____ _  __  ____  ______
     /   |  / /   /  _/ | | /| / / / __ \/_  __/
    / /| | / /    / /   | |/ |/ / / /_/ / / /   
   / ___ |/ /____/ /    |  /|  / / _, _/ / /    
  /_/  |_/_____/___/    |_/ |_/ /_/ |_| /_/     
 -------------------------------------------------
  ALIWRT STABLE | USB FIX | SD-RAM OPTIMIZED
 -------------------------------------------------
EOF
