FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER Roman Kh <rhudor@gmail.com>

# installing system packages
RUN apt-get update && \
    apt-get install -y pkg-config software-properties-common build-essential cmake gfortran \
        liblapack-dev libatlas-base-dev libopenblas-dev \
        zlib1g-dev liblzma-dev liblz4-dev libzstd-dev zip p7zip-full \
        libhdf5-dev libedit-dev \
        libzmq-dev \
        git wget tmux sysstat \
        python3-pip python3-dev pylint3

# installing python packages
RUN pip3 install --upgrade pip && \
    pip3 install setuptools --upgrade && \
    pip3 install cython && \
    pip3 install blosc && \
    pip3 install numpy && \
    pip3 install bottleneck && \
    pip3 install numexpr && \
    pip3 install virtualenv && \
    pip3 install aiofiles

# installing LLVM
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" && \
    apt-get update && \
    apt-get install -y llvm-3.9 && \
    ln -s /usr/bin/llvm-config-3.9 /usr/bin/llvm-config && \
    pip3 install llvmlite && \
    pip3 install numba

# installing data manipulation packages
RUN pip3 install tables && \
    pip3 install pandas && \
    pip3 install feather-format && \
    pip3 install python-dateutil

# installing stats and ML libraries
RUN pip3 install scipy && \
    pip3 install sklearn && \
    pip3 install sklearn-pandas && \
    pip3 install statsmodels && \
    pip3 install pyflux && \
    pip3 install nltk

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
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D CUDA_ARCH_BIN:STRING="3.0 3.5 5.0 5.2 6.0 6.1" \
          -D CUDA_ARCH_PTX:STRING="3.0 3.5 5.0 5.2 6.0 6.1" \
          -D WITH_CUBLAS=1 -D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 ../../opencv && \
    make -j$(nproc) && \
    make install && \
    cd /install && \
    rm -r opencv && \
    pip3 install matplotlib && \
    pip3 install SimpleITK && \
    pip3 install scikit-image && \
    pip3 install pydicom

# installing deep learning libraries
RUN pip3 install tensorflow-gpu && \
    pip3 install keras && \
    pip3 install edward && \
    git clone https://github.com/dmlc/mxnet.git /install/mxnet --recursive && \
    cd /install/mxnet && \
    cp make/config.mk . && \
    echo 'USE_BLAS=openblas\n\
    ADD_CFLAGS += -I/usr/include/openblas\n\
    ADD_LDFLAGS += -lopencv_core -lopencv_imgproc -lopencv_imgcodecs\n\
    USE_CUDA=1\n\
    USE_CUDA_PATH=/usr/local/cuda\n\
    USE_CUDNN=1\n\
    CUDA_ARCH := -gencode arch=compute_30,code=sm_30\\\n\
                 -gencode arch=compute_35,code=sm_35\\\n\
                 -gencode arch=compute_50,code=sm_50\\\n\
                 -gencode arch=compute_50,code=compute_50\\\n\
                 -gencode arch=compute_52,code=sm_52\\\n\
                 -gencode arch=compute_52,code=compute_52\\\n\
                 -gencode arch=compute_60,code=sm_60\\\n\
                 -gencode arch=compute_60,code=compute_60\\\n\
                 -gencode arch=compute_61,code=sm_61\\\n\
                 -gencode arch=compute_61,code=compute_61\\\n\
    ' >> config.mk && \
    echo '\nMSHADOW_CFLAGS += -DMSHADOW_USE_PASCAL=1' >> mshadow/make/mshadow.mk && \
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
    pip3 install tqdm

# instaling jupyter
VOLUME /jupyter/config /jupyter/secret /notebooks
RUN pip3 install jupyter && \
    pip3 install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --system && \
    jupyter nbextension enable --py widgetsnbextension && \
    pip3 install ipyvolume && \
    jupyter nbextension enable --py --system ipyvolume && \
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

