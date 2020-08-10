FROM cuda:10.1-cudnn7-devel-ubuntu18.04-inpsur                       # inspur base image(jupyter, ssh included)
#FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04                       # nvidia base image(jupyter, ssh exclued)
                                                                                                                                                                                
## TensorFlow version is tightly coupled to CUDA and cuDNN so it should be selected carefully                                                                                    
ENV TENSORFLOW_VERSION=1.13.1                                                                                                                                                   

## Python 3.6 is supported by Ubuntu Bionic out of the box                                                                                                                
ARG python=3.6                                                                                                                                                                  
ENV PYTHON_VERSION=${python}                                                                                                                                                    
                                                                                                                                                                                
# Install TensorFlow, Keras                                                                                                                      
RUN pip --no-cache-dir install future typing                                                                                                                         

# For python2.7
#RUN apt update && apt install -y python-pip && pip2 --no-cache-dir install tensorflow-gpu==${TENSORFLOW_VERSION} numpy==1.11.0 

# For python3
RUN pip --no-cache-dir install  tensorflow-gpu==${TENSORFLOW_VERSION} \ 
        keras \                                                                   
        h5py \                                                                                                                                                       
&& \                                                                                                                                                                 
    rm -rf /root/.cache/pip/http/*                                                                                                                                   
                                                                                                                                                                     
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

## Download examples                                                                                                                                   
#RUN apt-get install -y --no-install-recommends subversion && \                                                                                        
#    svn checkout https://github.com/horovod/horovod/trunk/examples && \                                                                               
#    rm -rf /examples/.svn                                                                                                                             
                                                                                                                                                      
## clean up cuda lib                                                                                                                                   
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /root/.cache/pip/http/*                                                                    
