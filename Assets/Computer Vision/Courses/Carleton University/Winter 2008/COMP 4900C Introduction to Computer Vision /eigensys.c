#include <numeric.h>
#define N 5

int main() {
array double a[5][5] = {2,      30,    100,  1000, 10000,
                        0.3,    1,     10,   100,  1000,
                        0.04,   0.1,   1,    10,   100,
                        0.001,  0.01,  0.1,  1,    10,
                        0.0002, 0.003, 0.01, 0.1,  1};
     array double evalues[N];
     array double evectors[N][N];
     array double *v, vv[N][N];
     int i, status;

     eigensystem(evalues, evectors, a);
     printf("eigennvalues of a =\n%e\n", evalues);
     printf("eigenvectors of a =\n%e\n", evectors);

     vv = transpose(evectors);
       for(i=0; i<N; i++) {
          v = (array double [:])(double [N])&vv[i][0];
          printf("V %e\n", v);
          printf("A*v-evalues[i]*v = %f\n", a*v-evalues[i]*v);
       }
       
     eigensystem(a, evalues, evectors, "nobalance");
     printf("no balance: eigennvalues of a =\n%e\n", evalues);
     printf("no balance: eigenvectors of a =\n%e\n", evectors);

     vv = transpose(evectors);
       for(i=0; i<N; i++) {
          v = (array double [:])(double [N])&vv[i][0];
          printf("V %e\n", v);
          printf("A*v-evalues[i]*v = %f\n", a*v-evalues[i]*v);
       }

}
