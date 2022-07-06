#!/bin/bash

set -e

name=${DS_NAME:-ds-py3}
notebooks_vol=${DS_NOTEBOOKS_DIR:-`pwd`/notebooks}
data_vol=${DS_DATA_DIR:-`pwd`/data}
config_vol=${DS_CONFIG_DIR:-`pwd`/config}
secret_vol=${DS_SECRET_DIR:-`pwd`/secret}
port=${DS_PORT:-8888}
image=${DS_IMAGE:-analysiscenter1/ds-py3}
extra_ports=${DS_EXTRA_PORTS:-2}

ports=""
if (( extra_ports>0 )); then
    for i in $(seq 1 $extra_ports); do
        ports+="-p $((port+i)):$((port+i)) "
    done
fi

docker run -d --rm --name ${name} \
  --gpus all --pid=host --shm-size=8G \
  -p ${port}:8888 \
  ${ports} \
  -v ${notebooks_vol}:/notebooks \
  -v ${data_vol}:/data \
  -v ${config_vol}:/jupyter/config \
  -v ${secret_vol}:/jupyter/secret \
  $@ \
  ${image}
