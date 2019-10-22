# Docker containers with python 3 environment (with CPU support) for data science

## For a "GPU" container switch to **master** branch


# Installation directory
```
git clone https://github.com/analysiscenter/ds-py3.git
cd ds-py3
```


# Docker
To install Docker execute `utils/install_docker.sh`.


# Container
To prepare a docker environment run `utils/create_env.sh`.

Map additional disks to subdirectories within `/notebooks`.

Set a password in `run/config/jupyter_notebook_config.py`.


# Run jupyter
See [run/README.md](run/README.md) or just execute:
```
cd run
./run.sh
```
