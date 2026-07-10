#!/bin/sh
# 强杀旧进程并拉起 uhttpd 服务
killall -9 uhttpd 2>/dev/null
/usr/sbin/uhttpd -c /data/luci/etc/uhttpd.conf -E /data/luci/www/cgi-bin/luci -p 8080 -h /data/luci/www -r u60pro_luci >/dev/null 2>&1 &
echo "LuCI HTTPD STARTED"
