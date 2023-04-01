#!/bin/bash
BUILD_PATH="/home/limons"
echo '--- Start build script.---'
cd ${BUILD_PATH} && rm -rf openwrt &&

echo '--- Pull from OpenWRT. ---'
git clone https://github.com/openwrt/openwrt openwrt && 
echo '--- Pull from OpenWRT success. ---'

echo '--- Pull from Package. ---'
cd ${BUILD_PATH}/openwrt &&
git clone --depth=1 https://github.com/vernesong/OpenClash package/OpenClash &&
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon &&
echo '--- Pull from Package success. ---'

echo '--- Update & install. ---'
cd ${BUILD_PATH}/openwrt && ./scripts/feeds update -a && ./scripts/feeds install -a &&
echo '--- Update & install success. ---'

echo '--- Replace config. ---'
mv ${BUILD_PATH}/.config ${BUILD_PATH}/openwrt/.config &&
echo '--- Replace config success. ---'

echo '--- Sometings custom. ---'
cd ${BUILD_PATH}/openwrt &&
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate &&
sed -i "s/ucidef_set_interface_lan 'eth0'/ucidef_set_interface_lan 'eth1'/g" package/base-files/files/etc/board.d/99-default_network &&
sed -i "s/ucidef_set_interface_wan 'eth1'/ucidef_set_interface_wan 'eth0'/g" package/base-files/files/etc/board.d/99-default_network &&
echo '--- Sometings custom success. ---'

echo '--- Start buiding. ---'
cd ${BUILD_PATH}/openwrt && make defconfig && make download -j8 &&
cd ${BUILD_PATH}/openwrt && make -j$(nproc) &&
echo '--- Build success. ---'
