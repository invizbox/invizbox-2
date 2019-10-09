#!/bin/sh

# Copyright 2018 InvizBox Ltd
#
# Licensed under the InvizBox Shared License;
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#        https://www.invizbox.com/lic/license.txt


dev_number=${dev:3}
gateway_ip=`uci get network.lan_vpn${dev_number}.ipaddr`
ip rule del from ${gateway_ip%?}0/24 table ${dev_number}
ip route del default via ${route_vpn_gateway} dev ${dev} table ${dev_number}
ip route del 127.0.0.0/8 dev lo table ${dev_number}
mkdir -p /tmp/openvpn/${dev_number}/
echo "down" > /tmp/openvpn/${dev_number}/status
