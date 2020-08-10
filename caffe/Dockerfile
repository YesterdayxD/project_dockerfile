#FROM nvcr.io/nvidia/caffe:19.08-py2
#FROM nvcr.io/nvidia/caffe:18.07-py2
FROM nvidia/cuda:8.0-cudnn5-runtime-ubuntu16.04

# install python 3.6 for ubuntu16.04                                                                                     
RUN  apt-get update && apt-get install -y software-properties-common python-software-properties                          
RUN  add-apt-repository ppa:deadsnakes/ppa                                                                               

#RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
#
#

#ENV CAFFE_VERSION 0.15
#LABEL com.nvidia.caffe.version="0.15"
#
#ENV CAFFE_PKG_VERSION 0.15.3-ubuntu16.04+cuda8.0
#RUN apt-get update && apt-get install -y --no-install-recommends \
#        caffe-nv \
#        caffe-nv-tools \
#        python-caffe-nv \
#        libcaffe-nv0 && \
#    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y  \
        git \
        curl \
        wget \
        net-tools \
        inetutils-ping \
        bzip2 \
        unzip \
        ca-certificates \
        libjpeg-dev \
        libpng-dev \
&& \
    apt-get clean \
&& \
    rm -rf /var/lib/apt/lists/*


# used for 16.04                                                                                                                                              
RUN add-apt-repository ppa:deadsnakes/ppa                                                                                                                     
RUN if [[ "${PYTHON_VERSION}" == "3.6" ]]; then \                                                                                                             
         #apt-get  -o Acquire::Check-Valid-Until=false  -o Acquire::Check-Date=false  update &&  apt-get install -y python${PYTHON_VERSION}-distutils; \       
               #apt-get install -y python${PYTHON_VERSION}-distutils; \                                                                                              
         apt-get install -y python${PYTHON_VERSION}; \                                                                                                         
    fi                                                                                                                                                        

# install pip3
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \                                
    python3 get-pip.py && \                                                          
    rm get-pip.py                                                                    

# Install Open MPI
# RUN mkdir /tmp/openmpi && \
#     cd /tmp/openmpi && \
#     wget https://www.open-mpi.org/software/ompi/v4.0/downloads/openmpi-4.0.2.tar.gz && \
#     tar zxf openmpi-4.0.2.tar.gz && \
#     cd openmpi-4.0.2 && \
#     ./configure --enable-orterun-prefix-by-default   --with-cuda=/usr/local/cuda && \
#      make -j $(nproc) all && \
#      make install && \
#      ldconfig && \
#      rm -rf /tmp/openmpi

# Install OpenSSH for MPI to communicate between containers                                   
RUN apt-get update && apt-get install -y --no-install-recommends openssh-client openssh-server && \
    mkdir -p /var/run/sshd

# Allow OpenSSH to talk to containers without asking for confirmation                         
RUN cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \       
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \                          
    cat /etc/ssh/sshd_config | grep -v  PermitRootLogin> /etc/ssh/sshd_config.new && \           
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config.new && \                                  
    mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config && \                                          
    mv /etc/ssh/sshd_config.new /etc/ssh/sshd_config                                             

# jupyter
RUN pip3 install jupyter \
                jupyterlab \
#                scipy \
#                opencv-python \
#                tqdm \
#                mpi4py \
#                matplotlib \
&& \
    apt-get clean \
&& \
    rm -rf /var/lib/apt/lists/*

# jupyter
RUN mkdir /etc/jupyter/ && wget -P /etc/jupyter/  https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/jupyter_notebook_config.py
RUN wget -P /etc/jupyter/ https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/custom.js

#RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /root/.cache/pip/http/*
#RUN rm -rf /usr/local/cuda/targets/x86_64-linux/lib/*static*
#RUN rm -rf /usr/lib/x86_64-linux-gnu/*static*

#RUN export PATH=/usr/local/bin/mpi:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

