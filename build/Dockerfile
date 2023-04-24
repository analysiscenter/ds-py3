FROM ubuntu:lunar
LABEL maintainer="Roman Kh <rhudor@gmail.com>"

# required to prevent interactions while installing packages (e.g. software-properties-common)
ENV DEBIAN_FRONTEND=noninteractive

ARG PYTHON_VERSION=local
ENV PYTHON_VERSION=${PYTHON_VERSION}

# install dependencies for pyenv
RUN apt-get update && apt -y dist-upgrade && \
    apt install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncurses5-dev \
        xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
        mecab-ipadic-utf8 ca-certificates git

ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN set -ex \
    && curl https://pyenv.run | bash \
    && pyenv update \
    && pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION \
    && pyenv rehash

RUN apt install -y software-properties-common cmake gfortran \
        libboost-dev libboost-system-dev libboost-filesystem-dev \
        liblapack-dev libatlas-base-dev libopenblas-dev zip p7zip-full \
        zlib1g-dev liblzma-dev liblz4-dev libzstd-dev libsnappy-dev \
        libhdf5-dev libedit-dev libzmq3-dev  libgl1-mesa-glx \
        wget tmux nano sysstat htop mc tree unzip \
        libgl1-mesa-glx libglib2.0-0 pkg-config

RUN pip3 install -U numpy && \
    pip3 install -U tbb && \
    pip3 install numba==0.57.0rc1 && \
    pip3 install torch torchvision

RUN pip3 install -U pip && \
    pip3 install -U poetry && \
    pip3 install -U setuptools && \
    apt install -y python3-venv && \
    pip3 install -U virtualenv && \
    pip3 install -U pipenv && \
    pip3 install -U pipreqs && \
    pip3 install -U cython && \
    pip3 install -U toolz && \
    pip3 install -U fsspec && \
    pip3 install -U cloudpickle && \
    pip3 install -U dill && \
    pip3 install -U fastcache && \
    pip3 install -U python-snappy && \
    pip3 install -U blosc && \
    pip3 install -U aiofiles && \
    pip3 install -U packaging && \
    pip3 install -U click && \
    pip3 install -U itsdangerous && \
    pip3 install -U requests && \
    pip3 install -U multiprocess && \
    pip3 install -U psutil && \
    pip3 install -U eventlet && \
    pip3 install -U greenlet && \
    pip3 install -U aiohttp && \
    pip3 install -U python-socketio && \
    pip3 install -U flask && \
    pip3 install -U flask-socketio && \
    pip3 install -U pytest && \
    pip3 install -U pytest-aiohttp && \
    pip3 install -U pytest-flask && \
    pip3 install -U pytest-cov && \
    pip3 install -U tox && \
    pip3 install -U autopep8 && \
    pip3 install -U cookiecutter && \
    pip3 install -U tqdm && \
    pip3 install -U pylint && \
    pip3 install -U connected-components-3d

# install data manipulation packages
RUN pip3 install -U zarr && \
    pip3 install -U lmdb && \
    pip3 install -U bottleneck && \
    pip3 install -U numexpr && \
    pip3 install -U tables && \
    pip3 install -U h5py && \
    pip3 install -U h5pickle && \
    pip3 install -U hdf5plugin && \
    pip3 install -U pandas && \
    pip3 install -U feather-format && \
    pip3 install -U fastparquet && \
    pip3 install -U dask && \
    pip3 install -U pint && \
    pip3 install -U python-dateutil && \
    pip3 install -U 'dvc[ssh]' && \
    pip3 install -U cupy-cuda$(python3 -c 'import torch; print(torch.version.cuda)' | cut -c 1,2)x

# install stats and ML libraries
RUN pip3 install -U scipy && \
    pip3 install -U scikit-learn && \
    pip3 install -U sklearn-pandas && \
    pip3 install -U statsmodels && \
    pip3 install -U nltk && \
    pip3 install -U xgboost && \
    pip3 install -U catboost-dev[widget]==1.2rc0 && \
    pip3 install -U lightgbm

# install image libraries
RUN apt install -y graphviz libfreetype6-dev libpng-dev libjpeg-dev && \
    pip3 install -U graphviz && \
    pip3 install -U matplotlib && \
    pip3 install -U scikit-image && \
    pip3 install -U imageio && \
    pip3 install -U seaborn && \
    pip3 install -U folium && \
    pip3 install -U vispy && \
    pip3 install -U plotly && \
    pip3 install -U ipympl && \
    pip3 install -U opencv-python

# install special packages
RUN pip3 install -U PyWavelets && \
    pip3 install -U segyio && \
    pip3 install -U lasio && \
    pip3 install -U xlrd && \
    pip3 install -U nvidia-ml-py3 && \
    pip3 install -U fpdf && \
    pip3 install -U sphinx && \
    pip3 install -U gpustat && \
    pip3 install -U py-nbtools && \
    pip3 install -U batchflow && \
    pip3 install -U segfast

# install deep learning libraries
RUN pip3 install -U einops

# install jupyter and extensions
RUN pip3 install -U nodejs && \
    pip3 install -U jupyterlab && \
    pip3 install -U jupyterlab_execute_time && \
    pip3 install -U nbdime && \
    nbdime extensions --enable

# add short alias for gpustat
RUN echo "alias gtop='gpustat -i 0.2'" >> ~/.bashrc

COPY start-notebook.sh /usr/local/bin/start-notebook.sh

WORKDIR /notebooks

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["start-notebook.sh"]
