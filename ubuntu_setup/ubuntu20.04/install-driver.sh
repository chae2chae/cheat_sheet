#!/bin/bash 

# NVIDIA-DRIVER install
sudo apt install nvidia-driver-510
sudo rm -rf /usr/local/cuda*
# CUDA install
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda_11.7.0_515.43.04_linux.run
sudo sh cuda_11.7.0_515.43.04_linux.run
## Continue / accept / Driver unchecking / install -> success : summary and logfile is  /var/log/cuda-installer.log

# Bashrc
echo 'export PATH=$PATH:/usr/local/cuda-11.7/bin' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.7/lib64' >> ~/.bashrc
echo 'export CUDADIR=/usr/local/cuda-11.7' >> ~/.bashrc
echo "alias eb='sudo gedit ~/.bashrc'" >> ~/.bashrc
echo "alias sb='source ~/.bashrc'">> ~/.bashrc

# CUDNN install
# Download to https://developer.nvidia.com/rdp/cudnn-archive
tar -xvf cudnn-linux-x86_64-8.7.0.84_cuda11-archive.tar.xz

sudo cp cudnn-linux-x86_64-8.7.0.84_cuda11-archive/include/cudnn* /usr/local/cuda/include
sudo cp cudnn-linux-x86_64-8.7.0.84_cuda11-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/includ/cudnn.h /usr/local/cuda/lib64/libcudnn*


# CUDNN Symbolic
# sudo ln -sf /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_train.so.8.7.0 /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_train.so.8
# sudo ln -sf /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8.7.0  /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8
# sudo ln -sf /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8.7.0  /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8
# sudo ln -sf /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8.7.0  /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8
# sudo ln -sf /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_train.so.8.7.0  /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_train.so.8
# sudo ln -sf /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.8.7.0 /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.8
# sudo ln -sf /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn.so.8.7.0  /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn.so.8
# sudo ldconfig
# ldconfig -N -v $(sed's/://'<<<$LD_LIBRARY_PATH)2>/dev/null|grep libcudnn

# Cudnn Symbolic link 2 (https://lapina.tistory.com/130)
cd /usr/local/cuda-11.7/lib64
ls -al libcudnn.so*

sudo ln -sf libcudnn.so.8.7.0 libcudnn.so.8
sudo ln -sf libcudnn.so.8 libcudnn.so

ls -al libcudnn.so*
ldconfig -N -v $(sed 's/:/ /' <<< $LD_LIBRARY_PATH) 2>/dev/null | grep libcudnn

# If done successfully, it should look like below
#-------------------------------------------------------------#
	# libcudnn_ops_infer.so.8 -> libcudnn_ops_infer.so.8.7.0
	# libcudnn.so.8 -> libcudnn.so.8.7.0
	# libcudnn_ops_train.so.8 -> libcudnn_ops_train.so.8.7.0
	# libcudnn_adv_infer.so.8 -> libcudnn_adv_infer.so.8.7.0
	# libcudnn_cnn_train.so.8 -> libcudnn_cnn_train.so.8.7.0
	# libcudnn_cnn_infer.so.8 -> libcudnn_cnn_infer.so.8.7.0
	# libcudnn_adv_train.so.8 -> libcudnn_adv_train.so.8.7.0
#-------------------------------------------------------------#

