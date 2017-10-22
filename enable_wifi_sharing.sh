ifconfig eth0 192.168.42.1
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -A natctrl_FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -g natctrl_tether_counters
iptables -A natctrl_FORWARD -i eth0 -o wlan0 -m state --state INVALID -j DROP
iptables -A natctrl_FORWARD -i eth0 -o wlan0 -g natctrl_tether_counters
iptables -A natctrl_tether_counters -i eth0 -o wlan0 -j RETURN
iptables -A natctrl_tether_counters -i wlan0 -o eth0 -j RETURN
iptables -t nat -A natctrl_nat_POSTROUTING -o wlan0 -j MASQUERADE
iptables -t mangle -A INPUT -i eth0 -j MARK --set-xmark 0x30063/0xffffffff