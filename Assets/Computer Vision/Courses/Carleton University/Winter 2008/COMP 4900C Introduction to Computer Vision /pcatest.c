#include "cv.h"
#include "highgui.h"
#include <stdio.h>
#include <numeric.h>

#define NUM_IMAGES 4
#define NUM_PIXELS 6

void PCA( array double allimages[NUM_PIXELS][NUM_IMAGES], 
          array double projections[NUM_IMAGES][NUM_PIXELS])
{
    /* you musst write this routine */
}

int main( int argc, char** argv )
{

    //variable declaration:

    array double imgvect[NUM_PIXELS][NUM_IMAGES];
    array double projections[NUM_IMAGES][NUM_PIXELS];
    
    urand(imgvect);
    PCA(imgvect, projections);
    
}

 

