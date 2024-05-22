# mar/12/2024 01:44:07 by RouterOS 7.8
# software id = 
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip address
add address=192.168.100.1/24 interface=ether1 network=192.168.100.0
add address=192.168.101.1/24 interface=ether2 network=192.168.101.0
/ip dhcp-client
add interface=ether3
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether3
/ip route
add disabled=no dst-address=192.168.1.0/24 gateway=192.168.100.2 \
    routing-table=main suppress-hw-offload=no
add disabled=no distance=1 dst-address=192.168.2.0/24 gateway=192.168.101.2 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
/system identity
set name=RB4011
