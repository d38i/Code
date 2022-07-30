#!/bin/bash
# Update system
echo -e "\033[34mUPDATE \033[34mSTART!"
set timeout 20
sudo apt update && sudo apt-get -y upgrade && echo -e "\033[32mUPDATE \033[32mCOMPLETE!"
# Update complete!
# Docker start install
echo -e "\033[34mDOCKER \033[34mSTART \033[34mINSTALL!"
 sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose && echo -e "\033[32mDOCKER \033[32mCOMPLETE \033[32mINSTALL!"
sudo usermod -aG docker $ubuntu
# Docker Complete install!
echo -e "\033[34mWIREGUARD \033[34mSTART \033[34mINSTALL!"
sudo mkdir -p /app/vpn/wireguard
cd /app/vpn/wireguard
sudo touch /app/vpn/wireguard/docker-compose.yml
echo -e
version: "2.1"
services:
  wireguard:
    image: ghcr.io/linuxserver/wireguard
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/Netherlands
      - SERVERURL=auto #optional
      - SERVERPORT=51820 #optional
      - PEERS=1 #optional
      - PEERDNS=auto #optional
      - INTERNAL_SUBNET=10.13.13.0 #optional
      - ALLOWEDIPS=0.0.0.0/0 #optional
    volumes:
      - /app/vpn/wireguard/config:/config
      - /lib/modules:/lib/modules
    ports:
      - 51820:51820/udp
    # dns: 1.1.1.1
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: always | tee -a /app/vpn/wireguard/docker-compose.yml

sudo docker-compose up -d && echo -e "\033[32mWIREGUARD \033[32mCOMPLETE \033[32mINSTALL!"

echo -e "\033[32mWIREGUARD \033[32m\nWORKS-AT \033[33m51820 \033[32mPORTS-UDP"