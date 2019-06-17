/*
    Harris Corner Template by Rossen Atanassov
    Last modified: Feb 9, 2006
*/

#include <stdio.h>
#include <string.h>
#include <cv.h>
#include <highgui.h>

#define APETURE_SIZE 3
#define BLOCK_SIZE 5
#define K 0.04
#define MAX_CORNERS 100000

char *wdSource = "Conrners";		// name of the app window
char *wdResult = "Result";		    // name of the window that is used for debuging
char *tbThreshName = "Threshold";	// name of the tab slider
char *tbDistanceName = "Distance";	// name of the distance tab slider

int tab_thresh = 10,	/* threshold for tau i.e. lambda 2 */
	min_thresh = 2,		/* the minimum threshold used when smoothing */
	tab_dist = 10,		/* the minimum distance between two points */
	count = 0,			/* number of corners found */
	Q_size = 10;		/* the size of N that is used in the neighborhood Q */
char message[80];		/* used to store a string for output */


// Load the source image. HighGUI use.
IplImage *image = 0, *harris_responce = 0, *gray=0;
IplImage *eig_image=0, *temp_image=0;

// An array of points representing the found corners
CvPoint2D32f *corners;

// Functions used to manipulate the final image
void drawCorners (IplImage *, CvPoint2D32f *, int);     /* Displays the found corners as crosses */
void drawText (IplImage *, char *);                     /* Paints a string a given image */