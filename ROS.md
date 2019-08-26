## catkin_make
- `catkin_make VERBOSE=1 -j4 --pkg my_package -DCMAKE_BUILD_TYPE=RelWithDebInfo --cmake-args -DVISP_DIR=path_to_visp`

## Use custom OpenCV version
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
  
## Use custom OpenCV version (remove ros-kinetic-opencv3)
- Version of `ros-kinetic-opencv3`
```
General configuration for OpenCV 3.3.1-dev =====================================
  Version control:               unknown

  Extra modules:
    Location (extra):            /tmp/binarydeb/ros-kinetic-opencv3-3.3.1/opencv_contrib
    Version control (extra):     unknown

  Platform:
    Timestamp:                   2018-08-09T21:49:19Z
    Host:                        Linux 4.4.0-1060-aws x86_64
    CMake:                       3.5.1
    CMake generator:             Unix Makefiles
    CMake build tool:            /usr/bin/make
    Configuration:               Release

  CPU/HW features:
    Baseline:                    SSE SSE2 SSE3
      requested:                 SSE3
    Dispatched code generation:  SSE4_1 SSE4_2 FP16 AVX AVX2
      requested:                 SSE4_1 SSE4_2 AVX FP16 AVX2
      SSE4_1 (3 files):          + SSSE3 SSE4_1
      SSE4_2 (1 files):          + SSSE3 SSE4_1 POPCNT SSE4_2
      FP16 (1 files):            + SSSE3 SSE4_1 POPCNT SSE4_2 FP16 AVX
      AVX (5 files):             + SSSE3 SSE4_1 POPCNT SSE4_2 AVX
      AVX2 (9 files):            + SSSE3 SSE4_1 POPCNT SSE4_2 FP16 FMA3 AVX AVX2

  C/C++:
    Built as dynamic libs?:      YES
    C++ Compiler:                /usr/lib/ccache/x86_64-linux-gnu-g++  (ver 5.4.0)
    C++ flags (Release):         -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -DNDEBUG -Wdate-time -D_FORTIFY_SOURCE=2    -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Winit-self -Wno-narrowing -Wno-delete-non-virtual-dtor -Wno-comment -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -fvisibility-inlines-hidden -O3 -DNDEBUG  -DNDEBUG
    C++ flags (Debug):           -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -DNDEBUG -Wdate-time -D_FORTIFY_SOURCE=2    -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Winit-self -Wno-narrowing -Wno-delete-non-virtual-dtor -Wno-comment -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -fvisibility-inlines-hidden -g  -DDEBUG -D_DEBUG
    C Compiler:                  /usr/lib/ccache/x86_64-linux-gnu-gcc
    C flags (Release):           -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2    -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Winit-self -Wno-narrowing -Wno-comment -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -O3 -DNDEBUG  -DNDEBUG
    C flags (Debug):             -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2    -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Winit-self -Wno-narrowing -Wno-comment -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -g  -DDEBUG -D_DEBUG
    Linker flags (Release):
    Linker flags (Debug):
    ccache:                      YES
    Precompiled headers:         NO
    Extra dependencies:          dl m pthread rt
    3rdparty dependencies:

  OpenCV modules:
    To be built:                 aruco bgsegm bioinspired calib3d ccalib core cvv datasets dnn dpm face features2d flann fuzzy hdf highgui img_hash imgcodecs imgproc line_descriptor ml objdetect optflow phase_unwrapping photo plot python2 python_bindings_generator reg rgbd saliency shape stereo stitching structured_light superres surface_matching text tracking video videoio videostab viz xfeatures2d ximgproc xobjdetect xphoto
    Disabled:                    js world
    Disabled by dependency:      -
    Unavailable:                 cnn_3dobj cudaarithm cudabgsegm cudacodec cudafeatures2d cudafilters cudaimgproc cudalegacy cudaobjdetect cudaoptflow cudastereo cudawarping cudev dnn_modern freetype java matlab ovis python3 sfm ts
    Applications:                apps
    Documentation:               NO
    Non-free algorithms:         NO

  GUI: 
    QT:                          YES (ver 5.5.1)
      QT OpenGL support:         NO
    GTK+:                        NO
    VTK support:                 YES (ver 6.2.0)

  Media I/O: 
    ZLib:                        /usr/lib/x86_64-linux-gnu/libz.so (ver 1.2.8)
    JPEG:                        /usr/lib/x86_64-linux-gnu/libjpeg.so (ver )
    WEBP:                        /usr/lib/x86_64-linux-gnu/libwebp.so (ver encoder: 0x0202)
    PNG:                         /usr/lib/x86_64-linux-gnu/libpng.so (ver 1.2.54)
    TIFF:                        /usr/lib/x86_64-linux-gnu/libtiff.so (ver 42 / 4.0.6)
    JPEG 2000:                   /usr/lib/x86_64-linux-gnu/libjasper.so (ver 1.900.1)
    OpenEXR:                     build (ver 1.7.1)

  Video I/O:
    DC1394:                      NO
    FFMPEG:                      YES
      avcodec:                   YES (ver 56.60.100)
      avformat:                  YES (ver 56.40.101)
      avutil:                    YES (ver 54.31.100)
      swscale:                   YES (ver 3.1.101)
      avresample:                NO
    GStreamer:                   NO
    libv4l/libv4l2:              NO
    v4l/v4l2:                    linux/videodev2.h
    gPhoto2:                     NO

  Parallel framework:            pthreads

  Trace:                         YES (with Intel ITT)

  Other third-party libraries:
    Intel IPP:                   2017.0.3 [2017.0.3]
           at:                   /tmp/binarydeb/ros-kinetic-opencv3-3.3.1/obj-x86_64-linux-gnu/3rdparty/ippicv/ippicv_lnx
    Intel IPP IW:                sources (2017.0.3)
              at:                /tmp/binarydeb/ros-kinetic-opencv3-3.3.1/obj-x86_64-linux-gnu/3rdparty/ippicv/ippiw_lnx
    Lapack:                      NO
    Eigen:                       YES (ver 3.2.92)
    Custom HAL:                  NO

  NVIDIA CUDA:                   NO

  OpenCL:                        YES (no extra features)
    Include path:                /tmp/binarydeb/ros-kinetic-opencv3-3.3.1/3rdparty/include/opencl/1.2
    Link libraries:              Dynamic load

  Python 2:
    Interpreter:                 /usr/bin/python2.7 (ver 2.7.12)
    Libraries:                   /usr/lib/x86_64-linux-gnu/libpython2.7.so (ver 2.7.12)
    numpy:                       /usr/lib/python2.7/dist-packages/numpy/core/include (ver 1.11.0)
    packages path:               lib/python2.7/dist-packages

  Python (for build):            /usr/bin/python2.7

  Java:
    ant:                         NO
    JNI:                         NO
    Java wrappers:               NO
    Java tests:                  NO

  Matlab:                        NO

  Install to:                    /opt/ros/kinetic
-----------------------------------------------------------------
```
- remove ROS OpenCV using the package manager, lots of packages depend on OpenCV, especially `ros-perception`, `ros-visualization`, `ros-simulation`? Be careful to note the dependencies that will be removed.
- `rospack depends opencv3`
```
$ rospack depends opencv3 
catkin
```
- `rospack depends-on opencv3`
```
$ rospack depends-on opencv3 
compressed_depth_image_transport
image_rotate
image_publisher
depth_image_proc
image_proc
image_geometry
image_view
camera_calibration
pointgrey_camera_driver
compressed_image_transport
gazebo_plugins
rqt_image_view
theora_image_transport
cv_bridge
stereo_image_proc
```
- `rospack list`
```
$ rospack list
actionlib /opt/ros/kinetic/share/actionlib
actionlib_msgs /opt/ros/kinetic/share/actionlib_msgs
actionlib_tutorials /opt/ros/kinetic/share/actionlib_tutorials
angles /opt/ros/kinetic/share/angles
bond /opt/ros/kinetic/share/bond
bondcpp /opt/ros/kinetic/share/bondcpp
bondpy /opt/ros/kinetic/share/bondpy
camera_calibration /opt/ros/kinetic/share/camera_calibration
camera_calibration_parsers /opt/ros/kinetic/share/camera_calibration_parsers
camera_info_manager /opt/ros/kinetic/share/camera_info_manager
catkin /opt/ros/kinetic/share/catkin
class_loader /opt/ros/kinetic/share/class_loader
cmake_modules /opt/ros/kinetic/share/cmake_modules
collada_parser /opt/ros/kinetic/share/collada_parser
collada_urdf /opt/ros/kinetic/share/collada_urdf
compressed_depth_image_transport /opt/ros/kinetic/share/compressed_depth_image_transport
compressed_image_transport /opt/ros/kinetic/share/compressed_image_transport
control_msgs /opt/ros/kinetic/share/control_msgs
control_toolbox /opt/ros/kinetic/share/control_toolbox
controller_interface /opt/ros/kinetic/share/controller_interface
controller_manager /opt/ros/kinetic/share/controller_manager
controller_manager_msgs /opt/ros/kinetic/share/controller_manager_msgs
cpp_common /opt/ros/kinetic/share/cpp_common
cv_bridge /opt/ros/kinetic/share/cv_bridge
depth_image_proc /opt/ros/kinetic/share/depth_image_proc
diagnostic_aggregator /opt/ros/kinetic/share/diagnostic_aggregator
diagnostic_analysis /opt/ros/kinetic/share/diagnostic_analysis
diagnostic_common_diagnostics /opt/ros/kinetic/share/diagnostic_common_diagnostics
diagnostic_msgs /opt/ros/kinetic/share/diagnostic_msgs
diagnostic_updater /opt/ros/kinetic/share/diagnostic_updater
diff_drive_controller /opt/ros/kinetic/share/diff_drive_controller
dynamic_reconfigure /opt/ros/kinetic/share/dynamic_reconfigure
eigen_conversions /opt/ros/kinetic/share/eigen_conversions
eigen_stl_containers /opt/ros/kinetic/share/eigen_stl_containers
filters /opt/ros/kinetic/share/filters
forward_command_controller /opt/ros/kinetic/share/forward_command_controller
gazebo_msgs /opt/ros/kinetic/share/gazebo_msgs
gazebo_plugins /opt/ros/kinetic/share/gazebo_plugins
gazebo_ros /opt/ros/kinetic/share/gazebo_ros
gazebo_ros_control /opt/ros/kinetic/share/gazebo_ros_control
gencpp /opt/ros/kinetic/share/gencpp
geneus /opt/ros/kinetic/share/geneus
genlisp /opt/ros/kinetic/share/genlisp
genmsg /opt/ros/kinetic/share/genmsg
gennodejs /opt/ros/kinetic/share/gennodejs
genpy /opt/ros/kinetic/share/genpy
geometric_shapes /opt/ros/kinetic/share/geometric_shapes
geometry_msgs /opt/ros/kinetic/share/geometry_msgs
gl_dependency /opt/ros/kinetic/share/gl_dependency
hardware_interface /opt/ros/kinetic/share/hardware_interface
image_exposure_msgs /opt/ros/kinetic/share/image_exposure_msgs
image_geometry /opt/ros/kinetic/share/image_geometry
image_proc /opt/ros/kinetic/share/image_proc
image_publisher /opt/ros/kinetic/share/image_publisher
image_rotate /opt/ros/kinetic/share/image_rotate
image_transport /opt/ros/kinetic/share/image_transport
image_view /opt/ros/kinetic/share/image_view
interactive_marker_tutorials /opt/ros/kinetic/share/interactive_marker_tutorials
interactive_markers /opt/ros/kinetic/share/interactive_markers
joint_limits_interface /opt/ros/kinetic/share/joint_limits_interface
joint_state_controller /opt/ros/kinetic/share/joint_state_controller
joint_state_publisher /opt/ros/kinetic/share/joint_state_publisher
kdl_conversions /opt/ros/kinetic/share/kdl_conversions
kdl_parser /opt/ros/kinetic/share/kdl_parser
laser_assembler /opt/ros/kinetic/share/laser_assembler
laser_filters /opt/ros/kinetic/share/laser_filters
laser_geometry /opt/ros/kinetic/share/laser_geometry
librviz_tutorial /opt/ros/kinetic/share/librviz_tutorial
map_msgs /opt/ros/kinetic/share/map_msgs
media_export /opt/ros/kinetic/share/media_export
message_filters /opt/ros/kinetic/share/message_filters
message_generation /opt/ros/kinetic/share/message_generation
message_runtime /opt/ros/kinetic/share/message_runtime
mk /opt/ros/kinetic/share/mk
nav_msgs /opt/ros/kinetic/share/nav_msgs
nodelet /opt/ros/kinetic/share/nodelet
nodelet_topic_tools /opt/ros/kinetic/share/nodelet_topic_tools
nodelet_tutorial_math /opt/ros/kinetic/share/nodelet_tutorial_math
octomap /opt/ros/kinetic/share/octomap
opencv3 /opt/ros/kinetic/share/opencv3
orocos_kdl /opt/ros/kinetic/share/orocos_kdl
pcl_conversions /opt/ros/kinetic/share/pcl_conversions
pcl_msgs /opt/ros/kinetic/share/pcl_msgs
pcl_ros /opt/ros/kinetic/share/pcl_ros
pluginlib /opt/ros/kinetic/share/pluginlib
pluginlib_tutorials /opt/ros/kinetic/share/pluginlib_tutorials
pointgrey_camera_driver /opt/ros/kinetic/share/pointgrey_camera_driver
polled_camera /opt/ros/kinetic/share/polled_camera
position_controllers /opt/ros/kinetic/share/position_controllers
python_orocos_kdl /opt/ros/kinetic/share/python_orocos_kdl
python_qt_binding /opt/ros/kinetic/share/python_qt_binding
qt_dotgraph /opt/ros/kinetic/share/qt_dotgraph
qt_gui /opt/ros/kinetic/share/qt_gui
qt_gui_cpp /opt/ros/kinetic/share/qt_gui_cpp
qt_gui_py_common /opt/ros/kinetic/share/qt_gui_py_common
qwt_dependency /opt/ros/kinetic/share/qwt_dependency
random_numbers /opt/ros/kinetic/share/random_numbers
realtime_tools /opt/ros/kinetic/share/realtime_tools
resource_retriever /opt/ros/kinetic/share/resource_retriever
robot_state_publisher /opt/ros/kinetic/share/robot_state_publisher
rosbag /opt/ros/kinetic/share/rosbag
rosbag_migration_rule /opt/ros/kinetic/share/rosbag_migration_rule
rosbag_storage /opt/ros/kinetic/share/rosbag_storage
rosbash /opt/ros/kinetic/share/rosbash
rosboost_cfg /opt/ros/kinetic/share/rosboost_cfg
rosbuild /opt/ros/kinetic/share/rosbuild
rosclean /opt/ros/kinetic/share/rosclean
rosconsole /opt/ros/kinetic/share/rosconsole
rosconsole_bridge /opt/ros/kinetic/share/rosconsole_bridge
roscpp /opt/ros/kinetic/share/roscpp
roscpp_serialization /opt/ros/kinetic/share/roscpp_serialization
roscpp_traits /opt/ros/kinetic/share/roscpp_traits
roscpp_tutorials /opt/ros/kinetic/share/roscpp_tutorials
roscreate /opt/ros/kinetic/share/roscreate
rosgraph /opt/ros/kinetic/share/rosgraph
rosgraph_msgs /opt/ros/kinetic/share/rosgraph_msgs
roslang /opt/ros/kinetic/share/roslang
roslaunch /opt/ros/kinetic/share/roslaunch
roslib /opt/ros/kinetic/share/roslib
roslint /opt/ros/kinetic/share/roslint
roslisp /opt/ros/kinetic/share/roslisp
roslz4 /opt/ros/kinetic/share/roslz4
rosmake /opt/ros/kinetic/share/rosmake
rosmaster /opt/ros/kinetic/share/rosmaster
rosmsg /opt/ros/kinetic/share/rosmsg
rosnode /opt/ros/kinetic/share/rosnode
rosout /opt/ros/kinetic/share/rosout
rospack /opt/ros/kinetic/share/rospack
rosparam /opt/ros/kinetic/share/rosparam
rospy /opt/ros/kinetic/share/rospy
rospy_tutorials /opt/ros/kinetic/share/rospy_tutorials
rosservice /opt/ros/kinetic/share/rosservice
rostest /opt/ros/kinetic/share/rostest
rostime /opt/ros/kinetic/share/rostime
rostopic /opt/ros/kinetic/share/rostopic
rosunit /opt/ros/kinetic/share/rosunit
roswtf /opt/ros/kinetic/share/roswtf
rqt_action /opt/ros/kinetic/share/rqt_action
rqt_bag /opt/ros/kinetic/share/rqt_bag
rqt_bag_plugins /opt/ros/kinetic/share/rqt_bag_plugins
rqt_console /opt/ros/kinetic/share/rqt_console
rqt_dep /opt/ros/kinetic/share/rqt_dep
rqt_graph /opt/ros/kinetic/share/rqt_graph
rqt_gui /opt/ros/kinetic/share/rqt_gui
rqt_gui_cpp /opt/ros/kinetic/share/rqt_gui_cpp
rqt_gui_py /opt/ros/kinetic/share/rqt_gui_py
rqt_image_view /opt/ros/kinetic/share/rqt_image_view
rqt_launch /opt/ros/kinetic/share/rqt_launch
rqt_logger_level /opt/ros/kinetic/share/rqt_logger_level
rqt_moveit /opt/ros/kinetic/share/rqt_moveit
rqt_msg /opt/ros/kinetic/share/rqt_msg
rqt_nav_view /opt/ros/kinetic/share/rqt_nav_view
rqt_plot /opt/ros/kinetic/share/rqt_plot
rqt_pose_view /opt/ros/kinetic/share/rqt_pose_view
rqt_publisher /opt/ros/kinetic/share/rqt_publisher
rqt_py_common /opt/ros/kinetic/share/rqt_py_common
rqt_py_console /opt/ros/kinetic/share/rqt_py_console
rqt_reconfigure /opt/ros/kinetic/share/rqt_reconfigure
rqt_robot_dashboard /opt/ros/kinetic/share/rqt_robot_dashboard
rqt_robot_monitor /opt/ros/kinetic/share/rqt_robot_monitor
rqt_robot_steering /opt/ros/kinetic/share/rqt_robot_steering
rqt_runtime_monitor /opt/ros/kinetic/share/rqt_runtime_monitor
rqt_rviz /opt/ros/kinetic/share/rqt_rviz
rqt_service_caller /opt/ros/kinetic/share/rqt_service_caller
rqt_shell /opt/ros/kinetic/share/rqt_shell
rqt_srv /opt/ros/kinetic/share/rqt_srv
rqt_tf_tree /opt/ros/kinetic/share/rqt_tf_tree
rqt_top /opt/ros/kinetic/share/rqt_top
rqt_topic /opt/ros/kinetic/share/rqt_topic
rqt_web /opt/ros/kinetic/share/rqt_web
rviz /opt/ros/kinetic/share/rviz
rviz_plugin_tutorials /opt/ros/kinetic/share/rviz_plugin_tutorials
rviz_python_tutorial /opt/ros/kinetic/share/rviz_python_tutorial
self_test /opt/ros/kinetic/share/self_test
sensor_msgs /opt/ros/kinetic/share/sensor_msgs
shape_msgs /opt/ros/kinetic/share/shape_msgs
smach /opt/ros/kinetic/share/smach
smach_msgs /opt/ros/kinetic/share/smach_msgs
smach_ros /opt/ros/kinetic/share/smach_ros
smclib /opt/ros/kinetic/share/smclib
stage /opt/ros/kinetic/share/stage
stage_ros /opt/ros/kinetic/share/stage_ros
statistics_msgs /opt/ros/kinetic/share/statistics_msgs
std_msgs /opt/ros/kinetic/share/std_msgs
std_srvs /opt/ros/kinetic/share/std_srvs
stereo_image_proc /opt/ros/kinetic/share/stereo_image_proc
stereo_msgs /opt/ros/kinetic/share/stereo_msgs
tf /opt/ros/kinetic/share/tf
tf2 /opt/ros/kinetic/share/tf2
tf2_eigen /opt/ros/kinetic/share/tf2_eigen
tf2_geometry_msgs /opt/ros/kinetic/share/tf2_geometry_msgs
tf2_kdl /opt/ros/kinetic/share/tf2_kdl
tf2_msgs /opt/ros/kinetic/share/tf2_msgs
tf2_py /opt/ros/kinetic/share/tf2_py
tf2_ros /opt/ros/kinetic/share/tf2_ros
tf_conversions /opt/ros/kinetic/share/tf_conversions
theora_image_transport /opt/ros/kinetic/share/theora_image_transport
topic_tools /opt/ros/kinetic/share/topic_tools
trajectory_msgs /opt/ros/kinetic/share/trajectory_msgs
transmission_interface /opt/ros/kinetic/share/transmission_interface
turtle_actionlib /opt/ros/kinetic/share/turtle_actionlib
turtle_tf /opt/ros/kinetic/share/turtle_tf
turtle_tf2 /opt/ros/kinetic/share/turtle_tf2
turtlesim /opt/ros/kinetic/share/turtlesim
urdf /opt/ros/kinetic/share/urdf
urdf_parser_plugin /opt/ros/kinetic/share/urdf_parser_plugin
urdf_tutorial /opt/ros/kinetic/share/urdf_tutorial
visualization_marker_tutorials /opt/ros/kinetic/share/visualization_marker_tutorials
visualization_msgs /opt/ros/kinetic/share/visualization_msgs
webkit_dependency /opt/ros/kinetic/share/webkit_dependency
wfov_camera_msgs /opt/ros/kinetic/share/wfov_camera_msgs
xacro /opt/ros/kinetic/share/xacro
xmlrpcpp /opt/ros/kinetic/share/xmlrpcpp
```
- `apt-cache rdepends ros-kinetic-opencv3`:
```
$ apt-cache rdepends ros-kinetic-opencv3
ros-kinetic-opencv3
Reverse Depends:
  ros-kinetic-cv-bridge
  ros-kinetic-xiaoqiang-depth-image-proc
  ros-kinetic-web-video-server
  ros-kinetic-visp
  ros-kinetic-video-stream-opencv
  ros-kinetic-tuw-aruco
  ros-kinetic-turtlebot3-panorama
  ros-kinetic-turtlebot-actions
  ros-kinetic-theora-image-transport
  ros-kinetic-swri-transform-util
  ros-kinetic-swri-opencv-util
  ros-kinetic-swri-image-util
  ros-kinetic-stereo-image-proc
  ros-kinetic-spinnaker-camera-driver
  ros-kinetic-sick-visionary-t-driver
  ros-kinetic-rtabmap-ros
  ros-kinetic-rtabmap
  ros-kinetic-rqt-image-view
  ros-kinetic-rospilot
  ros-kinetic-robot-calibration
  ros-kinetic-resized-image-transport
  ros-kinetic-realsense-camera
  ros-kinetic-posedetection-msgs
  ros-kinetic-pcdfilter-pa
  ros-kinetic-opt-camera
  ros-kinetic-opencv-candidate
  ros-kinetic-opencv-apps
  ros-kinetic-op3-ball-detector
  ros-kinetic-object-recognition-transparent-objects
  ros-kinetic-object-recognition-tod
  ros-kinetic-object-recognition-reconstruction
  ros-kinetic-object-recognition-core
  ros-kinetic-object-recognition-capture
  ros-kinetic-nerian-stereo
  ros-kinetic-nerian-sp1
  ros-kinetic-naoqi-driver
  ros-kinetic-multisense-ros
  ros-kinetic-multirobot-map-merge
  ros-kinetic-mrpt-bridge
  ros-kinetic-moveit-ros-perception
  ros-kinetic-mapviz-plugins
  ros-kinetic-mapviz
  ros-kinetic-laser-cb-detector
  ros-kinetic-jsk-rviz-plugins
  ros-kinetic-jsk-recognition-utils
  ros-kinetic-jsk-perception
  ros-kinetic-jsk-pcl-ros-utils
  ros-kinetic-jsk-pcl-ros
  ros-kinetic-jsk-interactive-marker
  ros-kinetic-jsk-footstep-planner
  ros-kinetic-jsk-footstep-controller
  ros-kinetic-ipcamera-driver
  ros-kinetic-imagezero-ros
  ros-kinetic-imagesift
  ros-kinetic-image-view2
  ros-kinetic-image-view
  ros-kinetic-image-stream
  ros-kinetic-image-rotate
  ros-kinetic-image-publisher
  ros-kinetic-image-proc
  ros-kinetic-image-geometry
  ros-kinetic-image-cb-detector
  ros-kinetic-homer-robot-face
  ros-kinetic-hector-object-tracker
  ros-kinetic-hector-compressed-map-transport
  ros-kinetic-grid-map-ros
  ros-kinetic-grid-map-demos
  ros-kinetic-grid-map-cv
  ros-kinetic-gazebo-plugins
  ros-kinetic-find-object-2d
  ros-kinetic-fiducial-slam
  ros-kinetic-face-detector
  ros-kinetic-ecto-ros
  ros-kinetic-ecto-openni
  ros-kinetic-ecto-opencv
  ros-kinetic-ecto-image-pipeline
  ros-kinetic-dnn-detect
  ros-kinetic-depthimage-to-laserscan
  ros-kinetic-depth-image-proc
  ros-kinetic-cv-camera
  ros-kinetic-ar-track-alvar
  ros-kinetic-costmap-converter
  ros-kinetic-cost-map-ros
  ros-kinetic-compressed-image-transport
  ros-kinetic-compressed-depth-image-transport
  ros-kinetic-cob-object-detection-visualizer
  ros-kinetic-cob-map-accessibility-analysis
  ros-kinetic-cob-image-flip
  ros-kinetic-checkerboard-detector
  ros-kinetic-aruco-ros
  ros-kinetic-aruco-detect
ros-kinetic-aruco
```
- `sudo apt-get remove ros-kinetic-opencv3 `
```
$ sudo apt-get remove ros-kinetic-opencv3 
[sudo] Mot de passe de : 
Lecture des listes de paquets... Fait
Construction de l'arbre des dépendances       
Lecture des informations d'état... Fait
Les paquets suivants ont été installés automatiquement et ne sont plus nécessaires :
  docutils-common docutils-doc fltk1.3-doc fluid fonts-lato freeglut3 freeglut3-dev gazebo7 gazebo7-common gazebo7-plugin-base google-mock hddtemp hdf5-helpers icu-devtools libaec-dev libaec0 libapr1 libapr1-dev libaprutil1
  libaprutil1-dev libarmadillo6 libarpack2 libassimp-dev libassimp3v5 libblas-dev libboost-all-dev libboost-atomic-dev libboost-atomic1.58-dev libboost-atomic1.58.0 libboost-chrono-dev libboost-chrono1.58-dev
  libboost-chrono1.58.0 libboost-context-dev libboost-context1.58-dev libboost-context1.58.0 libboost-coroutine-dev libboost-coroutine1.58-dev libboost-coroutine1.58.0 libboost-date-time-dev libboost-date-time1.58-dev
  libboost-dev libboost-exception-dev libboost-exception1.58-dev libboost-filesystem-dev libboost-filesystem1.58-dev libboost-graph-dev libboost-graph-parallel-dev libboost-graph-parallel1.58-dev libboost-graph-parallel1.58.0
  libboost-graph1.58-dev libboost-graph1.58.0 libboost-iostreams-dev libboost-iostreams1.58-dev libboost-locale-dev libboost-locale1.58-dev libboost-locale1.58.0 libboost-log-dev libboost-log1.58-dev libboost-log1.58.0
  libboost-math-dev libboost-math1.58-dev libboost-math1.58.0 libboost-mpi-dev libboost-mpi-python-dev libboost-mpi-python1.58-dev libboost-mpi-python1.58.0 libboost-mpi1.58-dev libboost-mpi1.58.0 libboost-program-options-dev
  libboost-program-options1.58-dev libboost-program-options1.58.0 libboost-python-dev libboost-python1.58-dev libboost-python1.58.0 libboost-random-dev libboost-random1.58-dev libboost-random1.58.0 libboost-regex-dev
  libboost-regex1.58-dev libboost-regex1.58.0 libboost-serialization-dev libboost-serialization1.58-dev libboost-serialization1.58.0 libboost-signals-dev libboost-signals1.58-dev libboost-signals1.58.0 libboost-system-dev
  libboost-system1.58-dev libboost-test-dev libboost-test1.58-dev libboost-test1.58.0 libboost-thread-dev libboost-thread1.58-dev libboost-thread1.58.0 libboost-timer-dev libboost-timer1.58-dev libboost-timer1.58.0
  libboost-tools-dev libboost-wave-dev libboost-wave1.58-dev libboost-wave1.58.0 libboost1.58-dev libboost1.58-tools-dev libbulletcollision2.83.6 libbulletdynamics2.83.6 libbz2-dev libcollada-dom2.4-dp-dev libcollada-dom2.4-dp0
  libconsole-bridge-dev libconsole-bridge0.2v5 libcurl4-openssl-dev libdap-dev libdap17v5 libdapclient6v5 libdapserver7v5 libeigen3-dev libepsilon1 libflann-dev libflann1.8 libfltk-cairo1.3 libfltk-forms1.3 libfltk-gl1.3
  libfltk-images1.3 libfltk1.3 libfltk1.3-dev libfreeimage-dev libfreeimage3 libfreexl1 libgazebo7 libgazebo7-dev libgdal-dev libgdal1i libgeos-3.5.0 libgeos-c1v5 libgeos-dev libgif-dev libgif7 libgl2ps-dev libgl2ps0
  libgles2-mesa-dev libgtest-dev libgts-0.7-5 libgts-bin libgts-dev libhdf4-0-alt libhdf4-alt-dev libhdf5-10 libhdf5-cpp-11 libhdf5-dev libhdf5-mpi-dev libhdf5-openmpi-10 libhdf5-openmpi-dev libhwloc-dev libhwloc-plugins
  libhwloc5 libibverbs-dev libibverbs1 libicu-dev libignition-math2 libignition-math2-dev libinput-dev libjasper-dev libjbig-dev libjpeg-dev libjpeg-turbo8-dev libjpeg8-dev libjs-sphinxdoc libjs-underscore libjsoncpp-dev libjxr0
  libkmlbase1 libkmldom1 libkmlengine1 liblapack-dev libldap2-dev liblinearmath2.83.6 liblog4cxx-dev liblog4cxx10-dev liblog4cxx10v5 liblz4-dev liblzma-dev libminizip1 libnetcdf-c++4 libnetcdf-cxx-legacy-dev libnetcdf-dev
  libnetcdf11 libnuma-dev libogdi3.2 libogg-dev libogre-1.9-dev libogre-1.9.0v5 libopenmpi-dev libopenmpi1.10 libopenni-dev libopenni-sensor-pointclouds0 libopenni0 libpcl-apps1.7 libpcl-common1.7 libpcl-dev libpcl-features1.7
  libpcl-filters1.7 libpcl-io1.7 libpcl-kdtree1.7 libpcl-keypoints1.7 libpcl-octree1.7 libpcl-outofcore1.7 libpcl-people1.7 libpcl-recognition1.7 libpcl-registration1.7 libpcl-sample-consensus1.7 libpcl-search1.7
  libpcl-segmentation1.7 libpcl-surface1.7 libpcl-tracking1.7 libpcl-visualization1.7 libpcl1.7 libpoco-dev libpococrypto9v5 libpocodata9v5 libpocofoundation9v5 libpocomysql9v5 libpoconet9v5 libpoconetssl9v5 libpocoodbc9v5
  libpocosqlite9v5 libpocoutil9v5 libpocoxml9v5 libpocozip9v5 libproj9 libprotoc-dev libprotoc9v5 libpyside-py3-2.0 libpyside2-dev libpyside2.0 libqgsttools-p1 libqhull-dev libqhull7 libqt5clucene5 libqt5concurrent5
  libqt5designer5 libqt5designercomponents5 libqt5help5 libqt5multimediaquick-p5 libqt5multimediawidgets5 libqt5opengl5-dev libqt5quickparticles5 libqt5quickwidgets5 libqt5script5 libqt5scripttools5 libqt5svg5-dev
  libqt5webkit5-dev libqt5x11extras5 libqt5x11extras5-dev libqt5xmlpatterns5 libqt5xmlpatterns5-dev libqt5xmlpatterns5-private-dev libqtwebkit-dev libqtwebkit4 libruby2.3 libsctp-dev libsctp1 libsdformat4 libsdformat4-dev
  libshiboken-py3-2.0 libshiboken2-dev libshiboken2.0 libsimbody-dev libsimbody3.5v5 libspatialite-dev libspatialite7 libspnav0 libsuperlu4 libsz2 libtar-dev libtar0 libtbb-dev libtbb2 libtheora-dev libtiff5-dev libtiffxx5
  libtinyxml-dev libtinyxml2-2v5 libtinyxml2-dev libtinyxml2.6.2v5 libudev-dev liburdfdom-dev liburdfdom-headers-dev liburdfdom-model-state0.4 liburdfdom-model0.4 liburdfdom-sensor0.4 liburdfdom-tools liburdfdom-world0.4
  liburiparser1 libvtk6-dev libvtk6-java libvtk6-qt-dev libvtk6.2 libvtk6.2-qt libwebp-dev libxerces-c-dev libxerces-c3.1 libxml2-dev libxmu-dev libxmu-headers libxss-dev libxt-dev libyaml-cpp-dev libyaml-cpp0.5v5 libzzip-0-13
  mpi-default-bin mpi-default-dev openmpi-bin openmpi-common openni-utils proj-bin proj-data pyqt5-dev python-attr python-autobahn python-catkin-pkg python-catkin-pkg-modules python-cffi-backend python-chardet
  python-concurrent.futures python-crypto python-cryptography python-defusedxml python-docutils python-ecdsa python-empy python-enum34 python-idna python-ipaddress python-lz4 python-mpi4py python-msgpack python-netifaces
  python-opengl python-openssl python-pam python-paramiko python-psutil python-pyasn1 python-pyasn1-modules python-pydot python-pygments python-pyqt5 python-pyqt5.qtopengl python-pyqt5.qtsvg python-pyqt5.qtwebkit python-pyside2
  python-pyside2.qtconcurrent python-pyside2.qtcore python-pyside2.qtgui python-pyside2.qthelp python-pyside2.qtnetwork python-pyside2.qtprintsupport python-pyside2.qtqml python-pyside2.qtquick python-pyside2.qtquickwidgets
  python-pyside2.qtscript python-pyside2.qtsql python-pyside2.qtsvg python-pyside2.qttest python-pyside2.qtuitools python-pyside2.qtwebkit python-pyside2.qtwebkitwidgets python-pyside2.qtwidgets python-pyside2.qtx11extras
  python-pyside2.qtxml python-roman python-rosdep python-rosdistro python-rosdistro-modules python-rospkg python-rospkg-modules python-serial python-service-identity python-sip-dev python-snappy python-trollius python-twisted
  python-twisted-bin python-twisted-core python-txaio python-vtk6 python-wxtools python-yaml python-zope.interface qt5-qmake qtbase5-dev qtbase5-dev-tools qtbase5-private-dev qtdeclarative5-dev qtdeclarative5-private-dev
  qtmultimedia5-dev qtscript5-dev qtscript5-private-dev qttools5-dev qttools5-dev-tools qttools5-private-dev rake ros-kinetic-actionlib ros-kinetic-actionlib-msgs ros-kinetic-actionlib-tutorials ros-kinetic-angles
  ros-kinetic-bond ros-kinetic-bond-core ros-kinetic-bondcpp ros-kinetic-bondpy ros-kinetic-camera-calibration-parsers ros-kinetic-camera-info-manager ros-kinetic-catkin ros-kinetic-class-loader ros-kinetic-cmake-modules
  ros-kinetic-collada-parser ros-kinetic-collada-urdf ros-kinetic-common-msgs ros-kinetic-common-tutorials ros-kinetic-control-msgs ros-kinetic-cpp-common ros-kinetic-diagnostic-aggregator ros-kinetic-diagnostic-analysis
  ros-kinetic-diagnostic-common-diagnostics ros-kinetic-diagnostic-msgs ros-kinetic-diagnostic-updater ros-kinetic-diagnostics ros-kinetic-dynamic-reconfigure ros-kinetic-eigen-conversions ros-kinetic-eigen-stl-containers
  ros-kinetic-executive-smach ros-kinetic-filters ros-kinetic-gazebo-dev ros-kinetic-gazebo-msgs ros-kinetic-gazebo-ros ros-kinetic-gencpp ros-kinetic-geneus ros-kinetic-genlisp ros-kinetic-genmsg ros-kinetic-gennodejs
  ros-kinetic-genpy ros-kinetic-geometric-shapes ros-kinetic-geometry ros-kinetic-geometry-msgs ros-kinetic-geometry-tutorials ros-kinetic-gl-dependency ros-kinetic-image-common ros-kinetic-image-transport
  ros-kinetic-interactive-marker-tutorials ros-kinetic-interactive-markers ros-kinetic-joint-state-publisher ros-kinetic-kdl-conversions ros-kinetic-kdl-parser ros-kinetic-laser-assembler ros-kinetic-laser-filters
  ros-kinetic-laser-geometry ros-kinetic-laser-pipeline ros-kinetic-librviz-tutorial ros-kinetic-map-msgs ros-kinetic-media-export ros-kinetic-message-filters ros-kinetic-message-generation ros-kinetic-message-runtime
  ros-kinetic-mk ros-kinetic-nav-msgs ros-kinetic-nodelet ros-kinetic-nodelet-core ros-kinetic-nodelet-topic-tools ros-kinetic-nodelet-tutorial-math ros-kinetic-octomap ros-kinetic-orocos-kdl ros-kinetic-pcl-conversions
  ros-kinetic-pcl-msgs ros-kinetic-pcl-ros ros-kinetic-perception-pcl ros-kinetic-pluginlib ros-kinetic-pluginlib-tutorials ros-kinetic-polled-camera ros-kinetic-python-orocos-kdl ros-kinetic-python-qt-binding
  ros-kinetic-qt-dotgraph ros-kinetic-qt-gui ros-kinetic-qt-gui-cpp ros-kinetic-qt-gui-py-common ros-kinetic-qwt-dependency ros-kinetic-random-numbers ros-kinetic-resource-retriever ros-kinetic-robot ros-kinetic-robot-model
  ros-kinetic-robot-state-publisher ros-kinetic-ros ros-kinetic-ros-base ros-kinetic-ros-comm ros-kinetic-ros-core ros-kinetic-ros-environment ros-kinetic-ros-tutorials ros-kinetic-rosbag ros-kinetic-rosbag-migration-rule
  ros-kinetic-rosbag-storage ros-kinetic-rosbash ros-kinetic-rosboost-cfg ros-kinetic-rosbuild ros-kinetic-rosclean ros-kinetic-rosconsole ros-kinetic-rosconsole-bridge ros-kinetic-roscpp ros-kinetic-roscpp-core
  ros-kinetic-roscpp-serialization ros-kinetic-roscpp-traits ros-kinetic-roscpp-tutorials ros-kinetic-roscreate ros-kinetic-rosgraph ros-kinetic-rosgraph-msgs ros-kinetic-roslang ros-kinetic-roslaunch ros-kinetic-roslib
  ros-kinetic-roslint ros-kinetic-roslisp ros-kinetic-roslz4 ros-kinetic-rosmake ros-kinetic-rosmaster ros-kinetic-rosmsg ros-kinetic-rosnode ros-kinetic-rosout ros-kinetic-rospack ros-kinetic-rosparam ros-kinetic-rospy
  ros-kinetic-rospy-tutorials ros-kinetic-rosservice ros-kinetic-rostest ros-kinetic-rostime ros-kinetic-rostopic ros-kinetic-rosunit ros-kinetic-roswtf ros-kinetic-rqt-action ros-kinetic-rqt-bag ros-kinetic-rqt-bag-plugins
  ros-kinetic-rqt-console ros-kinetic-rqt-dep ros-kinetic-rqt-graph ros-kinetic-rqt-gui ros-kinetic-rqt-gui-cpp ros-kinetic-rqt-gui-py ros-kinetic-rqt-launch ros-kinetic-rqt-logger-level ros-kinetic-rqt-moveit ros-kinetic-rqt-msg
  ros-kinetic-rqt-nav-view ros-kinetic-rqt-plot ros-kinetic-rqt-pose-view ros-kinetic-rqt-publisher ros-kinetic-rqt-py-common ros-kinetic-rqt-py-console ros-kinetic-rqt-reconfigure ros-kinetic-rqt-robot-dashboard
  ros-kinetic-rqt-robot-monitor ros-kinetic-rqt-robot-plugins ros-kinetic-rqt-robot-steering ros-kinetic-rqt-runtime-monitor ros-kinetic-rqt-rviz ros-kinetic-rqt-service-caller ros-kinetic-rqt-shell ros-kinetic-rqt-srv
  ros-kinetic-rqt-tf-tree ros-kinetic-rqt-top ros-kinetic-rqt-topic ros-kinetic-rqt-web ros-kinetic-rviz ros-kinetic-rviz-plugin-tutorials ros-kinetic-rviz-python-tutorial ros-kinetic-self-test ros-kinetic-sensor-msgs
  ros-kinetic-shape-msgs ros-kinetic-smach ros-kinetic-smach-msgs ros-kinetic-smach-ros ros-kinetic-smclib ros-kinetic-stage ros-kinetic-stage-ros ros-kinetic-std-msgs ros-kinetic-std-srvs ros-kinetic-stereo-msgs ros-kinetic-tf
  ros-kinetic-tf-conversions ros-kinetic-tf2 ros-kinetic-tf2-eigen ros-kinetic-tf2-geometry-msgs ros-kinetic-tf2-kdl ros-kinetic-tf2-msgs ros-kinetic-tf2-py ros-kinetic-tf2-ros ros-kinetic-topic-tools ros-kinetic-trajectory-msgs
  ros-kinetic-turtle-actionlib ros-kinetic-turtle-tf ros-kinetic-turtle-tf2 ros-kinetic-turtlesim ros-kinetic-urdf ros-kinetic-urdf-parser-plugin ros-kinetic-urdf-tutorial ros-kinetic-visualization-marker-tutorials
  ros-kinetic-visualization-msgs ros-kinetic-visualization-tutorials ros-kinetic-webkit-dependency ros-kinetic-xacro ros-kinetic-xmlrpcpp ruby ruby-did-you-mean ruby-minitest ruby-net-telnet ruby-power-assert ruby-test-unit
  ruby2.3 rubygems-integration sbcl sdformat-sdf shiboken2 sip-dev snap-confine tango-icon-theme tcl-dev tcl-vtk6 tcl8.6-dev tk-dev tk8.6-dev ttf-dejavu-core ttf-liberation uuid-dev vtk6 x11proto-scrnsaver-dev
Veuillez utiliser « sudo apt autoremove » pour les supprimer.
Les paquets suivants seront ENLEVÉS :
  ros-kinetic-camera-calibration ros-kinetic-compressed-depth-image-transport ros-kinetic-compressed-image-transport ros-kinetic-cv-bridge ros-kinetic-depth-image-proc ros-kinetic-desktop ros-kinetic-desktop-full
  ros-kinetic-gazebo-plugins ros-kinetic-gazebo-ros-pkgs ros-kinetic-image-geometry ros-kinetic-image-pipeline ros-kinetic-image-proc ros-kinetic-image-publisher ros-kinetic-image-rotate ros-kinetic-image-transport-plugins
  ros-kinetic-image-view ros-kinetic-opencv3 ros-kinetic-perception ros-kinetic-rqt-common-plugins ros-kinetic-rqt-image-view ros-kinetic-simulators ros-kinetic-stereo-image-proc ros-kinetic-theora-image-transport
  ros-kinetic-vision-opencv ros-kinetic-viz
0 mis à jour, 0 nouvellement installés, 25 à enlever et 0 non mis à jour.
Après cette opération, 148 Mo d'espace disque seront libérés.
Souhaitez-vous continuer ? [O/n] o
(Lecture de la base de données... 317380 fichiers et répertoires déjà installés.)
Suppression de ros-kinetic-desktop-full (1.3.2-0xenial-20180810-032811-0800) ...
Suppression de ros-kinetic-perception (1.3.2-0xenial-20180809-230528-0800) ...
Suppression de ros-kinetic-image-pipeline (1.12.23-0xenial-20180809-212745-0800) ...
Suppression de ros-kinetic-camera-calibration (1.12.23-0xenial-20180809-200914-0800) ...
Suppression de ros-kinetic-image-transport-plugins (1.9.5-0xenial-20180809-182002-0800) ...
Suppression de ros-kinetic-compressed-depth-image-transport (1.9.5-0xenial-20180809-161724-0800) ...
Suppression de ros-kinetic-compressed-image-transport (1.9.5-0xenial-20180809-161709-0800) ...
Suppression de ros-kinetic-image-view (1.12.23-0xenial-20180809-201126-0800) ...
Suppression de ros-kinetic-vision-opencv (1.12.8-0xenial-20180809-201058-0800) ...
Suppression de ros-kinetic-depth-image-proc (1.12.23-0xenial-20180809-193515-0800) ...
Suppression de ros-kinetic-desktop (1.3.2-0xenial-20180810-032708-0800) ...
Suppression de ros-kinetic-simulators (1.3.2-0xenial-20180810-032425-0800) ...
Suppression de ros-kinetic-gazebo-ros-pkgs (2.5.17-0xenial-20180810-032308-0800) ...
Suppression de ros-kinetic-gazebo-plugins (2.5.17-0xenial-20180809-190449-0800) ...
Suppression de ros-kinetic-stereo-image-proc (1.12.23-0xenial-20180809-211050-0800) ...
Suppression de ros-kinetic-image-proc (1.12.23-0xenial-20180809-201011-0800) ...
Suppression de ros-kinetic-image-publisher (1.12.23-0xenial-20180809-162530-0800) ...
Suppression de ros-kinetic-image-rotate (1.12.23-0xenial-20180809-162803-0800) ...
Suppression de ros-kinetic-theora-image-transport (1.9.5-0xenial-20180809-163202-0800) ...
Suppression de ros-kinetic-viz (1.3.2-0xenial-20180810-032444-0800) ...
Suppression de ros-kinetic-rqt-common-plugins (0.4.8-0xenial-20180809-185816-0800) ...
Suppression de ros-kinetic-rqt-image-view (0.4.13-0xenial-20180809-163145-0800) ...
Suppression de ros-kinetic-cv-bridge (1.12.8-0xenial-20180809-155803-0800) ...
Suppression de ros-kinetic-image-geometry (1.12.8-0xenial-20180809-185452-0800) ...
Suppression de ros-kinetic-opencv3 (3.3.1-5xenial-20180809-134307-0800) ...
Traitement des actions différées (« triggers ») pour libc-bin (2.23-0ubuntu10) ...
```
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
- `rospack list`
```
$ rospack list
actionlib /opt/ros/kinetic/share/actionlib
actionlib_msgs /opt/ros/kinetic/share/actionlib_msgs
actionlib_tutorials /opt/ros/kinetic/share/actionlib_tutorials
angles /opt/ros/kinetic/share/angles
apriltag_visp /home/lagadic/catkin_ws/src/apriltag_visp
bond /opt/ros/kinetic/share/bond
bondcpp /opt/ros/kinetic/share/bondcpp
bondpy /opt/ros/kinetic/share/bondpy
camera_calibration /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_pipeline/camera_calibration
camera_calibration_parsers /opt/ros/kinetic/share/camera_calibration_parsers
camera_info_manager /opt/ros/kinetic/share/camera_info_manager
catkin /opt/ros/kinetic/share/catkin
class_loader /opt/ros/kinetic/share/class_loader
cmake_modules /opt/ros/kinetic/share/cmake_modules
collada_parser /opt/ros/kinetic/share/collada_parser
collada_urdf /opt/ros/kinetic/share/collada_urdf
compressed_depth_image_transport /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_transport_plugins/compressed_depth_image_transport
compressed_image_transport /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_transport_plugins/compressed_image_transport
control_msgs /opt/ros/kinetic/share/control_msgs
cpp_common /opt/ros/kinetic/share/cpp_common
cv_bridge /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/vision_opencv/cv_bridge
depth_image_proc /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_pipeline/depth_image_proc
diagnostic_aggregator /opt/ros/kinetic/share/diagnostic_aggregator
diagnostic_analysis /opt/ros/kinetic/share/diagnostic_analysis
diagnostic_common_diagnostics /opt/ros/kinetic/share/diagnostic_common_diagnostics
diagnostic_msgs /opt/ros/kinetic/share/diagnostic_msgs
diagnostic_updater /opt/ros/kinetic/share/diagnostic_updater
dynamic_reconfigure /opt/ros/kinetic/share/dynamic_reconfigure
eigen_conversions /opt/ros/kinetic/share/eigen_conversions
eigen_stl_containers /opt/ros/kinetic/share/eigen_stl_containers
filters /opt/ros/kinetic/share/filters
gazebo_dev /opt/ros/kinetic/share/gazebo_dev
gazebo_msgs /opt/ros/kinetic/share/gazebo_msgs
gazebo_ros /opt/ros/kinetic/share/gazebo_ros
gencpp /opt/ros/kinetic/share/gencpp
geneus /opt/ros/kinetic/share/geneus
genlisp /opt/ros/kinetic/share/genlisp
genmsg /opt/ros/kinetic/share/genmsg
gennodejs /opt/ros/kinetic/share/gennodejs
genpy /opt/ros/kinetic/share/genpy
geometric_shapes /opt/ros/kinetic/share/geometric_shapes
geometry_msgs /opt/ros/kinetic/share/geometry_msgs
gl_dependency /opt/ros/kinetic/share/gl_dependency
grabber_test /home/lagadic/catkin_ws/src/grabber_test
image_geometry /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/vision_opencv/image_geometry
image_proc /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_pipeline/image_proc
image_publisher /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_pipeline/image_publisher
image_rotate /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_pipeline/image_rotate
image_transport /opt/ros/kinetic/share/image_transport
image_view /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_pipeline/image_view
interactive_marker_tutorials /opt/ros/kinetic/share/interactive_marker_tutorials
interactive_markers /opt/ros/kinetic/share/interactive_markers
joint_state_publisher /opt/ros/kinetic/share/joint_state_publisher
kdl_conversions /opt/ros/kinetic/share/kdl_conversions
kdl_parser /opt/ros/kinetic/share/kdl_parser
laser_assembler /opt/ros/kinetic/share/laser_assembler
laser_filters /opt/ros/kinetic/share/laser_filters
laser_geometry /opt/ros/kinetic/share/laser_geometry
librviz_tutorial /opt/ros/kinetic/share/librviz_tutorial
map_msgs /opt/ros/kinetic/share/map_msgs
media_export /opt/ros/kinetic/share/media_export
message_filters /opt/ros/kinetic/share/message_filters
message_generation /opt/ros/kinetic/share/message_generation
message_runtime /opt/ros/kinetic/share/message_runtime
mk /opt/ros/kinetic/share/mk
nav_msgs /opt/ros/kinetic/share/nav_msgs
nodelet /opt/ros/kinetic/share/nodelet
nodelet_topic_tools /opt/ros/kinetic/share/nodelet_topic_tools
nodelet_tutorial_math /opt/ros/kinetic/share/nodelet_tutorial_math
octomap /opt/ros/kinetic/share/octomap
opencv_tests /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/vision_opencv/opencv_tests
orocos_kdl /opt/ros/kinetic/share/orocos_kdl
pcl_conversions /opt/ros/kinetic/share/pcl_conversions
pcl_msgs /opt/ros/kinetic/share/pcl_msgs
pcl_ros /opt/ros/kinetic/share/pcl_ros
pluginlib /opt/ros/kinetic/share/pluginlib
pluginlib_tutorials /opt/ros/kinetic/share/pluginlib_tutorials
polled_camera /opt/ros/kinetic/share/polled_camera
python_orocos_kdl /opt/ros/kinetic/share/python_orocos_kdl
python_qt_binding /opt/ros/kinetic/share/python_qt_binding
qt_dotgraph /opt/ros/kinetic/share/qt_dotgraph
qt_gui /opt/ros/kinetic/share/qt_gui
qt_gui_cpp /opt/ros/kinetic/share/qt_gui_cpp
qt_gui_py_common /opt/ros/kinetic/share/qt_gui_py_common
qwt_dependency /opt/ros/kinetic/share/qwt_dependency
random_numbers /opt/ros/kinetic/share/random_numbers
resource_retriever /opt/ros/kinetic/share/resource_retriever
robot_state_publisher /opt/ros/kinetic/share/robot_state_publisher
ros_environment /opt/ros/kinetic/share/ros_environment
rosbag /opt/ros/kinetic/share/rosbag
rosbag_migration_rule /opt/ros/kinetic/share/rosbag_migration_rule
rosbag_storage /opt/ros/kinetic/share/rosbag_storage
rosbash /opt/ros/kinetic/share/rosbash
rosboost_cfg /opt/ros/kinetic/share/rosboost_cfg
rosbuild /opt/ros/kinetic/share/rosbuild
rosclean /opt/ros/kinetic/share/rosclean
rosconsole /opt/ros/kinetic/share/rosconsole
rosconsole_bridge /opt/ros/kinetic/share/rosconsole_bridge
roscpp /opt/ros/kinetic/share/roscpp
roscpp_serialization /opt/ros/kinetic/share/roscpp_serialization
roscpp_traits /opt/ros/kinetic/share/roscpp_traits
roscpp_tutorials /opt/ros/kinetic/share/roscpp_tutorials
roscreate /opt/ros/kinetic/share/roscreate
rosgraph /opt/ros/kinetic/share/rosgraph
rosgraph_msgs /opt/ros/kinetic/share/rosgraph_msgs
roslang /opt/ros/kinetic/share/roslang
roslaunch /opt/ros/kinetic/share/roslaunch
roslib /opt/ros/kinetic/share/roslib
roslint /opt/ros/kinetic/share/roslint
roslisp /opt/ros/kinetic/share/roslisp
roslz4 /opt/ros/kinetic/share/roslz4
rosmake /opt/ros/kinetic/share/rosmake
rosmaster /opt/ros/kinetic/share/rosmaster
rosmsg /opt/ros/kinetic/share/rosmsg
rosnode /opt/ros/kinetic/share/rosnode
rosout /opt/ros/kinetic/share/rosout
rospack /opt/ros/kinetic/share/rospack
rosparam /opt/ros/kinetic/share/rosparam
rospy /opt/ros/kinetic/share/rospy
rospy_tutorials /opt/ros/kinetic/share/rospy_tutorials
rosservice /opt/ros/kinetic/share/rosservice
rostest /opt/ros/kinetic/share/rostest
rostime /opt/ros/kinetic/share/rostime
rostopic /opt/ros/kinetic/share/rostopic
rosunit /opt/ros/kinetic/share/rosunit
roswtf /opt/ros/kinetic/share/roswtf
rqt_action /opt/ros/kinetic/share/rqt_action
rqt_bag /opt/ros/kinetic/share/rqt_bag
rqt_bag_plugins /opt/ros/kinetic/share/rqt_bag_plugins
rqt_console /opt/ros/kinetic/share/rqt_console
rqt_dep /opt/ros/kinetic/share/rqt_dep
rqt_graph /opt/ros/kinetic/share/rqt_graph
rqt_gui /opt/ros/kinetic/share/rqt_gui
rqt_gui_cpp /opt/ros/kinetic/share/rqt_gui_cpp
rqt_gui_py /opt/ros/kinetic/share/rqt_gui_py
rqt_image_view /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/rqt_image_view
rqt_launch /opt/ros/kinetic/share/rqt_launch
rqt_logger_level /opt/ros/kinetic/share/rqt_logger_level
rqt_moveit /opt/ros/kinetic/share/rqt_moveit
rqt_msg /opt/ros/kinetic/share/rqt_msg
rqt_nav_view /opt/ros/kinetic/share/rqt_nav_view
rqt_plot /opt/ros/kinetic/share/rqt_plot
rqt_pose_view /opt/ros/kinetic/share/rqt_pose_view
rqt_publisher /opt/ros/kinetic/share/rqt_publisher
rqt_py_common /opt/ros/kinetic/share/rqt_py_common
rqt_py_console /opt/ros/kinetic/share/rqt_py_console
rqt_reconfigure /opt/ros/kinetic/share/rqt_reconfigure
rqt_robot_dashboard /opt/ros/kinetic/share/rqt_robot_dashboard
rqt_robot_monitor /opt/ros/kinetic/share/rqt_robot_monitor
rqt_robot_steering /opt/ros/kinetic/share/rqt_robot_steering
rqt_runtime_monitor /opt/ros/kinetic/share/rqt_runtime_monitor
rqt_rviz /opt/ros/kinetic/share/rqt_rviz
rqt_service_caller /opt/ros/kinetic/share/rqt_service_caller
rqt_shell /opt/ros/kinetic/share/rqt_shell
rqt_srv /opt/ros/kinetic/share/rqt_srv
rqt_tf_tree /opt/ros/kinetic/share/rqt_tf_tree
rqt_top /opt/ros/kinetic/share/rqt_top
rqt_topic /opt/ros/kinetic/share/rqt_topic
rqt_web /opt/ros/kinetic/share/rqt_web
rviz /opt/ros/kinetic/share/rviz
rviz_plugin_tutorials /opt/ros/kinetic/share/rviz_plugin_tutorials
rviz_python_tutorial /opt/ros/kinetic/share/rviz_python_tutorial
self_test /opt/ros/kinetic/share/self_test
sensor_msgs /opt/ros/kinetic/share/sensor_msgs
shape_msgs /opt/ros/kinetic/share/shape_msgs
smach /opt/ros/kinetic/share/smach
smach_msgs /opt/ros/kinetic/share/smach_msgs
smach_ros /opt/ros/kinetic/share/smach_ros
smclib /opt/ros/kinetic/share/smclib
stage /opt/ros/kinetic/share/stage
stage_ros /opt/ros/kinetic/share/stage_ros
std_msgs /opt/ros/kinetic/share/std_msgs
std_srvs /opt/ros/kinetic/share/std_srvs
stereo_image_proc /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_pipeline/stereo_image_proc
stereo_msgs /opt/ros/kinetic/share/stereo_msgs
tf /opt/ros/kinetic/share/tf
tf2 /opt/ros/kinetic/share/tf2
tf2_eigen /opt/ros/kinetic/share/tf2_eigen
tf2_geometry_msgs /opt/ros/kinetic/share/tf2_geometry_msgs
tf2_kdl /opt/ros/kinetic/share/tf2_kdl
tf2_msgs /opt/ros/kinetic/share/tf2_msgs
tf2_py /opt/ros/kinetic/share/tf2_py
tf2_ros /opt/ros/kinetic/share/tf2_ros
tf_conversions /opt/ros/kinetic/share/tf_conversions
theora_image_transport /home/lagadic/catkin_ws/src/ROS_OpenCV_dependencies/image_transport_plugins/theora_image_transport
topic_tools /opt/ros/kinetic/share/topic_tools
trajectory_msgs /opt/ros/kinetic/share/trajectory_msgs
turtle_actionlib /opt/ros/kinetic/share/turtle_actionlib
turtle_tf /opt/ros/kinetic/share/turtle_tf
turtle_tf2 /opt/ros/kinetic/share/turtle_tf2
turtlesim /opt/ros/kinetic/share/turtlesim
urdf /opt/ros/kinetic/share/urdf
urdf_parser_plugin /opt/ros/kinetic/share/urdf_parser_plugin
urdf_tutorial /opt/ros/kinetic/share/urdf_tutorial
visp_bridge /home/lagadic/catkin_ws/src/vision_visp/visp_bridge
visualization_marker_tutorials /opt/ros/kinetic/share/visualization_marker_tutorials
visualization_msgs /opt/ros/kinetic/share/visualization_msgs
webkit_dependency /opt/ros/kinetic/share/webkit_dependency
xacro /opt/ros/kinetic/share/xacro
xmlrpcpp /opt/ros/kinetic/share/xmlrpcpp
```

## ROS
- locate a package: `rospack find rviz`

## QtCreator setup
- Rename `~/catkin_ws/src/CMakeLists.txt` to `~/catkin_ws/src/CMakeLists.txt.symlink`
- Copy the content of the file (`/opt/ros/kinetic/share/catkin/cmake/toplevel.cmake`) pointed in `~/catkin_ws/src/CMakeLists.txt.symlink` into a new `~/catkin_ws/src/CMakeLists.txt`
- In a bash terminal with `source devel/setup.bash` set, launch QtCreator `~/Qt/Tools/QtCreator/bin/qtcreator &`
  
## Docker
- [How to use Docker (with ROS)](https://github.com/alecGraves/wiki/wiki/How-to-use-Docker-(with-ROS))
```
docker pull ros:kinetic-perception
nvidia-docker run -v /host/dir:/home/docker_dir -e DISPLAY  -v "/tmp/.X11-unix:/tmp/.X11-unix" -it ros:kinetic-perception
# without nvidia-docker should also work?
#
source /opt/ros/kinetic/setup.bash
roscore
# for the other terminals
docker exec -it container_id bash
#
rosrun image_view image_view image=/camera/image/image_raw #use appropriate topic name
```
- [docker_run](https://github.com/lakehanne/Shells/blob/master/docker_run)
```
#/bin/bash

printf '\n\nbinding xhost to the docker engine'
xhost +local:root

printf '\n\nWould you be attaching the display? \t [y/n] \n'
read disp_resp

echo -e "\nEnter the image and tag name: e.g. \n\t<$USER/repo:tag>\n"
read repo_tag

echo -e "\nAre you attaching a usb device? \t [y/n] \n"
read usb_resp

echo -e "\nAre you attaching the system's gpu? [y|n] \n"
read gpu_resp

is_yes() {
	yesses={y,Y,yes,Yes,YES}
	if [[ $yesses =~ $1 ]]; then
		echo 1
	fi
	}

is_no() {
        noses={n,N,no,No,No}
        if [[ $noses =~ $1 ]]; then
                echo 1
        fi
        }
disp="-v /tmp/.X11-unix:/tmp/.X11-unix:ro -e DISPLAY=$DISPLAY"
usb_mode="--privileged -v /dev/bus/usb:/dev/bus/usb"
gpu_mode="--device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm"

if [ $(is_yes $usb_resp)  ]  && [  $(is_yes $disp_resp) ] && [ $(is_yes $gpu_resp) ]; then
		echo -e "running 'docker run -ti --rm $disp $usb_mode $repo_tag $gpu_mode' "
		docker run -ti --rm $disp  $usb_mode  $gpu_mode $repo_tag
elif [ $(is_yes $usb_resp)  ]  && [  $(is_yes $disp_resp) ] && [ $(is_no $gpu_resp) ]; then
		echo -e "running 'docker run -ti --rm $disp $usb_mode $repo_tag' "
		docker run -ti --rm $disp  $usb_mode  $repo_tag		
elif [ $(is_yes $usb_resp) ] && [ $(is_no $disp_resp) ] && [ $(is_no $gpu_resp)]; then
	echo -e "docker run -it --rm $usb_mode $repo_tag"
        docker run -it --rm $usb_mode $repo_tag
elif [ $(is_no $usb_resp) ] && [ $(is_no $disp_resp) ] && [ $(is_no $gpu_resp)]; then
	echo -e "docker run -it --rm $usb_mode $repo_tag"
        docker run -it --rm $repo_tag        
elif [ $(is_no $usb_resp) ] && [ $(is_yes $disp_resp) ]; then
	echo -e "docker run -ti --rm $disp $repo_tag"
	docker run -ti --rm $disp $repo_tag
else [ $is_no $usb_rep ] && [ $is_no  $disp_resp ]
	echo -e "running without display or usb privileged mode"
	docker run -ti --rm $repo_tag
fi
```
- [Is it possible to run ROS (robotic operating system) inside a Docker and have X11 outputs from GUI tools?](https://www.quora.com/Is-it-possible-to-run-ROS-robotic-operating-system-inside-a-Docker-and-have-X11-outputs-from-GUI-tools)
```
sudo docker run -it  --rm=true  --name <CONTAINER NAME>   -e DISPLAY  -v "/tmp/.X11-unix:/tmp/.X11-unix"  <image name>   bash
# if “No protocol specified QXcbConnection: Could not connect to display :0”.
# You should allow clients from any host, using command “ xhost + “.
#
# Mac OS X
# xquartz 
open -a XQuartz 

# XQuarzt ip setup 
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') 
xhost + $ip

# docker run with XQuartz 

docker run -it --name <CONTAINER NAME> -e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix <image name> bash
```

## Camera Calibration
- [ros-drivers/usb_cam](https://github.com/ros-drivers/usb_cam) ([http://wiki.ros.org/usb_cam](http://wiki.ros.org/usb_cam))
- [How to Calibrate a Monocular Camera](http://library.isr.ist.utl.pt/docs/roswiki/camera_calibration(2f)Tutorials(2f)MonocularCalibration.html):
```
# Install
$ rosdep install camera_calibration
$ rosmake camera_calibration
#
$ rostopic list
/usb_cam/camera_info
/usb_cam/image_raw
#
rosrun camera_calibration cameracalibrator.py --size 9x6 --square 0.03 image:=/usb_cam/image_raw camera:=/usb_cam
```
- [Calibrating a Monocular Camera with ROS](http://ros-developer.com/2017/04/23/camera-calibration-with-ros/):
```
sudo apt-get install ros-kinetic-usb-cam uvcdynctrl
# check if your camera supports autofocus:
uvcdynctrl --device=/dev/video0 --clist
# turn off the autofocus:
uvcdynctrl --device=/dev/video0 --set='Focus, Auto' 0
# check if the autofocus is off:
uvcdynctrl --device=/dev/video0 --get='Focus, Auto'
# Publish the data from your camera, for example, via use usb_cam:
rosrun usb_cam usb_cam_node
# Calibration
rosrun camera_calibration cameracalibrator.py --size 9x6 --square 0.02517 image:=/usb_cam/image_raw camera:=/usb_cam --no-service-check
```
- [camera_calibration](http://wiki.ros.org/camera_calibration)

## ROS robot_localization
- [robot_localization wiki](http://docs.ros.org/kinetic/api/robot_localization/html/)
- [Working with the robot_localization Package](https://roscon.ros.org/2015/presentations/robot_localization.pdf)
- [Relationsship between map, odom and base_link coordinate frames](https://answers.ros.org/question/329980/relationsship-between-map-odom-and-base_link-coordinate-frames/)
- [In robot_localization, why does differential mode not use static transforms?](https://answers.ros.org/question/329146/in-robot_localization-why-does-differential-mode-not-use-static-transforms/)
- [ROS Transformations and frames](https://linklab-uva.github.io/autonomousracing/assets/files/L11-compressed.pdf)
- [Integrate 3D sensing in robot_localization package](https://answers.ros.org/question/330821/integrate-3d-sensing-in-robot_localization-package/)

## Visual Odometry
- [rtabmap_ros](http://wiki.ros.org/rtabmap_ros)
- [viso2_ros](http://wiki.ros.org/viso2_ros)

## Fiducial markers
- [ar_track_alvar](http://wiki.ros.org/ar_track_alvar)

## Misc
- message generation issue with `Float64`:
```
CMake Error at /home/user/catkin_ws/build/project/cmake/project-genmsg.cmake:3 (message):
  Could not find messages which
  '/home/user/catkin_ws/src/project/msg/Float64ArrayStamped.msg' depends
  on.  Did you forget to specify generate_messages(DEPENDENCIES ...)?

  Cannot locate message [Float64] in package [project] with paths
  [['/home/user/catkin_ws/src/project/msg']]
Call Stack (most recent call first):
  /opt/ros/kinetic/share/genmsg/cmake/genmsg-extras.cmake:307 (include)
  mascot_ros/CMakeLists.txt:29 (generate_messages)
```
- just declare in `Float64ArrayStamped.msg` `Float64` as `std_msgs/Float64`
- some info about message delays, ...:
  - [Image subscriber lag (despite queue = 1)](https://answers.ros.org/question/220502/image-subscriber-lag-despite-queue-1/?answer=220505#post-id-220505)
  - [How to force the subscriber to read the latest message in a topic?](https://answers.ros.org/question/278405/how-to-force-the-subscriber-to-read-the-latest-message-in-a-topic/?answer=278554#post-id-278554)
  - [ROS publish/subscribe queues](https://answers.ros.org/question/277613/ros-publishsubscribe-queues/)
- rosrun with parameters from command line:
  - [http://wiki.ros.org/Remapping%20Arguments](http://wiki.ros.org/Remapping%20Arguments):
  > You can assign private parameters for a node directly from the command-line using a single underscore _ as a prefix. For example,
  >
  > `rosrun rospy_tutorials talker _param:=1.0`
  - [http://wiki.ros.org/Parameter%20Server#Private_Parameters](http://wiki.ros.org/Parameter%20Server#Private_Parameters):
  > The ROS naming convention refers to ~name as a private name. These private names primarily are for parameters specific to a single Node. The ~ prefix prepends the Node's name to use it as a semi-private namespace -- they are still accessible from other parts of the system, but they are generally protected from accidental name collisions.
  >
  > You can use remapping arguments to specify node parameters on the command line by changing the tilde ~ to an underscore _, e.g.:
  >
  > `rosrun rospy_tutorials talker _param:=1.0`
  - example code:
  ```
  #include <ros/ros.h>

  int main(int argc, char *argv[]) {
    ros::init(argc, argv, "rosrun_parameters_cmd_line_node");
    ros::NodeHandle nh("~");

    double param_dbl = nh.param("param_dbl", 10.0);
    std::cout << "param_dbl: " << param_dbl << std::endl;

    int param_int = 50;
    nh.getParam("param_int", param_int);
    std::cout << "param_int: " << param_int << std::endl;

    bool param_bool = nh.param("param_bool", true);
    std::cout << "param_bool: " << param_bool << std::endl;

    std::string param_str = nh.param<std::string>("param_str", "default string");
    std::cout << "param_str: " << param_str << std::endl;

    return 0;
  }
  ```
- [Debugging tf problems](http://wiki.ros.org/tf/Tutorials/Debugging%20tf%20problems) ([tf package](http://wiki.ros.org/tf), [     tf/Debugging tools](http://wiki.ros.org/tf/Debugging%20tools)):
```
# echo tf
 $ rosrun tf tf_echo turtle3 turtle1
# show tf tree
$ rosrun tf view_frames
$ evince frames.pdf
# show tf tree
$ rosrun rqt_tf_tree rqt_tf_tree
# checking the timestamps
$ rosrun tf tf_monitor turtle2 turtle1
# roswtf
$ roswtf
```
- [Run RViz with configuration file from .launch file](https://answers.ros.org/question/287670/run-rviz-with-configuration-file-from-launch-file/?answer=287673#post-id-287673):
```
<launch>
  <node type="rviz" name="rviz" pkg="rviz" args="-d $(find package_name)/rviz/config_file.rviz" />
</launch>
```
- [How can I stop Rtabmap from publishing transform data on /tf topic?](https://answers.ros.org/question/292835/how-can-i-stop-rtabmap-from-publishing-transform-data-on-tf-topic/?answer=292869#post-id-292869):
```
<node pkg="rtabmap_ros" type="rgbd_odometry" name="rgbd_odometry" output="screen">
  <remap from="rgb/image"       to="/camera/rgb/image_rect_color"/>
  <remap from="depth/image"     to="/camera/depth_registered/image_raw"/>
  <remap from="rgb/camera_info" to="/camera/rgb/camera_info"/>
  <param name="frame_id"    type="string" value="camera_link"/>
  <param name="publish_tf"  type="bool"   value="false"/>
</node>
```
