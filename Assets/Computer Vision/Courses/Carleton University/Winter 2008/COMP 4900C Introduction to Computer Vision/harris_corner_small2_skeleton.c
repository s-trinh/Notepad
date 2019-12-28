/*
    Harris Corner Template by Rossen Atanassov
    Last modified: Feb 9, 2006
*/

#include <cv.h>
#include <highgui.h>
#include <stdio.h>
#include <string.h>
#include <numeric.h>

#define APETURE_SIZE 3
#define Q_SIZE 3
#define K 0.04
#define MAX_CORNERS 100000

char *wdSource = "Corners";		// name of the app window
char *wdResult = "Result";		    // name of the window that is used for debuging


// Load the source image. HighGUI use.
IplImage *image = 0, *harris_responce = 0, *gray=0;
IplImage *eig_image=0, *temp_image=0;

// An array of points representing the found corners
CvPoint3D32f *corners;


// Functions used to manipulate the final image
void drawCorners (IplImage *, CvPoint3D32f *, int, int, int);     /* Displays the found corners as points */

//----------------------- Harris Corner Detector -----------------------//



void generateCorners( ) {

	int corner_count;
    CvMat *dx, *dx1;
    CvMat *dy, *dy1;
    CvSize src_size;
    int i,j, count = 0;
    int rows;
    int cols;
    double smallestEigenvalue;

    src_size = cvGetSize (gray);

	// create temporary images to store the two image derivatives
    dx = cvCreateMat (src_size.height, src_size.width, CV_16SC1);
    dy = cvCreateMat (src_size.height, src_size.width, CV_16SC1);
    
    cvSobel (gray, dx, 1, 0, APETURE_SIZE);
    cvSobel (gray, dy, 0, 1, APETURE_SIZE);


	dx1 = cvCreateMat(src_size.height, src_size.width, CV_64FC1);
	dy1 = cvCreateMat(src_size.height, src_size.width, CV_64FC1);

	cvConvertScale( dx, dx1, 1, 0 );
	cvConvertScale( dy, dy1, 1, 0 );

	// Setup the buffers
    harris_responce = cvCloneImage (image);

    // This array will store all corners found in the image
    // The third dimension contains the value of lamda 2
    corners = (CvPoint3D32f*)cvAlloc (MAX_CORNERS * sizeof (corners));

    corner_count = MAX_CORNERS;
	
	/* ---------- STUDENT MUST CALL THEIR VERSION OF CORNER DETECTOR HERE ----------- //
        At this point you have to call a function that you have written in order to
        detect all corners in the image based on the following:
        1. Q_SIZE as defined in the book on. p 84. This is the neighborhood size.
        2. Current threshold for lamba2.
        3. The precomputed derivatives stored inside DX and DY.
        Hints:
        - You do not need to do steps 3 or 4 of the algorithm, only steps 1 and 2
        - You can use cvmGet(image, x, y) in order to get the value of a pixel.
        - You can use cvmSet(image, x, y, value) to set the value of a pixel.
        - For more info look at the "CXCORE Reference Manual" and "CV Reference Manual" 
          of your OpenCV documentation.
	
	// ------------------------------------------------------------------------------ */

    printf("start corner detection\n");
    
    printf("corners before distance threshold %d\n", count);
    printf("\n num of corners = %d\n", count);
    
    // Draw all corners
	drawCorners (harris_responce, corners, count, src_size.width, src_size.height);

    
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
void drawCorners (IplImage *img, CvPoint3D32f *corners, int count, int numRows, int numCols) {
	
}



//----------------------- Application main function -----------------------//

int main( int argc, char** argv ) {

	// Check for the input image
	char *filename = (argc == 2) ? argv[1] : (char*)"checker_smaller.jpg";

	// Load the image from the file
	if ((image = cvLoadImage (filename,1)) == 0) return -1;

    // Convert to grayscale
    gray= cvCreateImage(cvSize(image->width,image->height), IPL_DEPTH_8U, 1);
    cvCvtColor(image, gray, CV_BGR2GRAY);


    // Create windows.
    cvNamedWindow(wdSource, 1);
    cvNamedWindow(wdResult, 1);


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