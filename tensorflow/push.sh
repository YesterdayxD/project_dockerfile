#docker tag 10.151.11.53:5000/aistation/iresource-cachedata        : latest                  10.166.15.243:5050/aistation/iresource-cachedata        : latest           
#docker tag 10.151.11.53:5000/aistation/gpu-device-plugin          : latest                  10.166.15.243:5050/aistation/gpu-device-plugin          : latest           
docker tag 10.151.11.53:5000/caffe/caffe:19.06-py2               10.166.15.243:5050/caffe/caffe:19.06-py2        
#docker tag 10.151.11.53:5000/aistation/k8s-rdma-sriov-dev-plugin  : latest                  10.166.15.243:5050/aistation/k8s-rdma-sriov-dev-plugin  : latest           
#docker tag 10.151.11.53:5000/aistation/nvidia-gpu-device-plugin   : latest                  10.166.15.243:5050/aistation/nvidia-gpu-device-plugin   : latest           
#docker tag 10.151.11.53:5000/aistation/initstorcontainer          : v1                      10.166.15.243:5050/aistation/initstorcontainer          : v1               
docker tag 10.151.11.53:5000/tensorflow/tensorflow:1.14-cuda10-py36        10.166.15.243:5050/tensorflow/tensorflow:1.14-cuda10-py36 
docker tag 10.151.11.53:5000/mxnet/mxnet:1.5.0-cuda10-py36       10.166.15.243:5050/mxnet/mxnet:1.5.0-cuda10-py36
docker tag 10.151.11.53:5000/pytorch/pytorch:1.1.0-cuda10-py36       10.166.15.243:5050/pytorch/pytorch:1.1.0-cuda10-py36
docker tag 10.151.11.53:5000/paddlepaddle/paddlepaddle:1.5.1-cuda10-py36       10.166.15.243:5050/paddlepaddle/paddlepaddle:1.5.1-cuda10-py36
#docker tag 10.151.11.53:5000/com.inspur/busybox                   : 1.31.0                  10.166.15.243:5050/com.inspur/busybox                   : 1.31.0           
#docker tag 10.151.11.53:5000/com.inspur/kubectl-delivery          : dev                     10.166.15.243:5050/com.inspur/kubectl-delivery          : dev              
#docker tag 10.151.11.53:5000/com.inspur/nginx                     : 1.15                    10.166.15.243:5050/com.inspur/nginx                     : 1.15             
#docker tag 10.151.11.53:5000/com.inspur/kube-proxy                : v1.14.1                 10.166.15.243:5050/com.inspur/kube-proxy                : v1.14.1          
#docker tag 10.151.11.53:5000/other/centosyum-liuxf                : 1219                    10.166.15.243:5050/other/centosyum-liuxf                : 1219             
#docker tag 10.151.11.53:5000/other/test-yuanshao                  : yuanshao                10.166.15.243:5050/other/test-yuanshao                  : yuanshao         
#docker tag 10.151.11.53:5000/tensorflow/tensorflow-yuanshao       : 1-13-centos             10.166.15.243:5050/tensorflow/tensorflow-yuanshao       : 1-13-centos      
#docker tag 10.151.11.53:5000/visualization/netscope               : latest                  10.166.15.243:5050/visualization/netscope               : latest           
#docker tag 10.151.11.53:5000/com.inspur/calico/node               : v3.4.0                  10.166.15.243:5050/com.inspur/calico/node               : v3.4.0           
#docker tag 10.151.11.53:5000/com.inspur/calico/cni                : v3.4.0                  10.166.15.243:5050/com.inspur/calico/cni                : v3.4.0           
#docker tag 10.151.11.53:5000/com.inspur/pause-amd64               : 3.1                     10.166.15.243:5050/com.inspur/pause-amd64               : 3.1              

################################
#docker push  10.166.15.243:5050/caffe/caffe:19.06-py2         
#docker push  10.166.15.243:5050/tensorflow/tensorflow:1.14-cuda10-py36  
docker push  10.166.15.243:5050/mxnet/mxnet:1.5.0-cuda10-py36 
docker push  10.166.15.243:5050/pytorch/pytorch:1.1.0-cuda10-py36 
docker push  10.166.15.243:5050/paddlepaddle/paddlepaddle:1.5.1-cuda10-py36 


docker push 10.166.15.243:5050/tensorflow/tensorflow:1.8-cuda9-py35-ubuntu16.04    
docker push 10.166.15.243:5050/tensorflow/tensorflow:1.10-cuda9-py35-ubuntu16.04  
docker push 10.166.15.243:5050/tensorflow/tensorflow:1.10-cuda9-py27-ubuntu16.04  
docker push 10.166.15.243:5050/cuda/nvidia-cuda:8.0-cudnn6-devel-ubuntu16.04
docker push 10.166.15.243:5050/cuda/nvidia-cuda:9.0-cudnn7-devel-ubuntu16.04
