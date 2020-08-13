#!/bin/sh

sudo apt-get purge nvidia* -y
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install -y --no-install-recommends nvidia-430 nvidia-settings
sudo apt install -y libcuda1-430

nvidia-smi
