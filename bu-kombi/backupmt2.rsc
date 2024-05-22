# 2024-03-12 09:44:09 by RouterOS 7.14.1
# software id = 
#
/disk
set slot1 slot=slot1
set slot2 slot=slot2
set slot3 slot=slot3
set slot4 slot=slot4
set slot5 slot=slot5
/ip address
add address=192.168.10.2/30 interface=ether2 network=192.168.10.0
add address=2.2.2.2 interface=lo network=2.2.2.2
/ip dhcp-client
add interface=ether4
add interface=ether3
/ip route
add disabled=no distance=1 dst-address=1.1.1.1/32 gateway=192.168.10.1 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no distance=1 dst-address=192.168.30.0/30 gateway=192.168.1.1 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no distance=2 dst-address=192.168.30.0/30 gateway=192.168.20.1 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no dst-address=3.3.3.3/32 gateway=192.168.10.1 routing-table=\
    main suppress-hw-offload=no
/system identity
set name="MikroTik 2"
/system note
set show-at-login=no
