FROM ubuntu:16.04
MAINTAINER Roman Kh <rhudor@gmail.com>

# installing system packages
RUN apt-get update && \
    apt-get install -y pkg-config software-properties-common build-essential cmake gfortran \
        libboost-dev libboost-system-dev libboost-filesystem-dev \
        liblapack-dev libatlas-base-dev libopenblas-dev \
        zlib1g-dev liblzma-dev liblz4-dev libzstd-dev libsnappy-dev zip p7zip-full \
        libhdf5-dev libedit-dev \
        libzmq-dev \
        git wget tmux nano sysstat htop mc \
        python3-pip python3-dev pylint3

# installing python packages
RUN pip3 install --upgrade pip && \
    pip3 install setuptools --upgrade && \
    pip3 install cython && \
    pip3 install toolz && \
    pip3 install dill && \
    pip3 install fastcache && \
    pip3 install python-snappy && \
    pip3 install blosc && \
    pip3 install numpy && \
    pip3 install bottleneck && \
    pip3 install numexpr && \
    pip3 install virtualenv && \
    pip3 install aiofiles && \
    pip3 install packaging && \
    pip3 install click && \
    pip3 install itsdangerous && \
    pip3 install flask && \
    pip3 install pytest && \
    pip3 install pytest-flask && \
    pip3 install tox

# installing LLVM
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-4.0 main" && \
    apt-get update && \
    apt-get install -y llvm-4.0 && \
    ln -s /usr/bin/llvm-config-4.0 /usr/bin/llvm-config && \
    pip3 install llvmlite && \
    pip3 install numba

# installing data manipulation packages
RUN pip3 install tables && \
    pip3 install h5py && \
    pip3 install pandas && \
    pip3 install feather-format && \
    pip3 install fastparquet && \
    pip3 install dask && \
    pip3 install python-dateutil

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
    make -j$(nproc) && \
    cd python-package && \
    python3 setup.py install && \
    cd /install && \
    rm -r xgboost && \
# installing LightGBM
    git clone --recursive https://github.com/Microsoft/LightGBM && \
    cd LightGBM && \
    mkdir build && \
    cd build && \
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
    apt-get install -y libfreetype6-dev libpng-dev libjpeg8-dev && \
    cd /install && \
    git clone https://github.com/Itseez/opencv.git && \
    cd opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D ENABLE_FAST_MATH=1 ../../opencv && \
    make -j$(nproc) && \
    make install && \
    cd /install && \
    rm -r opencv && \
    pip3 install matplotlib && \
    pip3 install scikit-image

# installing special packages
RUN pip3 install SimpleITK && \
    pip3 install pydicom && \
    pip3 install wfdb && \
    pip3 install PyWavelets && \
    pip3 install pyedflib

# installing deep learning libraries
RUN pip3 install tensorflow && \
    pip3 install --no-deps keras && \
    pip3 install --no-deps edward && \
    git clone https://github.com/dmlc/mxnet.git /install/mxnet --recursive && \
    cd /install/mxnet && \
    cp make/config.mk . && \
    echo 'USE_BLAS=openblas\n\
    ADD_CFLAGS += -I/usr/include/openblas\n\
    ADD_LDFLAGS += -lopencv_core -lopencv_imgproc -lopencv_imgcodecs\n\
    ' >> config.mk && \
    make -j$(nproc) && \
    cd python && \
    python3 setup.py install && \
    cd /install && \
    rm -r mxnet && \
    pip3 install minpy

# installing visualization libraries
RUN pip3 install seaborn && \
    pip3 install ggplot && \
    pip3 install bokeh && \
    pip3 install folium && \
    pip3 install --no-deps picasso-viz && \
    pip3 install vispy && \
    pip3 install tqdm

# instaling jupyter
WORKDIR /jupyter/config
WORKDIR /jupyter/secret
RUN pip3 install jupyter && \
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

COPY start-notebook.sh /usr/local/bin/start-notebook.sh
COPY start-singleuser.sh /usr/local/bin/start-singleuser.sh

WORKDIR /notebooks

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["start-notebook.sh"]
