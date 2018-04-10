#!/usr/bin/env bash

set -e

# Add a reasonable swap.
sudo fallocate -l 1000M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo sysctl vm.swappiness=10
sudo swapon /swapfile
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab
