#!/bin/bash
echo -e "WIREGUARD START INSTALL!"
sleep 1
sudo mkdir -p /app/vpn/wireguard
sudo cp -f docker-compose.yml /app/vpn/wireguard/
cd /app/vpn/wireguard
sudo docker-compose up -d 
echo -e "\033[32mWIREGUARD \033[32m\nWORKS-AT \033[33m51820 \033[32mPORTS-UDP"
echo -e "Wait to create cfg files..."
sleep 60
sudo cp -r /app/vpn/wireguard/config /home/$USER
chmod 744 /home/$USER/config