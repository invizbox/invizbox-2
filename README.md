This repository contains the code to build an InvizBox 2 firmware.

## Before building

### VPN Settings
* Edit the files in `src/files/etc/openvpn` so that they contain your own VPN configuration files
The files that are already there contain more information to help you initially.

  * `openvpn_1.conf`, `openvpn_2.conf`, `openvpn_3.conf` and `openvpn_4.conf` should contain your default config (aka
   initially selected when flashing) - make sure that the tunnels in these files are called tun1, tun2, tun3 and tun4
   respectively
  * `files/` should contains OVPN files 
  * `templates/` can be create templates if your ovpn files are identical apart from the server IP/hostname and the
   tunnel name (@TUN@)

* Edit `src/files/etc/config/vpn` as it should now be modified to define your VPN locations based on what you created 
in the previous point.

Note: If you own an original InvizBox 2, you can duplicate the /etc/openvpn setup from it to get started.

### Default Password
* If you own an original InvizBox 2, the passwords will be set to the flashed defaults
* If you DO NOT own an original InvizBox 2 and are trying to flash on another router, consider that the initial password
is most likely going to be TOKENPASSWORD (see `src/files/etc/config/wireless`). At this stage, you may want to consider
that the code here reads and writes from a partition called /private and you need to be sure that it suits your device.
(I'd consider being able to run a recovery via serial/tftp before trying this)

### Updating
If you want to get VPN updates, opkg updates and firmware updates from the Invizbox update server, you can enable the 
`CONFIG_PACKAGE_update` setting in the src/.config file.

### DNS and DNS leaking
In `src/files/etc/config/dhcp`, the current DNS values (8.8.8.8 and 8.8.4.4) point to the Google DNS servers.
If you want to use your VPN provider's DNS servers, make sure to edit that file and change the servers
from 8.8.8.8 and 8.8.4.4 to whatever your VPN provider DNS servers are (don't forget the @tun{0-4} after the IP address
when doing so). Similarly, make sure you put the correct DNS servers in `src/files/etc/config/vpn`, so they match
the ovpn file/template in use for that protocol or server.

## Building an InvizBox 2 firmware

* Use a build environment in which you can already successfully build OpenWRT
* Run ./build.sh
* Find the sysupgrade file in 
  `openwrt/bin/targets/sunxi/cortexa7/invizbox-openwrt-sunxi-cortexa7-sun8i-h3-invizbox2-squashfs-sdcard.bin`

The build.sh script will create an `openwrt` directory and build your firmware there using the `src/.config` and 
`src/feeds.conf` files.

Enjoy!

The Invizbox Team.
