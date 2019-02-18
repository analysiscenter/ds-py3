#!/bin/sh

sudo mkdir /notebooks
rm -rf ./run/notebooks
ln -s /notebooks ./run/notebooks

sudo docker pull analysiscenter1/ds-py3
