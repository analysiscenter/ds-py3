# How to run a data science container

In order to start a container you just need `./run.sh`

Jupyter notebook config file is located in `./config` directory. You might want to change config, at least the password to access the notebook.

## Prerequisites

You obviously need [docker](https://docs.docker.com/engine/installation/) installed.

## Settings

Before running a container you might set some env variables:

### DS_NOTEBOOKS_DIR
default: `./notebooks`

Directory in the host system which is mapped to a container `/notebooks` directory where all the notebooks are stored

### DS_CONFIG_DIR
default: `./config`

Directory in the host system where `jupyter_notebook_config.py` is stored. It is mapped to `/jupyter/config` directory in the container.

### DS_SECRET_DIR
default: `./secret`

Directory in the host system where TLS certs are stored. It is mapped to `/jupyter/secret` directory in the container.

### DS_PORT
default: `8888`

Host port where jupyter notebook is listening.

### DS_IMAGE
default: `analysiscenter1/ds-py3`

Docker image to run in a container.

## Examples
`DS_PORT=8889 ./run.sh` - to run a container which can be accessed at `http://localhost:8889`
`DS_NOTEBOOKS_DIR=/notebooks ./run.sh` - to store notebooks in the host directory `/notebooks`

You can pass additional docker options, for instance:
`DS_PORT=8889 ./run.sh -it --rm` - to run a container interactively and remove it when it stops
