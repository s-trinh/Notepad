#ifdef _CH_
#pragma package <opencv>
#endif

#include "cv.h"
#include "highgui.h"

// Load the source image. HighGUI use.
IplImage *image = 0, *gray = 0;

int main( int argc, char** argv )
{
    char* filename = argc == 2 ? argv[1] : (char*)"fruits.jpg";
    
    if( (image = cvLoadImage( filename, 1)) == 0 )
        return -1;
    
    // Convert to grayscale
    gray = cvCreateImage(cvSize(image->width,image->height), IPL_DEPTH_8U, 1);
    cvCvtColor(image, gray, CV_BGR2GRAY);

    // Create windows.
    cvNamedWindow("Source", 1);
    cvNamedWindow("Result", 1);

    // Show the images.
    cvShowImage("Source", image);
    cvShowImage("Result", gray);
    
    // Wait for a key stroke
    cvWaitKey(0);
    cvReleaseImage(&image);
    cvReleaseImage(&gray);
 
    cvDestroyWindow("Source");
    cvDestroyWindow("Result");

    return 0;
}