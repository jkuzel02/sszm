# 1970-01-02 02:32:46 by RouterOS 7.14.1
# software id = FEYD-C7EK
#
# model = RB4011iGS+
# serial number = D4440DD34BD8
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface eoip
add local-address=10.0.5.2 mac-address=02:6D:C1:09:F6:BE name=eoip-tunnel1 \
    remote-address=10.0.5.1 tunnel-id=0
/interface vlan
add interface=bridge1 name=vlan10 vlan-id=10
add interface=bridge1 name=vlan20 vlan-id=20
/port
set 0 name=serial0
set 1 name=serial1
/routing ospf instance
add disabled=no name=ospf-instance-1
/routing ospf area
add disabled=no instance=ospf-instance-1 name=ospf-area-1
/interface bridge port
add bridge=bridge1 interface=ether3 pvid=20
add bridge=bridge1 interface=eoip-tunnel1
add bridge=bridge1 interface=ether2 pvid=10
/interface bridge vlan
add bridge=bridge1 tagged=eoip-tunnel1,bridge1 vlan-ids=10
add bridge=bridge1 tagged=eoip-tunnel1,bridge1 vlan-ids=20
/interface pppoe-server server
add authentication=mschap2 interface=ether2 service-name=service1
add authentication=mschap2 interface=ether3 service-name=service2
/ip address
add address=10.0.2.11/24 interface=vlan20 network=10.0.2.0
add address=10.0.5.2/24 interface=ether4 network=10.0.5.0
add address=10.0.1.11/24 interface=vlan10 network=10.0.1.0
/ip route
add
add dst-address=10.0.0.0/24 gateway=10.0.1.12
/ppp secret
add local-address=10.0.1.1 name=balej remote-address=10.0.1.2 service=pppoe
add local-address=10.0.2.1 name=ahoj remote-address=10.0.2.2 routes=\
    192.168.0.0/24 service=pppoe
/routing ospf interface-template
add area=ospf-area-1 disabled=no interfaces=vlan10
add area=ospf-area-1 disabled=no interfaces=vlan20
/system identity
set name=RB4011
/system note
set show-at-login=no
/tool sniffer
set file-name=odchyt.pcap filter-ip-protocol=!ospf
