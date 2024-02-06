#!/bin/bash
# To make persistent, use apt install iptables-persistent
# Files in /etc/iptables/
# Variables
SSH_PORT=22022
LIMIT_BURST=5
LIMIT_DELAY=120 # 120seconds 

# Flush existing rules!
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

# Set the default policies to DROP
iptables -P INPUT ACCEPT
#iptables -P INPUT DROP 
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow SSH on the specified port with rate-limiting
iptables -A INPUT -p tcp --dport $SSH_PORT -m state --state NEW -m recent --set --name SSH
iptables -A INPUT -p tcp --dport $SSH_PORT -m state --state NEW -m recent --update --seconds $LIMIT_DELAY --hitcount $LIMIT_BURST --rttl --name SSH -j DROP
iptables -A INPUT -p tcp --dport $SSH_PORT -j ACCEPT

# Allow Pings
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# Prevent DOS Attacks
iptables -A INPUT -p tcp --dport 80 -m limit --limit 250/minute --limit-burst 100 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m limit --limit 250/minute --limit-burst 100 -j ACCEPT
# Allow git
iptables -A INPUT -p tcp --dport 9418 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 9418 -j ACCEPT

# Allow SSH for git
iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT


# Allow DNS Queries for Git
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p udp --sport 53 -m state --state ESTABLISHED     -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p tcp --sport 53 -m state --state ESTABLISHED     -j ACCEPT

# Allow HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

echo "Iptables configuration complete."
iptables-save # if using iptables-persistent
#echo "Saved configuration to be persistent"
