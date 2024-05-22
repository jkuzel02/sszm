# 2024-04-25 08:56:01 by RouterOS 7.14
# software id = 
#
/ip pool
add name=dhcp_pool0 ranges=10.0.1.2-10.0.1.254
add name=VPN ranges=10.0.3.10-10.0.3.100
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether2 name=dhcp1
/ppp profile
add local-address=10.0.3.1 name=VPN remote-address=VPN use-encryption=\
    required
/interface l2tp-server server
set authentication=mschap2 default-profile=VPN enabled=yes ipsec-secret=\
    mesicek use-ipsec=yes
/interface sstp-server server
set authentication=mschap1,mschap2 certificate=SSTP-cert default-profile=VPN \
    enabled=yes
/ip address
add address=10.0.1.1/24 interface=ether2 network=10.0.1.0
add address=10.0.2.1/24 interface=ether1 network=10.0.2.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=10.0.1.0/24 dns-server=10.0.1.1 gateway=10.0.1.1
/ip dns static
add address=10.0.1.1 name=www.mendelu.lab
/ppp secret
add name=balej password=slunicko profile=VPN
/system clock
set time-zone-name=Europe/Prague
/system note
set show-at-login=no
