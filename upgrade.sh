#!/bin/sh
# U60Pro LuCI OTA 升级辅助脚本
WORKDIR="/data/luci-install"
echo "[OTA] 开始解析升级参数..."

while [ $# -gt 0 ]; do
    case "$1" in
        --package)
            PKG_FILE="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

if [ ! -f "$PKG_FILE" ]; then
    echo "ERROR: 升级包 $PKG_FILE 不存在"
    exit 23
fi

echo "[OTA] 正在解压补丁包..."
mkdir -p /tmp/luci_ota_extract
tar -xzf "$PKG_FILE" -C /tmp/luci_ota_extract || { echo "ERROR: 补丁包解压失败"; exit 23; }

echo "[OTA] 正在同步文件到系统..."
if [ -d /tmp/luci_ota_extract/luci ]; then
    cp -rpf /tmp/luci_ota_extract/luci/* /data/luci/ 2>/dev/null
fi

# 刷新版本号
if [ -f /tmp/luci_ota_extract/VERSION ]; then
    cp -f /tmp/luci_ota_extract/VERSION /data/luci/VERSION
fi

rm -rf /tmp/luci_ota_extract
echo "[OTA] 升级完成！"
exit 0
