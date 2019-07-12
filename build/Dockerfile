FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER Roman Kh <rhudor@gmail.com>

ENV TF_VERSION=1.12
ENV CUDA_VERSION=9.0
ENV CUDNN_VERSION=7.2.1.38-1

# Update CUDA for TF
RUN echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
    apt-get purge -y --allow-change-held-packages libcudnn7 libcudnn7-dev && \
    apt-get install -y --no-install-recommends \
            libcudnn7=$CUDNN_VERSION+cuda$CUDA_VERSION \
            libcudnn7-dev=$CUDNN_VERSION+cuda$CUDA_VERSION

# installing system packages
RUN apt-get update && \
    apt-get install -y pkg-config software-properties-common build-essential cmake gfortran \
        libboost-dev libboost-system-dev libboost-filesystem-dev \
        liblapack-dev libatlas-base-dev libopenblas-dev \
        zlib1g-dev liblzma-dev liblz4-dev libzstd-dev libsnappy-dev zip p7zip-full \
        libhdf5-dev libedit-dev \
        libzmq-dev \
        git wget tmux nano sysstat htop mc \
        python3-pip python3-dev

# Update CMake

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main' && \
    apt-get update && \
    apt-get install cmake -y

# Install russian locale

RUN apt-get install -y language-pack-ru && \
    echo ru_RU.UTF8 >> /var/lib/locales/supported.d/local && \
    echo ru_RU.UTF-8 UTF-8 >> /var/lib/locales/supported.d/local

ENV LC_CTYPE=ru_RU.UTF-8

# installing python packages
RUN pip3 install -U pip && \ 
    hash -r pip3 && \
    pip3 install -U setuptools && \
    pip3 install pipenv && \
    pip3 install cython && \
    pip3 install toolz && \
    pip3 install dill && \
    pip3 install fastcache && \
    pip3 install python-snappy && \
    pip3 install blosc && \
    pip3 install virtualenv && \
    pip3 install aiofiles && \
    pip3 install packaging && \
    pip3 install click && \
    pip3 install itsdangerous && \
    pip3 install requests && \
    pip3 install multiprocess && \
    pip3 install psutil && \
    pip3 install eventlet && \
    pip3 install greenlet && \
    pip3 install aiohttp && \
    pip3 install python-socketio && \
    pip3 install flask && \
    pip3 install flask-socketio && \
    pip3 install pytest && \
    pip3 install pytest-aiohttp && \
    pip3 install pytest-flask && \
    pip3 install tox && \
    pip3 install autopep8 && \
    pip3 install -U pylint

# installing LLVM and Numba
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main" && \
    apt-get update && \
    apt-get install -y llvm-7 && \
    ln -s /usr/bin/llvm-config-7 /usr/bin/llvm-config && \
    pip3 install llvmlite && \
    pip3 install numba

# installing data manipulation packages
RUN pip3 install numpy && \
    pip3 install bottleneck && \
    pip3 install numexpr && \ 
    pip3 install tables && \
    pip3 install h5py && \
    pip3 install pandas && \
    pip3 install feather-format && \
    pip3 install fastparquet && \
    pip3 install dask && \
    pip3 install python-dateutil
    pip3 install plotly

# installing stats and ML libraries
RUN pip3 install scipy && \
    pip3 install sklearn && \
    pip3 install sklearn-pandas && \
    pip3 install statsmodels && \
    pip3 install pyflux && \
    pip3 install nltk && \
    pip3 install hmmlearn

# installing XGBoost and LightGBM
WORKDIR /install/xgboost
RUN git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && \
    mkdir build && cd build && \
    cmake -DUSE_CUDA=ON -DGPU_COMPUTE_VER=61 .. && \
    make -j$(nproc) && \
    cd ../python-package && \
    python3 setup.py install && \
    cd /install && \
    rm -r xgboost && \
# installing LightGBM
    git clone --recursive https://github.com/Microsoft/LightGBM && \
    cd LightGBM && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    cd ../python-package && \
    python3 setup.py install && \
    cd /install && \
    rm -r LightGBM

# installing Google OrTools
WORKDIR /install/ortools
RUN wget https://github.com/google/or-tools/releases/download/v5.0/or-tools_python_examples_v5.0.3919.tar.gz && \
    tar xvf or-tools_python_examples_v5.0.3919.tar.gz && \
    cd ortools_examples && \
    python3 setup.py install && \
    cd /install && \
    rm -r ortools

# installing image libraries
RUN apt-get install -y graphviz && \
    pip3 install graphviz && \
    apt-get install -y libfreetype6-dev libpng-dev libjpeg-dev && \
    cd /install && \
    git clone https://github.com/Itseez/opencv.git && \
    cd opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D ENABLE_FAST_MATH=1 \
          -D WITH_CUDA=OFF -D WITH_CUBLAS=0 -D CUDA_FAST_MATH=0 ../../opencv && \
    make -j$(nproc) && \
    make install && \
    cd /install && \
    rm -r opencv && \
    pip3 install scikit-image && \
    pip3 install imageio && \
    pip3 install matplotlib

# installing special packages
RUN pip3 install SimpleITK && \
    pip3 install pydicom && \
    pip3 install wfdb && \
    pip3 install PyWavelets && \
    pip3 install pyedflib && \
    pip3 install segyio && \
    pip3 install lasio

# increase counter to rebuild the image if some library changes
ENV UPDATE_DL 1
# installing deep learning libraries
RUN pip3 install tensorflow-gpu==$TF_VERSION && \
    pip3 install --no-deps keras && \
    pip3 install --no-deps edward && \
    pip3 install torch torchvision torchtext && \
    pip3 install pyro-ppl

# installing visualization libraries
RUN pip3 install seaborn && \
    pip3 install ggplot && \
    pip3 install bokeh && \
    pip3 install folium && \
    pip3 install --no-deps picasso-viz && \
    pip3 install vispy && \
    pip3 install tqdm

# installing jupyter
WORKDIR /jupyter/config
WORKDIR /jupyter/secret
RUN pip3 install jupyter && \
    pip3 install jupyterlab && \
    pip3 install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --system && \
    pip3 install ipyvolume && \
    pip3 install jupyterhub

# install forked libraries
RUN pip3 uninstall -y pillow && \
    CC="cc -mavx2" pip3 install -U --force-reinstall pillow-simd

# install docker
RUN wget https://get.docker.com -q -O /tmp/getdocker && \
    chmod +x /tmp/getdocker && \
    sh /tmp/getdocker

# increase counter to rebuild the image if start files change
ENV UPDATE_CMD 1
COPY start-notebook.sh /usr/local/bin/start-notebook.sh
COPY start-singleuser.sh /usr/local/bin/start-singleuser.sh

WORKDIR /notebooks

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["start-notebook.sh"]
