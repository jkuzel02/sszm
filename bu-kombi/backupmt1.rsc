# 2024-03-12 09:43:36 by RouterOS 7.14.1
# software id = 
#
/disk
set slot1 slot=slot1
set slot2 slot=slot2
set slot3 slot=slot3
set slot4 slot=slot4
set slot5 slot=slot5
/ip address
add address=192.168.10.1/30 interface=ether2 network=192.168.10.0
add address=1.1.1.1 interface=lo network=1.1.1.1
add address=192.168.30.1/30 interface=ether3 network=192.168.30.0
/ip dhcp-client
add interface=ether4
/ip route
add disabled=no dst-address=2.2.2.2/32 gateway=192.168.10.2 routing-table=\
    main suppress-hw-offload=no
add disabled=no dst-address=192.168.20.0/24 gateway=192.168.30.2 \
    routing-table=main suppress-hw-offload=no
add disabled=no dst-address=192.168.20.0/24 gateway=192.168.10.2 \
    routing-table=main suppress-hw-offload=no
add disabled=no dst-address=3.3.3.3/32 gateway=192.168.30.2 routing-table=\
    main suppress-hw-offload=no
#error exporting "/ipv6/nd/prefix/default" (timeout)
/system identity
set name="MikroTik 1"
/system note
set show-at-login=no
