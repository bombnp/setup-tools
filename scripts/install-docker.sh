#!/bin/bash

# Section 1: Install Docker
# refer to https://docs.docker.com/engine/install/ubuntu/

if command -v docker > /dev/null
then
  echo "$0: docker already exists. Skipping docker installation."
  exit 0
fi

echo "$0: Installing required packages..."
sudo apt-get update
sudo apt-get install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

echo "$0: Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "$0: Setting up stable repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "$0: Installing Docker Engine..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Section 2: Linux Post-install
# refer to https://docs.docker.com/engine/install/linux-postinstall/
echo "$0: Initiating post-installation steps..."

echo "$0: Adding 'docker' group..."
sudo groupadd docker

echo "$0: Add $USER to group 'docker'..."
sudo usermod -aG docker $USER

echo "$0: Re-evaluating group membership..."
newgrp docker

# Section 3: Install Docker Compose
# refer to https://docs.docker.com/compose/install/
echo "$0: Installing Docker Compose..."

echo "$0: Downloading current stable release for docker-compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "$0: Applying executable permissions to the binary..."
sudo chmod +x /usr/local/bin/docker-compose
