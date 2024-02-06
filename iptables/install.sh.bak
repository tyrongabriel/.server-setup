# Scrip to automatically configure iptables firewall to
# protect against various ssh threats

# Create SSHATTACK chain
iptables -N SSHATTACK
iptables -A SSHATTACK -j LOG --log-prefix "Suspicious SSH" --log-level 7
iptables -A SSHATTACK -j DROP

# Create rules, which will forward to the chain
# Logs in /var/log/syslog 
# Be sure to check SSH port
iptables -A INPUT -i eth0 -p tcp -m state --dport 22022 --state NEW -m recent --set
iptables -A INPUT -i eth0 -p tcp -m state --dport 22022 --state NEW -m recent --update --seconds 120 --hitcount 5 -j SSHATTACK


