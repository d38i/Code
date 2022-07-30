#!/bin/bash
sudo apt-get -y install chrony
sudo systemctl enable chrony --now
read -p "Укажите вашу TIMEZOME в формате <Europe/Moscow> " TIMEZONE
sudo timedatectl set-timezone $TIMEZONE
