#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Updating package lists..."
sudo apt-get update

echo "Installing required packages..."
sudo apt-get install -y ca-certificates curl

echo "Setting up Docker's GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package lists again..."
sudo apt-get update

echo "Installing Docker and Docker Compose..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Testing Docker installation..."
sudo docker run hello-world

echo "Docker and Docker Compose installation completed successfully!"
