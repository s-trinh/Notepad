## Build
- With Intel MKL on Ubuntu 16.04: `ccmake ../opencv -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules -DMKL_ROOT_DIR=/opt/intel/compilers_and_libraries/linux/mkl`

## OpenCV with Intel Inference Engine
- Fresh Ubuntu 16.04 install: (see [https://tecadmin.net/install-ffmpeg-on-linux/](https://tecadmin.net/install-ffmpeg-on-linux/) to install latest FFmpeg on Ubuntu 16.04)
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install terminator
sudo apt-get install synaptic
sudo apt-get install cmake
sudo apt install cmake-curses-gui
sudo apt install git
sudo apt-get install geany
sudo add-apt-repository ppa:jonathonf/ffmpeg-3
sudo apt-get update
sudo apt-get install ffmpeg libav-tools x264 x265
ffmpeg -version
```
- Install [Intel MKL](https://software.intel.com/en-us/mkl)
- Configure environment variables: `source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh intel64`
- Install [OpenVINO](https://software.seek.intel.com/openvino-toolkit)
- Configure environment variables: `source /opt/intel/computer_vision_sdk/bin/setupvars.sh`
- Build OpenCV from source with Intel Inference Engine:
```
source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh intel64
source /opt/intel/computer_vision_sdk/bin/setupvars.sh
ccmake ../opencv -DWITH_INF_ENGINE=ON -DINTEL_CVSDK_DIR="/opt/intel/computer_vision_sdk/deployment_tools/" -DIE_PLUGINS_PATH="/opt/intel/computer_vision_sdk/deployment_tools/inference_engine/lib/ubuntu_16.04/intel64/" -DENABLE_CXX11=ON
```
- Export OpenCV: `export OpenCV_DIR=/home/opencv-build/install/share/OpenCV`
- Test OpenVINO demo apps:
```
cd /opt/intel/computer_vision_sdk/deployment_tools/demo
./demo_security_barrier_camera.sh
```
