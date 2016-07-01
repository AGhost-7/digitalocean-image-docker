#!/usr/bin/env bash

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install docker-engine python-dev python-pip -y
sudo pip install docker-compose
# installer already adds the docker group, just need to add current user to group
sudo usermod -aG docker $USER
sudo service docker restart

# Add a small swap. 512mb of ram isnt much to play with tbh.
sudo fallocate -l 500M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo sysctl vm.swappiness=10
sudo swapon /swapfile
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab

