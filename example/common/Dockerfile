#FROM cuda:10.1-cudnn7-devel-ubuntu18.04-inpsur                       # inspur base image(jupyter, ssh included)
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04                       # nvidia base image(jupyter, ssh exclued)
                                                                                                                                                                                
## TensorFlow version is tightly coupled to CUDA and cuDNN so it should be selected carefully                                                                                    
ENV TENSORFLOW_VERSION=1.13.1                                                                                                                                                   


## Python 3.6 is supported by Ubuntu Bionic out of the box                                                                                                                
ARG python=3.6                                                                                                                                                                  
ENV PYTHON_VERSION=${python}                                                                                                                                                    
                                                                                                                                                                                
## Set default shell to /bin/bash                                                                                                                                                
SHELL ["/bin/bash", "-cu"]                                                                                                                                                      
                                                                                                                                                                                
# python 3.6 for ubuntu16.04                                                                                   
#RUN  apt-get update && apt-get install -y software-properties-common python-software-properties                        
#RUN  add-apt-repository ppa:deadsnakes/ppa                                                                             
                                                                                                                                                                                
## need followings when 18.04 is used                                                                                                                                            
RUN  apt-get install -y apt-transport-https                                                                                                                                     
RUN  echo 'deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /' > /etc/apt/sources.list.d/cuda.list                                                
                                                                                                                                                                                
RUN apt-get -o Acquire::Check-Valid-Until=false  -o Acquire::Check-Date=false   update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \                                                                                                                                                                          
        build-essential \                                                                                                                                                       
        cmake \                                                                                                                                                                 
        software-properties-common \                                                                                                                                            
        git \                                                                                                                                                                   
        curl \                                                                                                                                                                  
        vim \                                                                                                                                                                   
        wget \                                                                                                                                                                  
        net-tools \                                                                                                                                                             
        inetutils-ping \                                                                                                                                                        
        bzip2 \                                                                                                                                                                 
        unzip \                                                                                                                                                      
        ca-certificates \                                                                                                                                            
        libjpeg-dev \                                                                                                                                                
        libpng-dev \                                                                                                                                                 
        python${PYTHON_VERSION} \                                                                                                                                    
        python${PYTHON_VERSION}-dev \                                                                                                                                
        librdmacm1 \                                                                                                                                                 
        libibverbs1 \                                                                                                                                                
        ibverbs-providers \                                                                                                                                          
&& \                                                                                                                                                                
     apt-get clean \                                                                                                                                                
&& \                                                                                                                                                                 
     rm -rf /var/lib/apt/lists/*                                                                                                                                     

# Install the python3.6-distutils                                                                                                                                                                     
RUN add-apt-repository universe                                                                                                                                      
RUN if [[ "${PYTHON_VERSION}" == "3.6" ]]; then \                                                                                                                    
        apt-get -o Acquire::Check-Valid-Until=false  -o Acquire::Check-Date=false update && apt-get  install -y python${PYTHON_VERSION}-distutils; \               
    fi                                                                                                                                                               
                                                                                                                                                                     
RUN ln -s /usr/bin/python${PYTHON_VERSION} /usr/bin/python                                                                                                           
                                                                                                                                                                     
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \                                                                                                                
    python get-pip.py && \                                                                                                                                           
    rm get-pip.py                                                                                                                                                    
                                                                                                                                                                     
# Install TensorFlow, Keras, PyTorch and MXNet                                                                                                                      
RUN pip --no-cache-dir install future typing                                                                                                                         

# For python2.7
#RUN apt update && apt install -y python-pip && pip2 --no-cache-dir install tensorflow-gpu==${TENSORFLOW_VERSION} numpy==1.11.0 

# For python3
RUN pip --no-cache-dir install  tensorflow-gpu==${TENSORFLOW_VERSION} \ 
        keras \                                                                   
        h5py \                                                                                                                                                       
&& \                                                                                                                                                                 
    rm -rf /root/.cache/pip/http/*                                                                                                                                   
                                                                                                                                                                     
#RUN pip3 --no-cache-dir install torch torchvision \                                                                                                                 
#&& \                                                                                                                                                                 
#    rm -rf /root/.cache/pip/http/*                                                                                                                                   
                                                                                                                                                                     
# Install Open MPI                                                                                                                                                   
RUN mkdir /tmp/openmpi && \                                                                                                                                          
    cd /tmp/openmpi && \                                                                                                                                             
    wget https://www.open-mpi.org/software/ompi/v4.0/downloads/openmpi-4.0.2.tar.gz && \                                                                             
    tar zxf openmpi-4.0.2.tar.gz && \                                                                                                                                
    cd openmpi-4.0.2 && \                                                                                                                                            
    ./configure --enable-orterun-prefix-by-default  --with-cuda=/usr/local/cuda  && \                                                                                
    make -j $(nproc) all && \                                                                                                                                        
    make install && \                                                                                                                                                
    ldconfig && \                                                                                                                                                    
    rm -rf /tmp/openmpi                                                                                                                                              
                                                                                                                                                                     
# Install Horovod, temporarily using CUDA stubs                                                                                                                      
RUN ldconfig /usr/local/cuda/targets/x86_64-linux/lib/stubs && \                                                                                                     
    HOROVOD_GPU_ALLREDUCE=NCCL  HOROVOD_WITH_TENSORFLOW=1 pip install --no-cache-dir horovod==0.16.3 && \                                                                       
    ldconfig                                                                                                                                                         


# Install OpenSSH for MPI to communicate between containers                                                                                           
RUN apt-get install -y --no-install-recommends openssh-client openssh-server && \                                                                     
    mkdir -p /var/run/sshd                                                                                                                            
                                                                                                                                                      
# Allow OpenSSH to talk to containers without asking for confirmation                                                                                 
RUN cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \                                                            
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \                                                                               
    cat /etc/ssh/sshd_config | grep -v  PermitRootLogin> /etc/ssh/sshd_config.new && \                                                                
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config.new && \                                                                                       
    mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config && \                                                                                               
    mv /etc/ssh/sshd_config.new /etc/ssh/sshd_config                                                                                                  
                                                                                                                                                      
## Download examples                                                                                                                                   
#RUN apt-get install -y --no-install-recommends subversion && \                                                                                        
#    svn checkout https://github.com/horovod/horovod/trunk/examples && \                                                                               
#    rm -rf /examples/.svn                                                                                                                             
                                                                                                                                                      
# python tools                                                                                                                                        
RUN pip --no-cache-dir install jupyter \                                                                                                              
                jupyterlab \                                                                                                                          
                scipy \                                                                                                                               
                opencv-python \                                                                                                                       
                tensorboardX \                                                                                                                        
                mxboard  \                                                                                                                            
                tqdm \                                                                                                                                
                mpi4py \                                                                                                                              
                matplotlib \                                                                                                                          
&& \                                                                                                                                                  
    rm -rf /root/.cache/pip/http/*                                                                                                                    
                                                                                                                                                      
# fix opencv issues                                                                                                                                   
#RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \                                   
RUN apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \                                                      
            libsm-dev \                                                                                                                               
            libxrender1 \                                                                                                                             
            libxext-dev  \                                                                                                                            
&& \                                                                                                                                                  
     apt-get clean \                                                                                                                                  
&& \                                                                                                                                                  
     rm -rf /var/lib/apt/lists/*                                                                                                                      
                                                                                                                                                      
# jupyter                                                                                                                                              
RUN mkdir /etc/jupyter/ && wget -P /etc/jupyter/  https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/jupyter_notebook_config.py            
RUN wget -P /etc/jupyter/ https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/custom.js                                                     
                                                                                                                                                      
## clean up cuda lib                                                                                                                                   
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /root/.cache/pip/http/*                                                                    
