# 2024-04-30 14:49:16 by RouterOS 7.14
# software id = 
#
/interface ethernet
set [ find default-name=ether1 ] mtu=1458
/interface pppoe-client
add add-default-route=yes interface=ether1 name=pppoe-out1 user=balej
/interface gre
add disabled=yes local-address=10.0.1.2 name=gre-tunnel remote-address=\
    10.0.2.2
/interface wireguard
add disabled=yes listen-port=13231 mtu=1420 name=wireguard1
/ip ipsec peer
add address=10.0.2.2/32 disabled=yes name=to-VM2
/ip ipsec profile
set [ find default=yes ] dh-group=ecp256,modp4096 enc-algorithm=\
    aes-256,aes-192,aes-128 hash-algorithm=sha256
/ip ipsec proposal
set [ find default=yes ] auth-algorithms=sha512,sha256 enc-algorithms=\
    aes-256-cbc pfs-group=modp2048
/ip pool
add name=dhcp_pool0 ranges=10.0.0.2-10.0.0.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether2 name=dhcp1
/routing ospf instance
add disabled=no name=ospf-instance-1
/routing ospf area
add disabled=no instance=ospf-instance-1 name=ospf-area-1
/interface wireguard peers
add allowed-address=10.0.1.2/32 disabled=yes endpoint-address=10.0.2.2 \
    endpoint-port=13231 interface=wireguard1 public-key=\
    "47C4VM9Bw1J454Dv/iysu/NH6aj43vBV582qyb9/8RU="
/ip address
add address=10.0.0.1/24 interface=ether2 network=10.0.0.0
add address=10.0.1.12/24 interface=ether1 network=10.0.1.0
add address=10.0.254.1/24 disabled=yes interface=gre-tunnel network=\
    10.0.254.0
add address=10.0.254.1/24 disabled=yes interface=wireguard1 network=\
    10.0.254.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=10.0.0.0/24 gateway=10.0.0.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip ipsec identity
add peer=to-VM2
/ip ipsec policy
add disabled=yes dst-address=10.0.3.0/24 peer=to-VM2 src-address=10.0.0.0/24 \
    tunnel=yes
/routing ospf interface-template
add area=ospf-area-1 disabled=no interfaces=ether1
add area=ospf-area-1 disabled=no interfaces=ether2 passive
/system identity
set name=VM1
/system logging
add topics=wireguard
/system note
set show-at-login=no
