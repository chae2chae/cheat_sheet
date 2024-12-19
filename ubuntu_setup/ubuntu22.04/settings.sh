
# Install programs
sudo apt-get -y install ubuntu-unity-desktop # Ubuntu renderer
sudo snap install clion --classic # CLion IDE
sudo snap install pycharm-community --classic # Pycharm Community IDE
sudo snap install --classic code # Visual studio code

sudo snap install ao # Microsoft Todo
sudo snap install slack --classic # Slack
sudo snap install teams # Microsoft Teams
sudo snap install notion-snap # Notion


wget -nc https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb # Google Chrome
sudo apt -y install ./google-chrome-stable_current_amd64.deb
sudo rm -rf ./google-chrome-stable_current_amd64.deb

# C++
sudo apt-get -y install cmake ninja-build


# Docker
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt-get -y install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER

# Screen recorder
sudo apt install simplescreenrecorder

# Finished
echo "Now reboot system to apply changes"
