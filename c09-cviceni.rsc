# 2024-04-16 14:43:43 by RouterOS 7.14
# software id = 
#
/ip firewall layer7-protocol
add name=SSH regexp="^ssh-[12]\\.[0-9]"
/ip address
add address=10.0.1.1/24 interface=ether2 network=10.0.1.0
add address=10.0.2.1/24 interface=ether1 network=10.0.2.0
/ip dhcp-client
add interface=ether1
/ip firewall filter
add action=accept chain=forward connection-state=established
add action=accept chain=forward dst-port=22 protocol=tcp
add action=drop chain=forward layer7-protocol=SSH
add action=accept chain=forward dst-port=3576 protocol=tcp
add action=accept chain=forward limit=2/1m,0:packet protocol=icmp
add action=drop chain=forward protocol=icmp
add action=accept chain=forward dst-port=22 protocol=tcp src-address-list=\
    FAIL2BAN-2
add action=add-src-to-address-list address-list=FAIL2BAN-2 \
    address-list-timeout=5m chain=forward dst-port=12 protocol=tcp \
    src-address-list=FAIL2BAN-1
add action=add-src-to-address-list address-list=FAIL2BAN-1 \
    address-list-timeout=5m chain=forward dst-port=11 protocol=tcp
add action=drop chain=input disabled=yes
/ip firewall mangle
add action=mark-connection chain=forward disabled=yes new-connection-mark=\
    asdf passthrough=yes src-address=10.0.2.10
/ip firewall nat
add action=masquerade chain=srcnat disabled=yes out-interface=ether1
add action=dst-nat chain=dstnat disabled=yes dst-address=5.9.64.3 dst-port=\
    2222 protocol=tcp to-addresses=10.0.2.10 to-ports=22
/system note
set show-at-login=no
