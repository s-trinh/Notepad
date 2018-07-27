## catkin_make
- `catkin_make VERBOSE=1 -j4 --pkg my_package -DCMAKE_BUILD_TYPE=RelWithDebInfo --cmake-args -DVISP_DIR=path_to_visp`
- [How to specify my own OpenCV3 for cv_bridge](https://answers.ros.org/question/289090/how-to-specify-my-own-opencv3-for-cv_bridge/?answer=289155#post-id-289155):
> You do not need to modify cv_bridge source code for this. You can point cmake to your own opencv version by defining the OpenCV_DIR variable when running catkin_make.
>
> For example:
>
> If you compile and install your own OpenCV version like:
>
> ```
> cd opencv
> mkdir build
> cd build
> cmake ..
> make 
> sudo make install
> ```
> It will be installed to /usr/local
>
> In this case you can force catkin_make to build your workspace against this OpenCV version by running:
>
> `catkin_make -DOpenCV_DIR=/usr/local/share/OpenCV`
>
> Note that OpenCV_DIR must point to a folder with opencv-conifg.cmake file.
>
> This will compile and link all packages in your workspace against the modified opencv version, rather than the opencv version shipped with ROS.
>
> Alternatively, if you do not want to polute your system directories you can run
>
> `make DESTDIR=$HOME/opencv_installation install`
>
> when building and installing opencv. This will place the opencv installation in your home folder (or whereever you like) so you can comfortably remove it.
>
> In this case you run
>
> `catkin_make -DOpenCV_DIR=$HOME/opencv_installation install/usr/local/share/OpenCV`
>
> for building the workspace.
>
> Important note:
>
> All libraries that are linked in an executable have to use the same opencv version, otherwise attempting to run them will cause segfaults. Packages that are installed via sudo apt-get install ros-kinetic-whatever do link against the OpenCV version shipped with ROS. If your exec uses any lib package of ROS (frequently image_transport, image_geometry, image_pipeline, cv_bridge etc) you have to check them out from github and place them in your catkin workspace alongide your own packages so these are also compiled against your modified OpenCV version.
- use a custom OpenCV version instead of the ROS one:
  - [Give priority to custom build OpenCV #149](https://github.com/ros-perception/image_pipeline/issues/149)
  - remove ROS OpenCV using the package manager, lots of packages depend on OpenCV, especially `ros-perception`, `ros-visualization`, `ros-simulation`? Be careful to note the dependencies that will be removed.
  - install the needed dependencies, something like:
```
git clone https://github.com/ros-perception/image_pipeline.git
git clone https://github.com/ros-perception/image_transport_plugins.git
git clone https://github.com/ros-perception/vision_opencv.git
git clone https://github.com/ros-drivers/openni2_camera.git
git clone https://github.com/ros-drivers/rgbd_launch.git
git clone https://github.com/ros-visualization/rqt_image_view.git
```
  - build everything with the desired OpenCV build: `catkin_make VERBOSE=1 -j4 -DCMAKE_BUILD_TYPE=RelWithDebInfo --cmake-args -DVISP_DIR=visp_buid -DOpenCV_DIR=opencv_build/install/share/OpenCV 2>&1 | tee log_build_without_ROS_OpenCV.txt`

## ROS
- locate a package: `rospack find rviz`
