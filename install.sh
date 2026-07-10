# 强行创建根工作目录
mkdir -p /data/luci

# 解压你编译出来的压缩包
tar -zxvf u60pro_luci.tar.gz -C /data/luci/

# 【核心防错：路径对齐】如果云编译打包时多套了一层文件夹，强行捞出来
if [ -d /data/luci/u60pro_luci ]; then
    mv /data/luci/u60pro_luci/* /data/luci/ 2>/dev/null
    mv /data/luci/u60pro_luci/.* /data/luci/ 2>/dev/null
    rm -rf /data/luci/u60pro_luci
fi

# 赋予权限并强制拉起服务
if [ -f /data/luci/plugin_boot.sh ]; then
    chmod 0755 /data/luci/plugin_boot.sh
    /data/luci/plugin_boot.sh restart
fi

# 放开设备防火墙
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT 2>/dev/null
