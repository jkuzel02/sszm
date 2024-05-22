# 2024-04-23 13:32:51 by RouterOS 7.14
# software id = 
#
/queue type
set 5 pcq-rate=10M
set 6 pcq-classifier=dst-address,dst-port pcq-rate=10M
/queue interface
set ether2 queue=pcq-download-default
/queue simple
add disabled=yes max-limit=10M/10M name=parent target=10.0.1.0/24 \
    total-queue=default
add disabled=yes dst=10.0.2.10/32 max-limit=100T/100T name=unlimited target=\
    "" total-queue=default
add disabled=yes limit-at=100k/100k max-limit=1M/1M name=ping packet-marks=\
    PING parent=parent target="" total-queue=default
add disabled=yes limit-at=6M/6M max-limit=8M/8M name=PC-Linux parent=parent \
    target=10.0.1.10/32 total-queue=default
add disabled=yes limit-at=3M/3M max-limit=8M/8M name=PC-Windows parent=parent \
    target=10.0.1.20/32 total-queue=default
add burst-limit=20M/20M burst-threshold=10M/10M burst-time=10s/10s disabled=\
    yes limit-at=3M/3M max-limit=8M/8M name=PC-Windows_burst target=\
    10.0.1.20/32 total-queue=default
/ip address
add address=10.0.1.1/24 interface=ether2 network=10.0.1.0
add address=10.0.2.1/24 interface=ether1 network=10.0.2.0
/ip dhcp-client
add interface=ether1
/ip firewall mangle
add action=mark-packet chain=prerouting new-packet-mark=PING passthrough=yes \
    protocol=icmp
/system note
set show-at-login=no
/tool graphing interface
add interface=ether1
add interface=ether2
/tool graphing resource
add
