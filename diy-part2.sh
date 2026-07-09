#!/bin/bash
# ==========================================================
# 🔧 中兴微 U60p 挂载环境自定义脚本 (diy-part2.sh)
# ==========================================================

# 1. 确保后台默认网关网段指向 192.168.0.1
if [ -f package/base-files/files/bin/config_generate ]; then
    sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate
fi

# 2. 将 Web 端口死守在 8080（完美对应你 JS 脚本里的 LUCI_PORT = 8080）
if [ -f package/network/services/uhttpd/files/uhttpd.config ]; then
    sed -i 's/:80/:8080/g' package/network/services/uhttpd/files/uhttpd.config
fi

# 3. 强行注入默认登录密码为 root
if [ -f package/base-files/files/etc/shadow ]; then
    sed -i 's/root::0:0:99999:7:::/root:\$1\$wEftA4St\$VclSgNqyKlD8gXmTeoNo.0:0:0:99999:7:::/g' package/base-files/files/etc/shadow
fi
