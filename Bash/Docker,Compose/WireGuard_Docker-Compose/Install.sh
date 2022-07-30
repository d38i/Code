#!/bin/bash
echo "Start Install Wireguard Docker_COMPOSE"
sleep 1
./update.sh
./docker.sh
./wireguard.sh
echo "Completed Install Wireguard Docker_COMPOSE"
sleep 1