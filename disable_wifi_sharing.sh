echo 0 > /proc/sys/net/ipv4/ip_forward
iptables -D natctrl_FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -g natctrl_tether_counters
iptables -D natctrl_FORWARD -i eth0 -o wlan0 -m state --state INVALID -j DROP
iptables -D natctrl_FORWARD -i eth0 -o wlan0 -g natctrl_tether_counters
iptables -D natctrl_tether_counters -i eth0 -o wlan0 -j RETURN
iptables -D natctrl_tether_counters -i wlan0 -o eth0 -j RETURN
iptables -t nat -D natctrl_nat_POSTROUTING -o wlan0 -j MASQUERADE
iptables -t mangle -D INPUT -i eth0 -j MARK --set-xmark 0x30063/0xffffffff
