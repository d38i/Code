# Update system
echo "\033[36mWELCOME_TO_FIRST_AUTOMATIZATION_SCRIPT"
echo -e "\033[34mUPDATE \033[34mSTART!"
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
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose && echo -e "\033[42mDOCKER \033[42mCOMPLETE \033[42mINSTALL!"
sudo usermod -aG docker $ubuntu
# Docker Complete install!
# Portainer Start install!
echo -e "\033[34mPORTAINER \033[34mSTART \033[34mINSTALL!"
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer && echo -e "\033[42mPORTAINER \033[42mCOMPLETE \033[42mINSTALL!"
echo -e "\033[42mINSTALL_DOCKER,COMPOSE,PORTAINER \033[42mCOMPLETE!"
echo -e "\033[32mPOTAINER \033[32m\nWORKS_AT \033[33m9000 \033[32mPORTS_TCP"
# Portainer complete install! 
# Script End !!! 