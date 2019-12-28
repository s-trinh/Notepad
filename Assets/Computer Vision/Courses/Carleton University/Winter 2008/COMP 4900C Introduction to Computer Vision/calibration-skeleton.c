#include "cv.h"
#include "highgui.h"
#include <stdio.h>
#include <numeric.h>

#define NUM_FEATURES  10
#define RANGE         100.00

#define MAX_CAMERAS   100
#define MAX_POINTS    3000

array double camera0[3][4];
array double allthreedpoints[MAX_POINTS][3];
array double twodpoints0[MAX_POINTS][2];

/* take the projection matrix and decompose to find the rotation, translation and calibration.
   taken from 6.3.2 of Trucco and Verri */
void decomposeprojectionmatrix(array double P[3][4], array double r[3][3], array double t[3], array double K[3][3])
{
 
}

/* take the R, T, and K and use then to create the projection matrix */
void composeprojectionmatrix(array double r[3][3], array double t[3], array double K[3][3], array double P[3][4])
{
}

/* compute rotation matrix from the three given Euler angles */
void eulerangletorotmatrix(double a, double b, double c, double array r[3][3])
{
    array double r1[3][3], r2[3][3], r3[3][3];
    
    r1[0][0] = cos(a); r1[0][1] = -sin(a);r1[0][2] = 0;
    r1[1][0] = sin(a); r1[1][1] = cos(a); r1[1][2] = 0;
    r1[2][0] = 0;      r1[2][1] = 0;      r1[2][2] = 1.0;
    
    r2[0][0] = cos(b); r2[0][1] = 0;      r2[0][2] = sin(b);
    r2[1][0] = 0;      r2[1][1] = 1.0;    r2[1][2] = 0;
    r2[2][0] = -sin(b);r2[2][1] = 0;      r2[2][2] = cos(b);
    
    r3[0][0] = 1.0;    r3[0][1] = 0;      r3[0][2] = 0;
    r3[1][0] = 0;      r3[1][1] = cos(c); r3[1][2] = -sin(c);
    r3[2][0] = 0;      r3[2][1] = sin(c); r3[2][2] = cos(c);
    
    r = r1*r2*r3;
}

/* take the projection matrix, apply it to the 3d points, and then see how close
   the projected points are to the given twod projections */
void testprojectionmatrix(array double threedpoints[NUM_FEATURES][3], 
                          array double twodprojections[NUM_FEATURES][2],
                          array double projectionmatrix[3][4])
{
        
}


/* add random noise to the 2d points */
void addnoiseto2dpoints(array double twodprojections[NUM_FEATURES][2], float maxnoise)
{
    int i;
    
    for (i = 0; i < NUM_FEATURES; i++) {
        twodprojections[i][0] += maxnoise*urand(NULL);
        twodprojections[i][1] += maxnoise*urand(NULL);        
    }

}

/* compute a set of random 3d points, all of which have positive values in x, y and z */
void computerandomthreedpoints(array double threedpoints[NUM_FEATURES][3])
{
    int i;
    for (i = 0; i < NUM_FEATURES; i++) {
        threedpoints[i][0] = RANGE*urand(NULL); 
        threedpoints[i][1] = RANGE*urand(NULL); 
        threedpoints[i][2] = RANGE*urand(NULL);
    }
}


/* given a set of correspondences from 3d to 2d points compute the projection matrix
   that produces these correspondence values. Uses the method described in 6.3 of Trucco and Verri */
void computeprojectionmatrix(array double threedpoints[NUM_FEATURES][3], 
                             array double twodprojections[NUM_FEATURES][2],
                             array double projectionmatrix[3][4])
{
}

/* set the K matrix to an arbitrary values */
void setkmatrix(array double K[3][3])
{
    int i, j;
    for (i = 0; i < 3; i++)
        for (j = 0; j < 3; j++)
            K[i][j] = 0;
    K[0][0] = -1000; K[1][1] = -2000;
    K[0][2] = 320;   K[1][2] = 240;
    K[2][2] = 1.0;
}

/* set translation to an arbitrary value */
void settrans(array double t[3])
{
    t[0] = 10.0; t[1] = 15.0; t[2] = 20.0;
}

/* just apply the projection matrix to the 3d points to get a set of 2d points */
void applyprojectionmatrix(array double threedpoints[NUM_FEATURES][3], 
                           array double twodprojections[NUM_FEATURES][2],
                           array double projectionmatrix[3][4])
{
        
}

/* take the given rin matrix which is not a true rotation matrix and make it
   into the closest true rotation matrix. Again from Trucco and Verri */
void findbestRmatrix(double array rin[3][3], double array rout[3][3])
{
}

int main( int argc, char** argv )
{
    array double threedpoints[NUM_FEATURES][3];
    array double twodprojections[NUM_FEATURES][2];
    array double projectionmatrix[3][4],computedprojectionmatrix[3][4];
    array double r[3][3],rbest[3][3],rout[3][3];
    array double t[3], tout[3],Kout[3][3],K[3][3];
    int i, j;

    eulerangletorotmatrix(.2, .4, .6, r);
    setkmatrix(K);
    settrans(t);
    composeprojectionmatrix(r, t, K, projectionmatrix);
    
    /* first compute some random 3d points */
    computerandomthreedpoints(threedpoints);
    /* apply the projection matrix to the 3d points */
    applyprojectionmatrix(threedpoints, twodprojections, projectionmatrix);
    /* add some noise to the 2d points */
    addnoiseto2dpoints(twodprojections, 0.0);
    /* test the application of the projection matrix */
    testprojectionmatrix(threedpoints, twodprojections, projectionmatrix);  
    /* now compute a new projection matrix only from the 3d and 2d points */
    computeprojectionmatrix(threedpoints, twodprojections, computedprojectionmatrix);
    /* check that the applicaton of this new projection matrix works */
    testprojectionmatrix(threedpoints, twodprojections, computedprojectionmatrix);
    /* decompose projection matrix to get extrinsic and intrsinic calibration */
    decomposeprojectionmatrix(computedprojectionmatrix, rout, tout, Kout);
    /* compute best R matrix */
    findbestRmatrix(rout, rbest);
    /* the R, T and K matrix should be same as was set orignally since data has no noise */

    printf("\nOriginal R\n%f\n", r);
    printf("Original T\n%f\n", t);
    printf("Original K\n%f\n", K);
    
    printf("Extracted R\n%f\n", rout);
    printf("Extracted T\n%f\n", tout);
    printf("Extracted K\n%f\n", Kout);


}


 
/* give students eulerangletorotmatrix, setkmatrix, settrans,computerandomthreedpoints.
   they must write the code for all the other routines in the main program. */

