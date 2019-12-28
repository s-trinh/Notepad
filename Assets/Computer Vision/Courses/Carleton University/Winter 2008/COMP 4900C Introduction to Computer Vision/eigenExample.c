/*
    Eigen Values and Vectors Example created by Rossen Atanassov
    Last modified: Feb 9, 2006
*/

#include <stdio.h>
#include <math.h>
#include <float.h>
#include <numeric.h>

void main() { 
    /* eigenvalues of a symmtrical matrix are always real numbers */ 
    array double A[3][3] = {0.8, 0.2, 0.1, 
                            0.2, 0.7, 0.3, 
                            0.1, 0.3, 0.6}; 

    /* eigenvalues of a non-symmtrical matrix can be either real numbers or complex numbers */ 
    /* this non-symmtrical matrix has real eigenvalues */ 
    array double B[3][3] = {0.8, 0.2, 0.1, 
                            0.1, 0.7, 0.3, 
                            0.1, 0.1, 0.6};
                             
    /* this non-symmtrical matrix has complex eigenvalues and eigenvectors*/ 
    array double C[3][3] = {3, 9, 23, 
                            2, 2,  1, 
                           -7, 1, -9};
                           
    /* Matrix operations are also supported such as:
        C = A + B;
        C = A * B;
        etc.
    */
    
    printf("Array A \n%f\nArray B \n%f\nArray C \n%f\n", A, B, C);

    // Holds the resulted eigen values and vectors
    array double eigenValues[3],eigenVectors[3][3];


    // Compute Eigen Values for matrix A
    eigensystem(eigenValues, eigenVectors, A);
    printf("Eigen Values for marix A = %f\nEigen Vectors for marix A = %f\n", 
                           eigenValues, eigenVectors);
                           
    // Compute Eigen Values for matrix B
    eigensystem(eigenValues, eigenVectors, B);
    printf("Eigen Values for marix B = %f\nEigen Vectors for marix B = %f\n", 
                           eigenValues, eigenVectors);

    // Compute Eigen Values for matrix C
    eigensystem(eigenValues, eigenVectors, C); 
    printf("Eigen Values for marix C = %f\nEigen Vectors for marix C = %f\n", 
                           eigenValues, eigenVectors);
}