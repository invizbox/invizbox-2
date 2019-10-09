#!/bin/bash

set -e

version=$(grep CONFIG_VERSION_NUMBER src/.config | cut -d '"' -f 2)

echo "Preparing the openwrt directory..."
resources/clone_or_update.bash openwrt
rsync -avh  src/files/ openwrt/files/ --delete
cp src/feeds.conf openwrt/
cp src/.config openwrt/
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig

echo "Building the firmware"
sed -e "s,@VPN_PROVIDER@,invizbox," -e "s,@2_VERSION@,${version}," ../src/files/etc/config/update > files/etc/config/update
sed "s,@2_VERSION@,${version}," ../src/files/etc/banner > files/etc/banner
make -j $(($(grep -c processor /proc/cpuinfo)))
mv openwrt/bin/targets/sunxi/cortexa7/invizbox-openwrt-sunxi-cortexa7-sun8i-h3-invizbox2-squashfs-sdcard.img.gz openwrt/bin/targets/sunxi/cortexa7/invizbox-openwrt-sunxi-cortexa7-sun8i-h3-invizbox2-squashfs-sdcard.bin
echo "All Done!"
