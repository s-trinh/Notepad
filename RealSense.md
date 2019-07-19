### Datasheets / Documentation
- [Intel® RealSense™ D400 Series Product Family](https://realsense.intel.com/wp-content/uploads/sites/63/Intel_RealSense_D400_Family_Datasheet_Jan2019.pdf)
- [Intel® RealSense™ Tracking Camera](https://www.intel.com/content/dam/support/us/en/documents/emerging-technologies/intel-realsense-technology/IntelRealSenseTrackingT265Datasheet.pdf)
- [Tuning the Intel® RealSense™ D400 Series Cameras for Optimal Performance](https://realsense.intel.com/webinar_tune/) ([presentation](https://realsense.intel.com/wp-content/uploads/sites/63/BKM-For-Tuning-D435-and-D415-Cameras-Webinar_Rev3.pdf))
- [Best-Known-Methods for Tuning Intel® RealSense™D400 Depth Camerasfor Best Performance](https://www.intel.com/content/dam/support/us/en/documents/emerging-technologies/intel-realsense-technology/BKMs_Tuning_RealSense_D4xx_Cam.pdf)

### ROS
- [https://github.com/intel-ros/realsense](https://github.com/intel-ros/realsense), final backslash seems important?:
```
catkin_make --cmake-args -Drealsense2_DIR=<librealsense/build/install/lib/cmake/realsense2/>
```
- Compatibility between RealSense viewer rosbag and ROS ([issue thread](https://github.com/IntelRealSense/librealsense/issues/2619#issuecomment-433459861)):
```
roslaunch realsense2_camera rs_from_file.launch rosbag_filename:=<rosbag_file.bag>
```
- Start the camera node:
```
roslaunch realsense2_camera rs_camera.launch
```
- RGBD Point Cloud:
```
roslaunch realsense2_camera rs_camera.launch filters:=pointcloud
# In rviz, add by topic name --> /camera/depth/color/points
# In rviz, in Displays panel --> Global Options > Fixed Frame --> select camera_link
#
roslaunch realsense2_camera rs_camera.launch filters:=pointcloud color_width:=1280 color_height:=720 depth_width:=1280 depth_height:=720 infra_width:=1280 infra_height:=720
#
# https://github.com/intel-ros/realsense/issues/308
# sudo apt install ros-kinetic-rgbd-launch
roslaunch realsense2_camera rs_rgbd.launch depth_width:=1280 depth_height:=720 infra_width:=1280 infra_height:=720 color_width:=1280 color_height:=720
```
- `rqt_reconfigure`
```
rosrun rqt_reconfigure rqt_reconfigure
```
- [Error: `Failed to unload module videobuf2_core`](https://github.com/IntelRealSense/librealsense/issues/2846) when launching `sudo ./scripts/patch-realsense-ubuntu-lts.sh`:
```
# Unplug all the camera devices
# Launch manually
sudo modprobe -r uvcvideo
sudo modprobe -r videobuf2_core #(imho it unwinds automatically once you release uvcvideo)
sudo modprobe -r videodev
# Delete Ubuntu directory
# Relaunch the patch
```
- [Linux distribution](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md):
```
sudo apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE
# Ubuntu 16 LTS:
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u
# Ubuntu 18 LTS:
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u
# To get the correct patched kernel modules?
# udev rules must be done before?
sudo apt-get install librealsense2-dkms
# Verify that the kernel is updated:
modinfo uvcvideo | grep "version:" # should include realsense string
```
