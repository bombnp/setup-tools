#!/bin/bash

# Section 1: Install Docker
# refer to https://docs.docker.com/engine/install/ubuntu/

if command -v docker > /dev/null
then
  echo "$0: docker already exists. Skipping docker installation."
  exit 0
fi

echo "$0: Installing required packages..."
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl

echo "$0: Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "$0: Setting up stable repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "$0: Installing Docker Engine..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Section 3: Linux Post-install
# refer to https://docs.docker.com/engine/install/linux-postinstall/
echo "$0: Initiating post-installation steps..."

echo "$0: Adding 'docker' group..."
sudo groupadd docker

echo "$0: Add $USER to group 'docker'..."
sudo usermod -aG docker $USER

echo "$0: Re-evaluating group membership..."
newgrp docker
