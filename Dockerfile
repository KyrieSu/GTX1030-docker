FROM ubuntu:16.04

ENV cuda cuda_8.0.61_375.26_linux-run
ENV cudnn cudnn-8.0-linux-x64-v6.0.tgz

RUN apt-get update && \
    apt-get install -y sudo curl wget vim git software-properties-common && \
    apt-get install -y perl make build-essential pkg-config cmake g++ && \
    # install nVidia driver
    add-apt-repository -y ppa:graphics-drivers/ppa && \
    echo "83\n1\n" | apt install --no-install-recommends -y nvidia-390 nvidia-390-dev libcuda1-390 && \
    apt-get update && \
    apt-get -y upgrade && \
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/$cuda && \
    chmod +x $cuda && \
    $cuda --silent --toolkit --samples && \
    echo "/usr/local/cuda-8.0/lib64" >> /etc/ld.so.conf && \
    echo "export PATH=$PATH:/usr/local/cuda-8.0/bin" >> ~/.bashrc && \
    wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/$cudnn && \
    tar -xzvf $cudnn && \
    cp -P cuda/include/cudnn.h /usr/local/cuda-8.0/include && \
    cp -P cuda/lib64/libcudnn* /usr/local/cuda-8.0/lib64/ && \
    chmod a+r /usr/local/cuda-8.0/lib64/libcudnn* && \
    echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >> ~/.bashrc && \
    source ~/.bashrc
    # install python3.5
    apt-get install -y libglu1-mesa libxi-dev libxmu-dev libglu1-mesa-dev python3 python3-pip libsm6 libxrender1 libxext-dev && \
    # install python package
    apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pip && \
    

CMD ["nvcc","--version"]
