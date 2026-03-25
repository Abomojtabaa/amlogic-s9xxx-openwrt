#!/bin/bash
#========================================================================================================================
# Description: DIY script (After updating feeds)
# Target: Beelink GT1 Mini (S905X2)
#========================================================================================================================

# 1. ضبط عنوان الـ IP الافتراضي (اختياري: يمكنك تغييره هنا)
default_ip="192.168.1.1"
sed -i "s/192.168.1.1/$default_ip/g" package/base-files/files/bin/config_generate

# 2. ضبط كلمة المرور الافتراضية لتكون 'password'
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# 3. إجبار منافذ الإيثرنت (eth0, eth1) على سرعة 1000Mbps Full Duplex
# يتم إضافتها في ملف rc.local لتعمل تلقائياً عند كل تشغيل
sed -i '/exit 0/i ethtool -s eth0 speed 1000 duplex full autoneg on' package/base-files/files/etc/rc.local
sed -i '/exit 0/i ethtool -s eth1 speed 1000 duplex full autoneg on' package/base-files/files/etc/rc.local

# 4. تنظيف مجلد الـ DTB (حذف كل شيء والإبقاء فقط على ملفات جهازك)
# هذا السطر يبحث في مجلد التعريفات ويحذف أي ملف لا يحتوي اسمه على s905x2 الخاص بـ GT1 Mini
find target/linux/amlogic/dts/amlogic/ -type f ! -name "*g12a-s905x2-gt1-mini*" ! -name "*g12a-u212*" -delete

# 5. تعديل اسم الجهاز ليظهر بوضوح في المتصفح
sed -i "s/hostname='.*'/hostname='Beelink-GT1-Mini'/g" package/base-files/files/bin/config_generate

echo "DIY-Part2 scripts completed successfully!"
