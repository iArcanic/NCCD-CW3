# allow DNS traffic from the DMZ to the internal zone
iptables -A FORWARD -s 172.16.1.0/21 -d 10.0.0.0/21 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -s 172.16.1.0/21 -d 10.0.0.0/21 -p tcp --dport 53 -j ACCEPT

# allow HTTP and HTTPS traffic from the internal zone to the server zone
iptables -A FORWARD -s 10.0.0.0/21 -d 172.16.0.0/24 -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -s 10.0.0.0/21 -d 172.16.0.0/24 -p tcp --dport 443 -j ACCEPT

# allow SSH traffic from the management zone to the server zone
iptables -A FORWARD -s 192.168.0.0/24 -d 172.16.0.0/24 -p tcp --dport 22 -j ACCEPT

# allow LDAP traffic from the server zone to the management zone
iptables -A FORWARD -s 172.16.0.0/24 -d 192.168.0.0/24 -p tcp --dport 389 -j ACCEPT
iptables -A FORWARD -s 172.16.0.0/24 -d 192.168.0.0/24 -p udp --dport 389 -j ACCEPT

# drop all other traffic between zones
iptables -A FORWARD -i eth1 -o eth0 -j DROP

