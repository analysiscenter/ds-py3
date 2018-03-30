#!/bin/sh

sudo apt-get purge nvidia*
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt install -y --no-install-recommends nvidia-390

nvidia-smi
