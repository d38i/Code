#!/bin/bash
sudo mkdir /tmp/keys
cd /etc/openvpn/easy-rsa
sudo . ./vars
sudo ./easyrsa build-client-full client1 nopass
echo "Вводим пароль, который указывали при создании корневого сертификата:"
sudo cp pki/issued/client1.crt pki/private/client1.key pki/ca.crt pki/ta.key /tmp/keys/
sudo chmod -R a+r /tmp/keys
echo "Сертификаты находятся в домашней каталоге"
sudo mkdir /home/$USER/Cert_OVPN
sudo mv /tmp/keys /home/$USER/Cert_OVPN