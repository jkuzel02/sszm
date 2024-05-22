# 2024-02-20 15:08:48 by RouterOS 7.11.3
# software id = HB8J-M699
#
# model = RBD52G-5HacD2HnD
# serial number = D7160D5E4C82
/interface bridge
add name=LAN
/interface wireless
set [ find default-name=wlan2 ] band=5ghz-a/n/ac country="czech republic" \
    disabled=no frequency=5200 mode=ap-bridge ssid=JB_WiFi tx-power=0 \
    tx-power-mode=all-rates-fixed
/caps-man interface
add channel.band=5ghz-a/n/ac .frequency=5800 .tx-power=0 \
    configuration.country="czech republic" .mode=ap .ssid=kjahgsdiugb \
    disabled=no mac-address=00:00:00:00:00:00 master-interface=none name=cap1 \
    radio-mac=00:00:00:00:00:00 radio-name=""
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
    supplicant-identity=MikroTik
add name=profile1 supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-onlyn disabled=no mode=ap-bridge \
    security-profile=profile1 ssid=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/ip pool
add name=dhcp_pool0 ranges=192.168.1.20-192.168.1.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=LAN lease-time=1w3d name=dhcp1
/interface bridge port
add bridge=LAN interface=ether2
add bridge=LAN interface=ether3
add bridge=LAN interface=ether4
add bridge=LAN interface=ether5
add bridge=LAN interface=wlan2
/ip address
add address=192.168.1.1/24 interface=LAN network=192.168.0.0
add address=192.168.254.1/24 interface=wlan1 network=192.168.254.0
/ip dhcp-server network
add address=192.168.1.0/24 dns-server=192.168.1.1 gateway=192.168.1.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=192.168.254.254 routing-table=main \
    suppress-hw-offload=no
/system clock
set time-zone-name=Europe/Prague
/system identity
set name=JB
/system note
set show-at-login=no
