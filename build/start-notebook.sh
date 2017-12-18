#!/bin/bash

export JUPYTER_CONFIG_DIR=/jupyter/config

exec jupyter notebook --no-browser --allow-root
