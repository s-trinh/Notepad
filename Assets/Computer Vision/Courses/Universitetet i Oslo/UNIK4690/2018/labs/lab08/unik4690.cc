#include "System.h"

int main(int argc, char** argv)
{
  if (argc < 3)
  { 
    std::cerr << "usage:\n  " << argv[0] << " <vocabulary> <settings>\n";
    return EXIT_FAILURE;
  }
  
  const std::string vocabulary(argv[1]); 
  const std::string settings(argv[2]); 

  // Connect to the camera
  constexpr int cam_id = 1;
  cv::VideoCapture cap{cam_id};
  if (!cap.isOpened())
  { throw std::runtime_error{"Could not open camera " + std::to_string(cam_id)}; }

  // Print camera settings. These must match the yaml file!
  const double frame_width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
  const double frame_height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);
  std::cout << "Image size: " << frame_width << ", " << frame_height << "\n";
  std::cout << "Current framerate: " << cap.get(cv::CAP_PROP_FPS) << "\n";

  // Create SLAM system. It initializes all system threads and gets ready to process frames.
  ORB_SLAM2::System SLAM(vocabulary, settings, ORB_SLAM2::System::MONOCULAR, true);

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

