#include "cv.h"
#include "highgui.h"
#include <stdio.h>
#include <numeric.h>

#define NUM_IMAGES 10
#define NUM_PIXELS 396

float range_0[];
float* ranges_d[];


int main( int argc, char** argv )
{

    //variable declaration:

    IplImage* src;
    IplImage* grey;
    IplImage* inputs[NUM_IMAGES];
    char names[NUM_IMAGES][20] = {"yucel5.jpg","yucel3.jpg","yucel1.jpg","yucel2.jpg","ulas.jpg",
                                  "alp.jpg","aytunc.jpg","basak.jpg","bugra.jpg","can.jpg"};
    array double imgvect[NUM_PIXELS][NUM_IMAGES];
    int i, j, x, y, pixel;

 
    // Create the windows 
    cvNamedWindow("InputImage", 1);
    cvNamedWindow("GreyImage", 1);

    /* read in all the images into the vector imgvect */
    for (j = 0; j < NUM_IMAGES; j++) {
 
        src = cvLoadImage(names[j],1);
        cvShowImage( "InputImage", src );
        grey = cvCreateImage(cvSize(src->width,src->height), IPL_DEPTH_8U, 1);
        cvCvtColor(src, grey, CV_BGR2GRAY);
        cvShowImage( "GreyImage", grey );


        i = 0;
        for (x = 0; x < src->width; x++) {
            for (y = 0; y < src->height; y++) {
                pixel = ((uchar*)(src->imageData + src->widthStep*y))[x];
                //if (i < 20) printf("Pixval %d\n", pixel);
                imgvect[i++][j] = pixel;
            }
        }
    

        printf("width %d height %d\n", src->width, src->height);
        //printf("last pixel value %d\n", pixel);
        //printf("imgvect = \n%f\n", imgvect);

        cvWaitKey(0);
    }
    
   
}

 

