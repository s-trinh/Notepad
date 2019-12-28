#include <stdio.h>
#include <numeric.h>

int main() {

    /* data consists of ten points in two dimensional space */
    array double data[2][10] = {{2.5,0.5,2.2,1.9,3.1,2.3,2.0,1.0,1.5,1.1},
                                {2.4,0.7,2.9,2.2,3.0,2.7,1.6,1.1,1.6,0.9}};
    array double mymean[2];
    array double mean_comp[2][10];
    array double covar[2][2], manual_covar[2][2];
    array double projection[2][10];
    array double projection2[10][2];
    array double recon[2][10];
    array double evalues[2], evectors[2][2];
    int i;

    /* computes mean of the data and put the result in mymean */
    mean(data, mymean);
    printf("mean  =\n%f\n", mymean);

    /* this subtracts the mean from the original data */
    mean_comp = data;
    for (i = 0; i < 10; i++) {
        mean_comp[0][i] = mean_comp[0][i] - mymean[0];
        mean_comp[1][i] = mean_comp[1][i] - mymean[1];
    }

    printf("mean comp  =\n%f\n", mean_comp);

    /* this computes the covariance matrix of data (which is two dimensional) */
    covariance(covar, data);
    printf("covar  =\n%f\n", covar);
    /* just to show how the covariance routine actually works */
    manual_covar = mean_comp * transpose(mean_comp);
    printf("manual covar =\n%f\n", covar);
    /* now we compute eigenvalues and eigenvectors */
    eigensystem(evalues, evectors, covar);

    printf("evalues  =\n%f\n", evalues);
    printf("evectors  =\n%f\n", evectors);

    /* now project the mean adjusted data onto the eigenvectors */
    projection = transpose(evectors) * mean_comp;
    printf("projection  =\n%f\n", projection);
 
    /* projection2 is what I mean by projection in the assignment.
       what I call projection above is what is called final in the tutorial. */
    projection2 = transpose(mean_comp) * evectors;
    printf("projection2  =\n%f\n", projection2);
    
     /* now we can get back the original data by evectors * projection + my_mean */
    recon = evectors * projection;
    for (i = 0; i < 10; i++) {
        recon[0][i] = recon[0][i] + mymean[0]; 
        recon[1][i] = recon[1][i] + mymean[1]; 
    }

    /* recon and data should be identical */
    printf("recon  =\n%f\n", recon);
    printf("data  =\n%f\n", data);
   
        
    return 0;
}

 
