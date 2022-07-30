#!/bin/bash
sudo chmod -R +x Scripts/
echo "Start install OVPN"
sleep 1
./Scripts/Update.sh
./Scripts/Chrony.sh
./Scripts/OVPN_SERVER.sh
./Scripts/OVPN_CLIENT_CFG.sh
echo "Script COMPLETE!"