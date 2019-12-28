#include "System.h"

int main(int argc, char** argv)
{
  // argv[1] = voc file
  // argv[2] = settings file

  // Connect to the camera
  cv::VideoCapture cap{1};
  if (!cap.isOpened())
  { throw std::runtime_error{"Could not open camera"}; }

  // Print camera settings. These must match the yaml file!
  double frame_width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
  double frame_height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);
  std::cout << "Image size: " << frame_width << ", " << frame_height << "\n";
  std::cout << "Current framerate: " << cap.get(cv::CAP_PROP_FPS) << "\n";

  // Create SLAM system. It initializes all system threads and gets ready to process frames.
  ORB_SLAM2::System SLAM(argv[1], argv[2], ORB_SLAM2::System::MONOCULAR, true);

  // Feed SLAM system with images.
  cv::Mat frame;
  std::chrono::steady_clock::time_point time_start = std::chrono::steady_clock::now();
  while (cap.read(frame))
  {
    std::chrono::steady_clock::time_point time_now = std::chrono::steady_clock::now();
    double timestamp = std::chrono::duration<double>(time_now - time_start).count();

    // Pass the image to the SLAM system
    SLAM.TrackMonocular(frame, timestamp);
  }

  // Stop all threads
  SLAM.Shutdown();

  return 0;
}

