#!/bin/bash
# ==========================================================
# 🔧 U60p 编译后置自定义脚本 (diy-part2.sh)
# ==========================================================

# 1. 修改默认后台 IP 为 192.168.0.1（完美契合随身WiFi网段）
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认网页管理端口为 8080
if [ -f package/network/services/uhttpd/files/uhttpd.config ]; then
    sed -i 's/:80/:8080/g' package/network/services/uhttpd/files/uhttpd.config
fi
if [ -f package/feeds/luci/luci-nginx/files/nginx.config ]; then
    sed -i 's/listen 80/listen 8080/g' package/feeds/luci/luci-nginx/files/nginx.config
    sed -i 's/listen \[::\]:80/listen \[::\]:8080/g' package/feeds/luci/luci-nginx/files/nginx.config
fi

# 3. 设置固件默认密码为 root
sed -i 's/root::0:0:99999:7:::/root:\$1\$wEftA4St\$VclSgNqyKlD8gXmTeoNo.0:0:0:99999:7:::/g' package/base-files/files/etc/shadow
