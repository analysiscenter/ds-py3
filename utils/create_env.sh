#!/bin/sh

# set up directory for notebooks
sudo mkdir -p /notebooks
rm -rf ../run/notebooks
ln -s /notebooks ../run/notebooks

# set up directory for data
sudo mkdir -p /data
rm -rf ../run/data
ln -s /data ../run/data
