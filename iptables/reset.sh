#!/bin/bash

# Flush existing rules!
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

# Set the default policies to ACCEPT
iptables -P INPUT ACCEPT
#iptables -P INPUT DROP 
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
