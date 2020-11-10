#!/bin/bash

set -e

notebooks_vol=${DS_NOTEBOOKS_DIR:-`pwd`/notebooks}
data_vol=${DS_DATA_DIR:-`pwd`/data}
config_vol=${DS_CONFIG_DIR:-`pwd`/config}
secret_vol=${DS_SECRET_DIR:-`pwd`/secret}
port=${DS_PORT:-8888}
image=${DS_IMAGE:-analysiscenter1/ds-py3:torch1.6-tf1.15-cpu}


sudo docker run --rm -p ${port}:8888 \
  -v ${notebooks_vol}:/notebooks \
  -v ${data_vol}:/data \
  -v ${config_vol}:/jupyter/config \
  -v ${secret_vol}:/jupyter/secret \
  $@ \
  ${image}
