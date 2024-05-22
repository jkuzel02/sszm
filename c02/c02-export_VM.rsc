# mar/12/2024 02:43:30 by RouterOS 7.8
# software id = 
#
/interface list
add name=mgmt
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/user group
add name=admins policy="ssh,read,write,winbox,web,!local,!telnet,!ftp,!reboot,\
    !policy,!test,!password,!sniff,!sensitive,!api,!romon,!rest-api" skin=\
    admin-skin
/ip neighbor discovery-settings
set discover-interface-list=mgmt
/interface list member
add interface=ether1 list=mgmt
add interface=ether2 list=mgmt
/ip address
add address=192.168.1.1/24 interface=ether2 network=192.168.1.0
add address=192.168.100.2/24 interface=ether1 network=192.168.100.0
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=192.168.100.1 routing-table=\
    main suppress-hw-offload=no
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=192.168.0.0/16 port=2222
set www-ssl certificate=cert1 disabled=no
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Europe/Prague
/system identity
set name="VM MikroTIk"
/tool mac-server
set allowed-interface-list=mgmt
/tool mac-server mac-winbox
set allowed-interface-list=mgmt
