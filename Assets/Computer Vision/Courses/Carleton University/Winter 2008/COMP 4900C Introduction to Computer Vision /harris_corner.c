/*
    Harris Corner Template by Rossen Atanassov
    Last modified: Feb 9, 2006
*/

#ifdef _CH_
#pragma package <opencv>
#endif

#include "harris_corner.h"


//----------------------- Harris Corner Detector -----------------------//


void generateCorners( ) {

	CvSize src_size = cvGetSize (gray);

	// create temporary images to store the two image derivatives
	CvMat *dx = cvCreateMat (src_size.height, src_size.width, CV_16SC1);
    CvMat *dy = cvCreateMat (src_size.height, src_size.width, CV_16SC1);

    cvSobel (gray, dx, 1, 0, APETURE_SIZE);
    cvSobel (gray, dy, 0, 1, APETURE_SIZE);


	// Setup the buffers
    harris_responce = cvCloneImage (image);

    // This array will store all corners found in the image
    corners = (CvPoint2D32f*)cvAlloc (MAX_CORNERS * sizeof (corners));

    int corner_count = MAX_CORNERS;
	
	/* ---------- STUDENT MUST CALL THEIR VERSION OF CORNER DETECTOR HERE ----------- //
        At this point you have to call a function that you have written in order to
        detect all corners in the image based on the following:
        1. Current minimum distance allowed.
        2. Current threshold.
        3. The precomputed derivatives stored inside DX and DY.
        Hints:
        - Make sure that you handle cases where the minimum size allowed is zero 
          or less.
        - You can use cvmGet(image, x, y) in order to get the value of a pixel.
        - You can use cvmSet(image, x, y, value) to set the value of a pixel.
        - For more info look at the "CXCORE Reference Manual" and "CV Reference Manual" 
          of your OpenCV documentation.
	
	// ------------------------------------------------------------------------------ */


	// prep the text of the window
	sprintf (message, "Corner count: %d", count);

    // Draw all corners
	drawCorners (harris_responce, corners, count);

    // Optionally, you can display information inside the image.
    // For example: text with the corners count.
	drawText (harris_responce, message);
    
    // Display the images
	cvShowImage (wdSource, image);
	cvShowImage (wdResult, harris_responce);

	// Release the buffers
	cvReleaseMat( &dx );
    cvReleaseMat( &dy );
	cvReleaseImage (&harris_responce);
}

//----------------------- Image painting functions -----------------------//

/* Displays the found corners as crosses */
void drawCorners (IplImage *img, CvPoint2D32f *corners, int count) {
    // MUST BE COMPLETED BY THE STUDENT
    // Hint: look at the OpenCV documentation in order to find examples
}

/* Paints a string a given image */
void drawText (IplImage *img, char *msg) {
    // MUST BE COMPLETED BY THE STUDENT
    // Hint: look at the OpenCV documentation in order to find examples
}




/* ###################################################################### //

      THE FUNCTIONS BELLOW SHOULD NOT REQUIRE CHANGES BY THE STUDENTS

// ###################################################################### */


//----------------------- Trackbar event handlers -----------------------//
void on_tab_thresh (int thresh) {
	tab_thresh = thresh;
	generateCorners ();
}

void on_tab_dist (int distance) {
	tab_dist = distance;
	generateCorners ();
}

//----------------------- Application main function -----------------------//

int main( int argc, char** argv ) {

	// Check for the input image
	char *filename = (argc == 2) ? argv[1] : (char*)"checker.jpg";

	// Load the image from the file
	if ((image = cvLoadImage (filename,1)) == 0) return -1;

    // Convert to grayscale
    gray= cvCreateImage(cvSize(image->width,image->height), IPL_DEPTH_8U, 1);
    cvCvtColor(image, gray, CV_BGR2GRAY);


    // Create windows.
    cvNamedWindow(wdSource, 1);
    cvNamedWindow(wdResult, 1);

	// Create the toolbars
	cvCreateTrackbar (tbThreshName, wdSource, &tab_thresh, 100, on_tab_thresh);
	cvCreateTrackbar (tbDistanceName, wdSource, &tab_dist, 20, on_tab_dist);

	// Get all corners
    generateCorners ();

    // Wait for a key stroke
    cvWaitKey(0);
    cvReleaseImage(&image);
    cvReleaseImage(&harris_responce);
 
    cvDestroyWindow(wdSource);
    cvDestroyWindow(wdResult);

    return 0;
}