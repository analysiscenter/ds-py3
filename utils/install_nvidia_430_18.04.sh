#!/bin/sh

sudo apt-get purge nvidia* -y
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install -y --no-install-recommends nvidia-driver-430 nvidia-settings

nvidia-smi
