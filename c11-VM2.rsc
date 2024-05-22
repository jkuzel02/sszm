# 2024-04-30 14:50:40 by RouterOS 7.14
# software id = 
#
/interface ethernet
set [ find default-name=ether1 ] mtu=1458
/interface pppoe-client
add add-default-route=yes allow=mschap2 interface=ether1 name=pppoe-out1 \
    user=ahoj
/interface gre
add disabled=yes local-address=10.0.2.2 name=gre-tunnel remote-address=\
    10.0.1.2
/interface wireguard
add disabled=yes listen-port=13231 mtu=1420 name=wireguard1
/ip ipsec peer
add address=10.0.1.2/32 disabled=yes name=to-VM1
/ip ipsec profile
set [ find default=yes ] dh-group=ecp256,modp8192,modp4096 enc-algorithm=\
    aes-256,aes-192,aes-128 hash-algorithm=sha256
/ip ipsec proposal
set [ find default=yes ] auth-algorithms=sha512,sha256 enc-algorithms=\
    aes-256-cbc pfs-group=modp2048
/ip pool
add name=dhcp_pool0 ranges=10.0.3.2-10.0.3.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether2 name=dhcp1
/routing ospf instance
add disabled=no name=ospf-instance-1
/routing ospf area
add disabled=no instance=ospf-instance-1 name=ospf-area-1
/interface wireguard peers
add allowed-address=10.0.0.0/24 disabled=yes endpoint-address=10.0.1.2 \
    endpoint-port=13231 interface=wireguard1 public-key=\
    "pfrplZbi6+KZgRBVTomQxrru0Wvw/KptYWBan7/DIXM="
/ip address
add address=10.0.3.1/24 interface=ether2 network=10.0.3.0
add address=10.0.2.12/24 interface=ether1 network=10.0.2.0
add address=10.0.254.2/24 disabled=yes interface=gre-tunnel network=\
    10.0.254.0
add address=10.0.254.2/24 disabled=yes interface=wireguard1 network=\
    10.0.254.0
add address=192.168.0.1/24 interface=lo network=192.168.0.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=10.0.3.0/24 gateway=10.0.3.1
/ip ipsec identity
add peer=to-VM1
/ip ipsec policy
add disabled=yes dst-address=10.0.0.0/24 peer=to-VM1 src-address=10.0.3.0/24 \
    tunnel=yes
/ip route
add disabled=no distance=1 dst-address=10.0.0.0/24 gateway=10.0.254.1 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no distance=110 dst-address=10.0.1.2/32 gateway=10.0.2.1 \
    routing-table=main scope=20 suppress-hw-offload=no target-scope=10
add disabled=no dst-address=10.0.0.0/24 gateway=wireguard1 routing-table=main \
    suppress-hw-offload=no
/routing ospf interface-template
add area=ospf-area-1 disabled=no interfaces=ether1
add area=ospf-area-1 disabled=no interfaces=ether2 passive
/system identity
set name=VM2
/system note
set show-at-login=no
