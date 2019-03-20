### Datasheets / Documentation
- [Intel® RealSense™ D400 Series Product Family](https://realsense.intel.com/wp-content/uploads/sites/63/Intel_RealSense_D400_Family_Datasheet_Jan2019.pdf)
- [Intel® RealSense™ Tracking Camera](https://www.intel.com/content/dam/support/us/en/documents/emerging-technologies/intel-realsense-technology/IntelRealSenseTrackingT265Datasheet.pdf)
- [Tuning the Intel® RealSense™ D400 Series Cameras for Optimal Performance](https://realsense.intel.com/webinar_tune/) ([presentation](https://realsense.intel.com/wp-content/uploads/sites/63/BKM-For-Tuning-D435-and-D415-Cameras-Webinar_Rev3.pdf))
- [Best-Known-Methods for Tuning Intel® RealSense™D400 Depth Camerasfor Best Performance](https://www.intel.com/content/dam/support/us/en/documents/emerging-technologies/intel-realsense-technology/BKMs_Tuning_RealSense_D4xx_Cam.pdf)

### ROS
- [https://github.com/intel-ros/realsense](https://github.com/intel-ros/realsense):
```
catkin_make --cmake-args -Drealsense2_DIR=<librealsense/build/install/lib/cmake/realsense2>
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
```
