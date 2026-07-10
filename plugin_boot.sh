#!/bin/sh
# 强杀一切旧的冲突进程，给真后台腾出 8080 端口
killall -9 uhttpd 2>/dev/null

# 强行赋予网关脚本最高执行权限
chmod 0755 /data/luci/www/cgi-bin/luci 2>/dev/null

# 启动网页服务，定死路径
/usr/sbin/uhttpd -c /data/luci/etc/uhttpd.conf -h /data/luci/www -p 8080 >/dev/null 2>&1 &

echo "LuCI CORE SERVICE RUNNING..."
