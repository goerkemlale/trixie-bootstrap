#!/bin/bash

# Change Working Directory for external sh call
cd "$(dirname "$0")"

#Install Docker
DOCKERDEPR="docker.io docker-doc docker-compose podman-docker containerd runc"
DOCKERDEB="https://download.docker.com/linux/debian"
DOCKERGPGNET="https://download.docker.com/linux/debian/gpg"
DOCKERGPGLOCAL="/etc/apt/keyrings/docker.asc"
DOCKERPACKAGE="docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
for pkg in $DOCKERDEPR; \
do sudo apt-fast -y remove $pkg; done
sudo curl -fsSL $DOCKERGPGNET -o $DOCKERGPGLOCAL \
&& sudo chmod a+r  $DOCKERGPGLOCAL

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=$DOCKERGPGLOCAL] $DOCKERDEB \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-fast -y update
sudo apt-fast -y install $DOCKERPACKAGE 
