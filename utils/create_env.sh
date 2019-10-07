#!/bin/sh

# set up directory for notebooks
sudo mkdir /notebooks
rm -rf ./run/notebooks
ln -s /notebooks ./run/notebooks

# set up directory for data
sudo mkdir /data
rm -rf ./run/data
ln -s /data ./run/data

sudo docker pull analysiscenter1/ds-py3:gpu-1.6
