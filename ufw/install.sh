#!/bin/bash

# Update and install UFW
sudo apt-get update
sudo apt-get install ufw -y

# Reset existing rules
sudo ufw --force disable
sudo ufw --force reset

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH on custom port 22022
sudo ufw allow 22022/tcp

# Allow DNS on port 53
sudo ufw allow 53/udp

# Allow Git on port 9418 and 22 for github ssh
sudo ufw allow 9418/tcp
sudo ufw allow 22/tcp

# Allow HTTP and HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Enable UFW
sudo ufw enable

# Display the status of UFW to confirm the rules
sudo ufw status verbose

