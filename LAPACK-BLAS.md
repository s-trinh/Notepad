### How to
- [How to use the BLAS Libraries](https://www.hoffman2.idre.ucla.edu/blas/)
> BLAS Libraries
>
> There are four different libraries that include the Basic Linear Algebra Subprograms (BLAS) routines:
>
>     BLAS library from the Netlib Repository
>         This library was compiled using the Intel Compiler or other high-performance Fortran compiler that was purchased for the cluster. This library is the simplest one to link to and use.
>     ATLAS library
>         When this library was built, it automatically optimized its performance for whatever system it was built on, in this case, these routines are optimized for the cluster compute nodes.
>     Intel-MKL library
>         The Intel-MKL library includes the BLAS routines. The Intel-MKL library performed very well in our benchmarks.
>     GNU Scientific Library (GSL)
>         GSL includes a C version of the BLAS routines.
>
> For a comparison of these libraries see: BLAS Benchmark.
> Installed Locations
>
> Installed locations:
>
>     The BLAS library from the Netlib Repository is installed in: /u/local/apps/blas/current/
>     The ATLAS library is installed in: /u/local/apps/atlas/current/
>     The Intel-MKL library is installed in: /u/local/compilers/intel/current/current/mkl/
>     The GSL library is installed in: /u/local/apps/gsl/current/
>
> How to run BLAS from a Fortran Program
>
> To compile and link with the BLAS library from the Netlib Repository:
> ```
>     ifort pgm.f -L$BLAS_HOME -lblas
> ```
> To compile and link with the ATLAS library:
> ```
>     ifort pgm.f -L$ATLAS_HOME -lf77blas -latlas
> ```
> To compile and link with the Intel-MKL library please refer to How to Use the Intel-MKL Libraries.
>
>     Replace pgm.f(90) with the name of the file containing your source code
>     Replace pgm with the name of the executable to be created.
>     Set BLAS_HOME to: /u/local/apps/blas/current
>     Set ATLAS_HOME to: /u/local/apps/atlas/current
>
> How to run BLAS from a C program
> How to use a BLAS routine from GSL
>
> In your program include the appropriate GSL header files as follows:
> ```
>     #include <gsl/gsl_blas.h>
> ```
> To compile and link enter:
> ```
>     CC pgm.c -I$GSL_HOME/include -L$GSL_HOME/lib -lgsl -lgslcblas -lm [-static] -o pgm
>
>     Replace CC with either gcc or icc depending on which compiler you want to use.
>     Replace pgm.c with the name of the file containing your source code
>     Replace pgm with the name of the executable to be created
>     Set GSL_HOME to: /u/local/apps/gsl/current
> ```
> If you omit -static, you will have to set the LD_LIBRARY_PATH environment variable at run time to include $GSL_HOME/lib
> How to use a BLAS routine from Netlib, ATLAS or Intel-MKL
>
> To use BLAS from a C program, replace ifort with icc and add an _ to the end of the subroutine name. For example to call sgemm code:
> ```
>     extern void sgemm_( char *, char *, int *, int *, int * float *, float *, int *, float *, int *, float *, float *, int * );
> ```
> If you use gcc instead of icc, you additionally have to add:
> ```
>     -L/usr/lib/gcc/x86_64-redhat-linux/3.4.6 -lg2c
> ```
> to the command used to compile and link.
> How to run BLAS from a C++ program
>
> To use BLAS from a C++ program you must declare each BLAS function you will call as being extern as in the following example:
> ```
>     extern “C” void sgemm_( char *, char *, int *, int *, int * float *, float *, int *, float *, int *, float *, float *, int * );
> ```
> code the function name (with _ appended) and the argument list for the function you are calling.
>
> To compile and link, replace ifort with icpc.

- [https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.cbcpx01/atlasexample1.htm](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.cbcpx01/atlasexample1.htm)

> This simple sample achieves a multiplication of two matrices, A and B. A and B have elements randomly generated with values between 0 and 1. The multiplication is achieved in the following ways:
> 
>     by calling dgemm/cblas_dgemm BLAS functionality provided by ATLAS
>     by a manual calculation of the same
> 
> The resulting matrices C and D will contain the same elements.
> Sample output produced by all executables across all platforms and architectures should look like this:
> ```
> Matrix A has 3 rows and 6 columns:
> 0.566 0.974 0.202 0.941 0.294 0.427
> 0.580 0.539 0.772 0.248 0.832 0.848
> 0.080 0.533 0.434 0.163 0.576 0.416
> 
> Matrix B has 6 rows and 4 columns:
> 0.309 0.316 0.569 0.182
> 0.725 0.389 0.472 0.649
> 0.448 0.368 0.354 0.665
> 0.994 0.740 0.649 0.616
> 0.133 0.906 0.447 0.590
> 0.773 0.774 0.893 0.913
> 
> Matrix C has 3 rows and 4 columns:
> 2.276 1.926 1.978 2.013
> 1.928 2.270 2.148 2.387
> 1.165 1.356 1.185 1.469
> 
> Matrix D has 3 rows and 4 columns:
> 2.276 1.926 1.978 2.013
> 1.928 2.270 2.148 2.387
> 1.165 1.356 1.185 1.469
> ```
> Pay attention to the fact that matrices C and D are congruent.
> 
> Also note that matrix data is organized or ordered in the Fortran way, namely columns major.
> Sample 1
> 
> This program contains a C invocation of the Fortran BLAS function dgemm_ provided by the ATLAS framework.
> Observation: In this sample, the invocation of dgemm_ has no previously declared prototype, hence the compiler might issue a warning message. Prototypes may be declared by including the atlas_f77 header files, but source files might not have these header files specified (i.e. old source code written prior to ATLAS).
> Source code:
>  ```
>  #include <stdio.h>
>  #include <time.h>
>  #include <stdlib.h>
> 
>  void init(double* matrix, int row, int column)
>  {
>    for (int j = 0; j < column; j++){
>      for (int i = 0; i < row; i++){
>        matrix[j*row + i] = ((double)rand())/RAND_MAX;
>      }
>    }
>  }
>  
>  void print(const char * name, const double* matrix, int row, int column)
>  {
>    printf("Matrix %s has %d rows and %d columns:\n", name, row, column);
>    for (int i = 0; i < row; i++){
>      for (int j = 0; j < column; j++){
>        printf("%.3f ", matrix[j*row + i]);
>      }
>      printf("\n");
>    }
>    printf("\n");
>  }
>  
>  int main(int argc, char * argv[])
>  {
>    int rowsA, colsB, common;
>    int i,j,k;
>  
>    if (argc != 4){
>      printf("Using defaults\n");
>      rowsA = 2; colsB = 4; common = 6;
>    }
>    else{
>      rowsA = atoi(argv[1]); colsB = atoi(argv[2]);common = atoi(argv[3]);
>    }
>  
>    double A[rowsA * common]; double B[common * colsB];
>    double C[rowsA * colsB]; double D[rowsA * colsB];
>  
>    char transA = 'N', transB = 'N';
>    double one = 1.0, zero = 0.0;
>  
>    srand(time(NULL));
>  
>    init(A, rowsA, common); init(B, common, colsB);
>  
>    dgemm_(&transA, &transB, &rowsA, &colsB, &common, &one, A, 
>           &rowsA, B, &common, &zero, C, &rowsA);
>  
>    for(i=0;i<colsB;i++){
>      for(j=0;j<rowsA;j++){
>        D[i*rowsA+j]=0;
>        for(k=0;k<common;k++){
>          D[i*rowsA+j]+=A[k*rowsA+j]*B[k+common*i];
>        }
>      }
>    }
>  
>    print("A", A, rowsA, common); print("B", B, common, colsB);
>    print("C", C, rowsA, colsB); print("D", D, rowsA, colsB);
>  
>    return 0;
>  }
> ```
> To compile the program for ARCH(10):
> ```
> xlc -c -qfloat=ieee -qround=n -qarch=10 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.c
> ```
> To compile the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlc -c -qfloat=ieee -qround=n -qarch=11 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.c
> ```
> To link the program for ARCH(10):
> ```
> xlc sample.o -L /usr/lpp/cbclib/lib/atlas -lf77blas.arch10 
> -latlas.arch10 -lf2c.arch10 -qfloat=ieee -o sample
> ```
> To link the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlc sample.o -L /usr/lpp/cbclib/lib/atlas -lf77blas.arch11 
> -latlas.arch11 -lf2c.arch11 -qfloat=ieee -o sample
> ```
> Sample 2
> 
> This program contains a C++ invocation of the Fortran BLAS function dgemm_ provided by the ATLAS framework.
> Observation: As opposed to sample 1, the compiler must be explicitly instructed that the function dgemm_ has C linkage and thus no mangling should be attempted. This can be achieved either as specified, or by including the appropriate header file with the extern "C" designation.
> Source code:
> ```
>  #include <stdio.h>
>  #include <time.h>
>  #include <stdlib.h>
>  
>  extern "C"
>  {
>    int dgemm_(char *, char *, int *, int *, int *, double *, double *, int *, 
>               double *, int *, double *, double *, int *);
>  }
>  
>  
>  void init(double* matrix, int row, int column)
>  {
>    for (int j = 0; j < column; j++){
>      for (int i = 0; i < row; i++){
>        matrix[j*row + i] = ((double)rand())/RAND_MAX;
>      }
>    }
>  }
>  
>  void print(const char * name, const double* matrix, int row, int column)
>  {
>    printf("Matrix %s has %d rows and %d columns:\n", name, row, column);
>    for (int i = 0; i < row; i++){
>      for (int j = 0; j < column; j++){
>        printf("%.3f ", matrix[j*row + i]);
>      }
>      printf("\n");
>    }
>    printf("\n");
>  }
>  
>  int main(int argc, char * argv[])
>  {
>    int rowsA, colsB, common;
>    int i,j,k;
>  
>    if (argc != 4){
>      printf("Using defaults\n");
>      rowsA = 2; colsB = 4; common = 6;
>    }
>    else{
>      rowsA = atoi(argv[1]); colsB = atoi(argv[2]);common = atoi(argv[3]);
>    }
>  
>    double A[rowsA * common]; double B[common * colsB];
>    double C[rowsA * colsB]; double D[rowsA * colsB];
>  
>    char transA = 'N', transB = 'N';
>    double one = 1.0, zero = 0.0;
>  
>    srand(time(NULL));
>  
>    init(A, rowsA, common); init(B, common, colsB);
>  
>    dgemm_(&transA, &transB, &rowsA, &colsB, &common, &one, A, 
>           &rowsA, B, &common, &zero, C, &rowsA);
>  
>    for(i=0;i<colsB;i++){
>      for(j=0;j<rowsA;j++){
>        D[i*rowsA+j]=0;
>        for(k=0;k<common;k++){
>          D[i*rowsA+j]+=A[k*rowsA+j]*B[k+common*i];
>        }
>      }
>    }
>  
>    print("A", A, rowsA, common); print("B", B, common, colsB);
>    print("C", C, rowsA, colsB); print("D", D, rowsA, colsB);
>  
>    return 0;
>  }
> ```
> To compile the program for ARCH(10):
> ```
> xlC -c -qfloat=ieee -qround=n -qarch=10 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.C
> ```
> To compile the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlC -c -qfloat=ieee -qround=n -qarch=11 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.C
> ```
> To link the program for ARCH(10):
> ```
> xlC sample.o -L /usr/lpp/cbclib/lib/atlas -lf77blas.arch10 
> -latlas.arch10 -lf2c.arch10 -qfloat=ieee -o sample
> ```
> To link the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlC sample.o -L /usr/lpp/cbclib/lib/atlas -lf77blas.arch11 
> -latlas.arch11 -lf2c.arch11 -qfloat=ieee -o sample
> ```
> Sample 3
> 
> This program contains a C invocation of the CBLAS function cblas_dgemm_ provided by the ATLAS framework.
> Observation: Same result and functionality as if dgemm_ would be called, but this program uses the CBLAS version of the functions.
> Source code:
> ```
>  #include <time.h>
>  #include <stdlib.h>
>  #include <cblas.h>
>  
>  void init(double* matrix, int row, int column)
>  {
>    for (int j = 0; j < column; j++){
>      for (int i = 0; i < row; i++){
>        matrix[j*row + i] = ((double)rand())/RAND_MAX;
>      }
>    }
>  }
>  
>  void print(const char * name, const double* matrix, int row, int column)
>  {
>    printf("Matrix %s has %d rows and %d columns:\n", name, row, column);
>    for (int i = 0; i < row; i++){
>     for (int j = 0; j < column; j++){
>        printf("%.3f ", matrix[j*row + i]);
>      }
>      printf("\n");
>    }
>    printf("\n");
>  }
>  
>  int main(int argc, char * argv[])
>  {
>    int rowsA, colsB, common;
>    int i,j,k;
>  
>    if (argc != 4){
>      printf("Using defaults\n");
>      rowsA = 2; colsB = 4; common = 6;
>    }
>    else{
>      rowsA = atoi(argv[1]); colsB = atoi(argv[2]);common = atoi(argv[3]);
>    }
>  
>    double A[rowsA * common]; double B[common * colsB];
>    double C[rowsA * colsB]; double D[rowsA * colsB];
>  
>    enum CBLAS_ORDER order = CblasColMajor;
>    enum CBLAS_TRANSPOSE transA = CblasNoTrans;
>    enum CBLAS_TRANSPOSE transB = CblasNoTrans;
>  
>    double one = 1.0, zero = 0.0;
>  
>    srand(time(NULL));
>  
>    init(A, rowsA, common); init(B, common, colsB);
>  
>    cblas_dgemm(order,transA,transB, rowsA, colsB, common ,1.0,A, 
>                rowsA ,B, common ,0.0,C, rowsA);
>  
>    for(i=0;i<colsB;i++){
>      for(j=0;j<rowsA;j++){
>        D[i*rowsA+j]=0;
>        for(k=0;k<common;k++){
>          D[i*rowsA+j]+=A[k*rowsA+j]*B[k+common*i];
>        }
>      }
>    }
>  
>    print("A", A, rowsA, common); print("B", B, common, colsB);
>    print("C", C, rowsA, colsB); print("D", D, rowsA, colsB);
>  
>    return 0;
>  }
> ```
> To compile the program for ARCH(10):
> ```
> xlc -c -qfloat=ieee -qround=n -qarch=10 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.c
> ```
> To compile the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlc -c -qfloat=ieee -qround=n -qarch=11 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.c
> ```
> To link the program for ARCH(10):
> ```
> xlc sample.o -L /usr/lpp/cbclib/lib/atlas -lcblas.arch10 
> -latlas.arch10 -qfloat=ieee -o sample
> ```
> To link the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlc sample.o -L /usr/lpp/cbclib/lib/atlas -lcblas.arch11 
> -latlas.arch11 -qfloat=ieee -o sample
> ```
> Sample 4
> 
> This program contains a C++ invocation of the CBLAS function cblas_dgemm_ provided by the ATLAS framework.
> Observation: Same result and functionality as if dgemm_ would be called, but this program uses the CBLAS version of the functions.
> Source code:
> ```
>  #include <time.h>
>  #include <stdlib.h>
>  
>  extern "C"
>  {
>  #include <cblas.h>
>  }
>  
>  void init(double* matrix, int row, int column)
>  {
>    for (int j = 0; j < column; j++){
>      for (int i = 0; i < row; i++){
>        matrix[j*row + i] = ((double)rand())/RAND_MAX;
>      }
>    }
>  }
>  
>  void print(const char * name, const double* matrix, int row, int column)
>  {
>    printf("Matrix %s has %d rows and %d columns:\n", name, row, column);
>    for (int i = 0; i < row; i++){
>      for (int j = 0; j < column; j++){
>        printf("%.3f ", matrix[j*row + i]);
>      }
>      printf("\n");
>    }
>    printf("\n");
>  }
>  
>  int main(int argc, char * argv[])
>  {
>    int rowsA, colsB, common;
>    int i,j,k;
>  
>    if (argc != 4){
>      printf("Using defaults\n");
>      rowsA = 2; colsB = 4; common = 6;
>    }
>    else{
>      rowsA = atoi(argv[1]); colsB = atoi(argv[2]);common = atoi(argv[3]);
>    }
>  
>    double A[rowsA * common]; double B[common * colsB];
>    double C[rowsA * colsB]; double D[rowsA * colsB];
>  
>    enum CBLAS_ORDER order = CblasColMajor;
>    enum CBLAS_TRANSPOSE transA = CblasNoTrans;
>    enum CBLAS_TRANSPOSE transB = CblasNoTrans;
>  
>    double one = 1.0, zero = 0.0;
>  
>    srand(time(NULL));
>  
>    init(A, rowsA, common); init(B, common, colsB);
>  
>    cblas_dgemm(order,transA,transB, rowsA, colsB, common ,1.0,A, 
>                rowsA ,B, common ,0.0,C, rowsA);
>  
>    for(i=0;i<colsB;i++){
>      for(j=0;j<rowsA;j++){
>        D[i*rowsA+j]=0;
>        for(k=0;k<common;k++){
>          D[i*rowsA+j]+=A[k*rowsA+j]*B[k+common*i];
>        }
>      }
>    }
>  
>    print("A", A, rowsA, common); print("B", B, common, colsB);
>    print("C", C, rowsA, colsB); print("D", D, rowsA, colsB);
>  
>    return 0;
>  }
> ```
> To compile the program for ARCH(10):
> ```
> xlC -c -qfloat=ieee -qround=n -qarch=10 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.C
> ```
> To compile the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlC -c -qfloat=ieee -qround=n -qarch=11 -qtarget=zosv2r1 -I 
> /usr/lpp/cbclib/include/atlas -qfloat=ieee -o sample.o sample.C
> ```
> To link the program for ARCH(10):
> ```
> xlC sample.o -L /usr/lpp/cbclib/lib/atlas -lcblas.arch10 
> -latlas.arch10 -qfloat=ieee -o sample
> ```
> To link the program for ARCH(11) and higher ARCHITECTURE levels:
> ```
> xlC sample.o -L /usr/lpp/cbclib/lib/atlas -lcblas.arch11 
> -latlas.arch11 -qfloat=ieee -o sample
> ```

- [Using BLAS from C with row major data](https://www.christophlassner.de/using-blas-from-c-with-row-major-data.html)
- [Using BLAS and LAPACK from C/C++ ](http://nicolas.limare.net/pro/notes/2014/10/31_cblas_clapack_lapacke/)
> How can we call the BLAS and LAPACK libraries from a C code without being tied to an implementation? For BLAS, there is CBLAS, a native C interface. For LAPACK, the native C interface is LAPACKE, not CLAPACK. If you don't have LAPACKE, use extern Fortran declarations.
> 
> BLAS and LAPACK
> 
> The reference Fortran code for BLAS and LAPACK defines de facto a Fortran API, implemented by multiple vendors with code tuned to get the best performance on a given hardware.
> 
> In fact, since libraries are often distributed in binary form (think Linux distro packages for example), BLAS and LAPACK could be written in any language as long as that a Fortran code calling a BLAS or LAPACK subroutine with the syntax used on Netlib can compile and link with the library and the resulting executable produces the same result the Netlib code.
> 
> Well, I have not touched Fortran for years bus as long as I remember Fortran binary interface (ABI) is not standardized. An object file produced by a compiler may not be usable by another compiler (cf g95 vs. gfortran vs. ifort). But let's just suppose here that we are only working with one compiler with a well defined ABI. So, if we know the binary calling convention for a Fortran function, the the Fortran API also defines an ABI.
> 
> On the C side, the C ABI is standardized: from a source-level function definition, we know how the binary-level call will happen. Moreover, there is a C type matching every Fortran scalar type used in BLAS and LAPACK. As a result, the Fortran source API for BLAS/LAPACK plus assumptions about the Fortran compiler result in a C source API for BLAS/LAPACK.
> 
> For example, we can access the BLAS dgemm and LAPACK dgesv subroutines ...
> ```
> SUBROUTINE dgemm(TRANSA, TRANSB, M, N, K, ALPHA, A, LDA, B, LDB, BETA, C, LDC)
> DOUBLE PRECISION alpha,beta
> INTEGER k,lda,ldb,ldc,m,n
> CHARACTER transa,transb
> DOUBLE PRECISION a(lda,*),b(ldb,*),c(ldc,*)
> 
> SUBROUTINE dgesv(N, NRHS, A, LDA, IPIV, B, LDB, INFO)
> INTEGER info, lda, ldb, n, nrhs
> INTEGER ipiv(*)
> DOUBLE PRECISION a(lda, *), b(ldb, *)
> 
> ... as the external C functions dgemm_ and dgesv_ ...
> 
> extern dgemm_(char * transa, char * transb, int * m, int * n, int * k,
>           double * alpha, double * A, int * lda,
>           double * B, int * ldb, double * beta,
>           double *, int * ldc);
> 
> extern dgesv_(int * n, int * nrhs, double * A, int * lda,
>           int * ipiv, double * B, int * ldb, int * info);
> ```
> ... and this stands for any BLAS/LAPACK subroutine.
> 
> Note that since this Fortran API to C ABI is compiler-dependent, no BLAS library provides a lapack.h header with all these extern declarations. You have to do it yourself, and trust the compilers for long term validity. Or you may prefer a truly portable, standard interface.
> CBLAS
> 
> This interface exists for BLAS, it's called CBLAS. Following on the dgemm example, we now have this new C API/ABI:
> ```
> void cblas_dgemm(const enum CBLAS_ORDER Order,
>              const enum CBLAS_TRANSPOSE TransA,
>              const enum CBLAS_TRANSPOSE TransB,
>              const int M, const int N, const int K,
>              const double alpha, const double  *A, const int lda,
>              const double *B, const int ldb, const double beta,
>              double *C, const int ldc)
> ```
> CBLAS is in fact just a very thin layer (no performance penalty) over BLAS, with these benefits:
> 
> standard and simple, implemented by every BLAS library;
> compiler-independent;
> scalars passed by value, arrays by pointers;
> const to protect read-only parameters;
> enum and macros instead of characters with "magic values";
> Order parameter to use row-major or column-major arrays without juggling with transpositions.
> 
> If you use BLAS from a C code, there is no reason to use the Fortran interface directly. Just #include <cblas.h> (provided with every BLAS library) and link with your preferred BLAS.
> CLAPACK?
> 
> There also is something on Netlib called CLAPACK, but it is not a standard C interface to the Fortran LAPACK. CLAPACK is a translation of the Fortran LAPACK code into C.
> 
> Still on the dgesv example, now in CLAPACK it is defined as ...
> ```
> int dgesv_(integer *n, integer *nrhs, doublereal *a,
>        integer *lda, integer *ipiv, doublereal *b,
>        integer *ldb, integer *info);
> ```
> ... with integer and doublereal typedef'd as int and double somewhere else. Based on 100% C code, this interface is compiler-independent. But that's all you can get: it is not implemented by other vendors and does not provide any of the other benefits of a native C interface like CBLAS does.
> 
> Finally, CLAPACK is mentioned as "no longer maintained" on Netlib, so let's just avoid this trap.
> 
> There is also something called clapack.h in ATLAS, with functions like ...
> ```
> int clapack_dgesv(const enum CBLAS_ORDER Order,
>               const int N, const int NRHS,
>               void *A, const int lda, int *ipiv,
>               void *B, const int ldb);
> ```
> This something else, a C interface provided by ATLAS for some of the LAPACK routines in ATLAS, entirely different from Netlib CLAPACK. And ATLAS doesn't provide every LAPACK subroutine. So it's time to conclude on the absence of anything standard and portable called CLAPACK. As written by Clint Whaley (author of ATLAS), "there has been no official standardization of a C interface to LAPACK ... your best bet is to call the Fortran77 interface".
> 
> Well that was sadly true until ...
> LAPACKE
> 
> Here it is. LAPACKE is relatively recent (proposed in 2008, accepted in 2010) but it's the closest we have to a native C source-level interface to the original Fortran API. LAPACKE is to LAPACK what CBLAS is to BLAS, with this interface:
> ```
> lapack_int LAPACKE_dgesv(int matrix_order, lapack_int n, lapack_int nrhs,
>                      double * a, lapack_int lda, lapack_int * ipiv,
>                      double * b, lapack_int ldb);
> ```
> This one is standardized, as mentioned on Netlib: "Standard C language APIs for LAPACK". Moreover, as LAPACKE is a thin layer over LAPACK, which itself calls BLAS to perform the real expensive computations, I think that it is possible to use the liblapacke.so library from Netlib with any LAPACK and BLAS back-end. Everything you need to the good linking options, in the correct order. Finally, LAPACKE is also included in the MKL package.
> All Together
> 
> The BLAS case is clear: we must use the CBLAS interface, available with every BLAS library. For LAPACK, we should use LAPACKE if we have it. If not, we could either use the LAPACKE layer from Netlib, and possibly the LAPACK layer too, over our preferred BLAS library, or directly link to the Fortran interface if we know the compiler ABI.
> 
> For reference, here is the list of Fortran and C interfaces available (ignoring unmaintained CLAPACK) in major BLAS/LAPACK implementations, with the package, shared library and C header names in Debian 8.0 Jessie:
> - Netlib (pkg libblas-dev, liblapack-dev, liblapacke-dev)
> ```
> BLAS (/usr/lib/libblas/libblas.so),
> CBLAS (/usr/lib/libblas/libblas.so, /usr/include/cblas.h)
> LAPACK (/usr/lib/lapack/liblapack.so)
> LAPACKE (/usr/lib/liblapacke.so, /usr/include/lapacke.h)
> ```
> - Atlas (pkg libatlas-dev)
> ```
> BLAS (/usr/lib/atlas-base/libf77blas.so)
> CBLAS (/usr/lib/atlas-base/libcblas.so, /usr/include/atlas/cblas.h)
> LAPACK (/usr/lib/atlas-base/liblapack_atlas.so, incomplete)
> ```
> - OpenBLAS (pkg libopenblas-dev)
> ```
> BLAS (/usr/lib/openblas-base/libblas.so)
> CBLAS (/usr/lib/openblas-base/libblas.so, /usr/include/openblas/cblas.h)
> LAPACK (/usr/lib/openblas-base/liblapack.so)
> ```
> - GSL (pkg libgsl0-dev)
> ```
> CBLAS (/usr/lib/libgslcblas.so, /usr/include/gsl/gsl_cblas.h)
> ```
> - MKL
> ```
> BLAS ($MKLROOT/lib/intel64/libmkl_<C>_<P>.so)
> CBLAS, ($MKLROOT/lib/intel64/libmkl_<C>_<P>.so, $MKLROOT/include/mkl_cblas.h)
> LAPACK ($MKLROOT/lib/intel64/libmkl_<C>_<P>.so)
> LAPACKE ($MKLROOT/lib/intel64/libmkl_<C>_<P>.so, $MKLROOT/include/mkl_lapacke.h)
> ```
> ```
> <C> is the compiler ABI (gf for GFortran and intel for IFort) and <P> is the 64-bit model, lp64 or ilp64.
> ```

- [How to start using LAPACK in c++?](https://scicomp.stackexchange.com/questions/26395/how-to-start-using-lapack-in-c/26406#26406)
