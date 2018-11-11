## Build
- With Intel MKL on Ubuntu 16.04: `ccmake ../opencv -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules -DMKL_ROOT_DIR=/opt/intel/compilers_and_libraries/linux/mkl`
- With OpenCV 4 and MinGW on AppVeyor and image is `Visual Studio 2017`, see also [issue #12642](https://github.com/opencv/opencv/issues/12642) and [issue #12831](https://github.com/opencv/opencv/issues/12831):
```
set PATH=%PATH:C:\Program Files\Git\usr\bin;=%
set PATH=C:\mingw-w64\x86_64-7.3.0-posix-seh-rt_v5-rev0\mingw64\bin;%PATH%
cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF -DBUILD_opencv_gapi=OFF -DWITH_MSMF=OFF -DENABLE_PRECOMPILED_HEADERS=OFF -DWITH_CUDA=OFF -DWITH_IPP=OFF -DWITH_OPENCL=OFF ..\opencv
cmake --build . --config Release --target install -- -j2
```

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
sudo apt-get install python2.7-dev python3.5-dev
sudo apt-get install python-pip
sudo pip install numpy scipy
```
- Install [Intel MKL](https://software.intel.com/en-us/mkl)
- Configure environment variables: `source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh intel64`
- Install [OpenVINO](https://software.seek.intel.com/openvino-toolkit): [https://software.intel.com/en-us/articles/OpenVINO-Install-Linux](https://software.intel.com/en-us/articles/OpenVINO-Install-Linux)
- Configure environment variables: `source /opt/intel/computer_vision_sdk/bin/setupvars.sh`
- Build OpenCV from source with Intel Inference Engine:
```
source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh intel64
source /opt/intel/computer_vision_sdk/bin/setupvars.sh
ccmake ../opencv -DWITH_INF_ENGINE=ON -DENABLE_CXX11=ON
```
- Export OpenCV: `export OpenCV_DIR=/home/opencv-build/install/share/OpenCV`
- Test OpenVINO demo apps:
```
cd /opt/intel/computer_vision_sdk/deployment_tools/demo
./demo_security_barrier_camera.sh
```

## Run performance tests
- Set `OPENCV_TEST_DATA_PATH` to `<opencv_extra>/testdata`
- List tests: `python <opencv>/modules/ts/misc/run.py <opencv-build> -t <opencv module> --gtest_list_tests`
- Run perf test: `python <opencv>/modules/ts/misc/run.py <opencv-build> -w ./logs -t <opencv_module> --gtest_filter=*perf_test_name*`
- Compare perf results: `python <opencv>/modules/ts/misc/summary.py opencv_module*.xml -o markdown`
