# How to run a data science container

In order to start a container you just need `./run.sh`

Jupyter notebook config file is located in `./config` directory. You might want to change config, at least the password hash to access the notebook.


**Prerequisites**

You need [docker](https://docs.docker.com/engine/installation/linux/), [GPU drivers](http://www.nvidia.ru/Download/index.aspx) and [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) installed.

## Settings

Before running a container you might set some environment variables:

### DS_NAME
default: `ds-py3`

### DS_NOTEBOOKS_DIR
default: `./notebooks`

Directory in the host system which is mapped to a container `/notebooks` directory where all the notebooks are stored

### DS_DATA_DIR
default: `./data`

Directory in the host system which is mapped to a container `/data` directory where all the data are stored

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

### DS_EXTRA_PORTS
default: `2`

Number of extra ports to open in a container, starting from the `DS_PORT` + 1. If equals to `0`, no extra ports are mapped.</br>
For example, if `DS_PORT=8892` and `DS_EXTRA_PORTS=2`, then the container is started with additional port mapping 8893:8893, 8894:8894.

## Examples
`DS_PORT=8889 ./run.sh` - to run a container which can be accessed at `http://localhost:8889`
`DS_NOTEBOOKS_DIR=/notebooks ./run.sh` - to store notebooks in the host directory `/notebooks`

You can pass additional docker options, for instance: </br>
`DS_PORT=8889 ./run.sh -it` - to run a container interactively.

To see docker options enabled by default, see the [runfile](../run/run.sh).
