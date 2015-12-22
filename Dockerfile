#start with Ubuntu base image
FROM ubuntu:14.04
MAINTAINER Broadroad <zk@cloudwarehub.com>

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    bc \
    libatlas-base-dev \
    libatlas-dev \
    libboost-all-dev \
    libopencv-dev \
    libprotobuf-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    protobuf-compiler \
    libhdf5-dev \
    libleveldb-dev \
    liblmdb-dev \
    libsnappy-dev \
    python-pip \
    python-numpy \
    python-scipy \
    python-matplotlib \
    ipython \
    ipython-notebook \
    python-pandas \
    python-sympy \
    python-nose \
    python-skimage \
    python-protobuf 
    

#clone caffe repo
RUN cd /root && git clone https://github.com/BVLC/caffe.git && cd caffe && \
#Copy Makefile
cp Makefile.config.example Makefile.config && \
# Enable CPU-only
sed -i 's/# CPU_ONLY/CPU_ONLY/g' Makefile.config && \
#Make
make -j"$(nproc)" all && \
make pycaffe
# Set ~/caffe as working directory
WORKDIR /root/caffe

