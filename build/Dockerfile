FROM nvcr.io/nvidia/pytorch:21.07-py3
LABEL maintainer="Roman Kh <rhudor@gmail.com>"

# required to prevent interactions while installing packages (e.g. software-properties-common)
ENV DEBIAN_FRONTEND=noninteractive

# install system packages
RUN apt update && \
    apt install -y pkg-config software-properties-common build-essential cmake gfortran \
        libboost-dev libboost-system-dev libboost-filesystem-dev \
        liblapack-dev libatlas-base-dev libopenblas-dev \
        zlib1g-dev liblzma-dev liblz4-dev libzstd-dev libsnappy-dev zip p7zip-full \
        libhdf5-dev libedit-dev libzmq3-dev  libgl1-mesa-glx \
        wget tmux nano sysstat htop mc tree unzip && \
    # install latest git version
    add-apt-repository -y ppa:git-core/ppa && \
    apt-get update && \
    apt install -y git git-lfs && \
    git lfs install && \
    pip3 install -U pip && \
    hash -r pip3


# update CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
    apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" && \
    apt update && \
    apt install cmake -y

# install russian locale
RUN apt install -y language-pack-ru && \
    echo ru_RU.UTF8 >> /var/lib/locales/supported.d/local && \
    echo ru_RU.UTF-8 UTF-8 >> /var/lib/locales/supported.d/local

ENV LC_CTYPE=ru_RU.UTF-8
ENV PIP_NO_CACHE_DIR=true

# install python packages
RUN pip3 install -U setuptools && \
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
    pip3 install -U pylint

# install data manipulation packages
RUN pip3 install -U bottleneck && \
    pip3 install -U numexpr && \
    pip3 install -U tables && \
    pip3 install -U h5py && \
    pip3 install -U h5pickle && \
    pip3 install -U pandas && \
    pip3 install -U feather-format && \
    pip3 install -U fastparquet && \
    pip3 install -U dask && \
    pip3 install -U pint && \
    pip3 install -U python-dateutil && \
    pip3 install -U cupy && \
    pip3 install -U 'dvc[ssh]'

# install stats and ML libraries
RUN pip3 install -U scipy && \
    pip3 install -U sklearn && \
    pip3 install -U sklearn-pandas && \
    pip3 install -U statsmodels && \
    pip3 install -U nltk && \
    pip3 install -U hmmlearn && \
    pip3 install -U xgboost && \
    pip3 install -U lightgbm && \
    pip3 install -U ortools && \
    pip3 install -U tdigest

# install image libraries
RUN apt install -y graphviz libfreetype6-dev libpng-dev libjpeg-dev && \
    pip3 install -U graphviz && \
    pip3 install -U opencv-python &&\
    pip3 install -U matplotlib && \
    pip3 install -U scikit-image && \
    pip3 install -U imageio && \
    pip3 install -U seaborn && \
    pip3 install -U ggplot && \
    pip3 install -U bokeh && \
    pip3 install -U folium && \
    pip3 install -U vispy && \
    pip3 install -U plotly && \
    pip3 install -U ipympl

# install special packages
RUN pip3 install -U SimpleITK && \
    pip3 install -U pydicom && \
    pip3 install -U wfdb && \
    pip3 install -U PyWavelets && \
    pip3 install -U pyedflib && \
    pip3 install -U segyio && \
    pip3 install -U lasio && \
    pip3 install -U xlrd && \
    pip3 install -U nvidia-ml-py3 && \
    pip3 install -U fpdf && \
    pip3 install -U sphinx && \
    pip3 install -U gpustat

# install deep learning libraries
RUN pip3 install -U pyro-ppl && \
    pip3 install -U einops && \
    pip3 install -U tensorflow

# workaround to update numba
RUN rm -rf /opt/conda/lib/python$(python --version | cut -c8-10)/site-packages/llvmlite* && \
    pip3 install -U numba

# Numpy 1.20.3 version is required for numba and pytorch to work
# Tensorflow requires 1.19, but still works with 1.20.
RUN pip3 install numpy==1.20.3

# install nodejs and npm
RUN apt install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt install -y nodejs

# install jupyter and extensions
WORKDIR /jupyter/config
WORKDIR /jupyter/secret
RUN pip3 install -U jupyterlab && \
    pip3 install -U nbdime && \
    nbdime extensions --enable

# install docker
RUN wget https://get.docker.com -q -O /tmp/getdocker && \
    chmod +x /tmp/getdocker && \
    sh /tmp/getdocker

COPY start-notebook.sh /usr/local/bin/start-notebook.sh

WORKDIR /notebooks

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["start-notebook.sh"]
