#!/bin/bash
sudo apt-get install -y openvpn easy-rsa
sudo mkdir -p /etc/openvpn/keys
sudo mkdir /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa
sudo cp -r /usr/share/easy-rsa/* .
sudo read -p "Введите адресс сервера(DNS-NAME)" SERVER_KEY_NAME
sudo echo "export KEY_COUNTRY="RU"
export KEY_PROVINCE="Samara"
export KEY_CITY="Samara"
export KEY_ORG="ORG"
export KEY_EMAIL="example@mail.com"
export KEY_CN="contact"
export KEY_OU="contact"
export KEY_NAME="$SERVER_KEY_NAME"
export KEY_ALTNAMES="$SERVER_KEY_NAME"" &> vars
. ./vars
./clean-all
ln -s openssl-1.0.0.cnf openssl.cnf
ls /etc/openvpn/easy-rsa

#Утилита easyrsa
./easyrsa init-pki
echo -e "На запрос «Common Name» можно просто нажать Enter:"
./easyrsa build-ca
read -p "Введите пароль для сертификата" PASSWORD_EASY_RCA
echo -e "На запрос «Common Name» можно просто нажать Enter:"
./easyrsa gen-req server $PASSWORD_EASY_RCA
./easyrsa sign-req server server
./easyrsa gen-dh
sudo openvpn --genkey --secret pki/ta.key
sudo cp pki/ca.crt /etc/openvpn/keys/
sudo cp pki/issued/server.crt /etc/openvpn/keys/
sudo cp pki/private/server.key /etc/openvpn/keys/ 
sudo cp pki/dh.pem /etc/openvpn/keys/
sudo cp pki/ta.key /etc/openvpn/keys/
sudo touch /etc/openvpn/server.conf
out=$(curl curlmyip.ru 2>&1 | egrep "([0-9]{1,3}\.){3}" )

sudo echo "local $out
port 443
proto udp
dev tun
ca keys/ca.crt
cert keys/server.crt
key keys/server.key
dh keys/dh.pem
tls-auth keys/ta.key 0
server 10.13.13.0 255.255.255.0
ifconfig-pool-persist ipp.txt
keepalive 10 120
max-clients 32
persist-key
persist-tun
status /var/log/openvpn/openvpn-status.log
log-append /var/log/openvpn/openvpn.log
verb 4
mute 20
daemon
mode server
tls-server
comp-lzo" &> /etc/openvpn/server.conf
sudo mkdir /var/log/openvpn
sudo systemctl enable openvpn@server --now