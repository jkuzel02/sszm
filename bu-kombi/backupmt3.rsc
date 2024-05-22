# 2024-03-12 09:45:15 by RouterOS 7.14.1
# software id = 
#
/disk
set slot1 slot=slot1
set slot2 slot=slot2
set slot3 slot=slot3
set slot4 slot=slot4
set slot5 slot=slot5
set slot6 slot=slot6
/ip pool
add name=pool1 ranges=192.168.20.100,192.168.20.200
/ip dhcp-server
add address-pool=pool1 interface=ether2 name=server1 server-address=\
    192.168.20.1
/ip address
add address=192.168.20.1/24 interface=ether2 network=192.168.20.0
add address=3.3.3.3 interface=lo network=3.3.3.3
add address=192.168.30.2/30 interface=ether3 network=192.168.30.0
/ip dhcp-client
add interface=ether4
/ip route
add disabled=no dst-address=1.1.1.1/32 gateway=192.168.30.1 routing-table=\
    main suppress-hw-offload=no
add disabled=no dst-address=192.168.10.0/30 gateway=192.168.30.1 \
    routing-table=main suppress-hw-offload=no
add disabled=no dst-address=2.2.2.2/32 gateway=192.168.30.1 routing-table=\
    main suppress-hw-offload=no
/system identity
set name="MikroTik 3"
/system note
set show-at-login=no
