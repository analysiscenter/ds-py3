#!/bin/sh

sudo apt purge libnvidia* -y
sudo apt purge nvidia* -y
sudo apt dist-upgrade --fix-broken -y
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install -y --no-install-recommends nvidia-driver-520 nvidia-settings

nvidia-smi
