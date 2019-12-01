## Python
- [Cheat Sheet: Writing Python 2-3 compatible code](http://python-future.org/compatible_idioms.html)

## SIMD
- [Marat Dukhan](https://www.cc.gatech.edu/grads/m/mdukhan3/)
- [avx2 convolution pipeline utilization #477](https://github.com/intel/mkl-dnn/issues/477#issuecomment-493591765):
> In x86 CPUs a number of physical registers is more than architectural one. It means that during the execution of code above, the architectural register ymm15 will be mapped on different physical registers to resolve dependencies.
- [SSE and AVX intrinsics mixture](https://stackoverflow.com/questions/18319488/sse-and-avx-intrinsics-mixture)
- [Using AVX CPU instructions: Poor performance without “/arch:AVX”](https://stackoverflow.com/questions/7839925/using-avx-cpu-instructions-poor-performance-without-archavx)
- [VEX prefixes encoding and SSE/AVX MOVUP(D/S) instructions](https://stackoverflow.com/questions/51773399/vex-prefixes-encoding-and-sse-avx-movupd-s-instructions)
- [What is the penalty of mixing EVEX and VEX encoded scheme?](https://stackoverflow.com/questions/46080327/what-is-the-penalty-of-mixing-evex-and-vex-encoded-scheme)
- [Does compiler use SSE instructions for a regular C code?](https://stackoverflow.com/questions/50786263/does-compiler-use-sse-instructions-for-a-regular-c-code)
- [https://godbolt.org/z/ALvKsT](https://godbolt.org/z/ALvKsT)
- [SSE & AVX usage](https://www.codingame.com/playgrounds/283/sse-avx-vectorization/sse-and-avx-usage)
- [The significance of SIMD, SSE and AVX - Stephen Blair-Chappell - Intel Compiler Lab](https://www.polyhedron.com/web_images/intel/productbriefs/3a_SIMD.pdf)

## Libraries
- [UME::SIMD A library for explicit simd vectorization](https://github.com/edanor/umesimd)
- [Vectorization EDSL library](https://github.com/edanor/umevector)
- [AsmJit - Complete x86/x64 JIT and Remote Assembler for C++](https://github.com/asmjit/asmjit)
- [Asmf - just-in-time assembler](https://gitlab.com/asmf/asmf)
- [JITCS - Just-In-Time-Compiler-System](https://repo.or.cz/jitcs.git)
- [MyIntrinsics++ (MIPP)](https://github.com/aff3ct/MIPP)
- [VOLK - The Vector Optimized Library of Kernels](https://github.com/gnuradio/volk) ([http://libvolk.org/](http://libvolk.org/))
- [tsimd - Fundamental C++ SIMD types for Intel CPUs (sse to avx512)](https://github.com/ospray/tsimd) ([OSPRay](http://www.ospray.org/))
- [xsimd - C++ wrappers for SIMD intrinsics](https://github.com/xtensor-stack/xsimd)
- [VMMLib - A templatized C++ vector and matrix math library](https://github.com/Eyescale/vmmlib)
 
## GCC
- [Auto-vectorization in GCC](https://www.gnu.org/software/gcc/projects/tree-ssa/vectorization.html)

## Compilers
- [Calibrating your fear of big bad optimizing compilers](https://lwn.net/Articles/799218/)

## Papers
- [Loopy: Programmable and Formally Verified Loop Transformations, Kedar S. Namjoshi, Nimit Singhania, Published in SAS 2016, https://doi.org/10.1007/978-3-662-53413-7_19](https://www.semanticscholar.org/paper/Loopy%3A-Programmable-and-Formally-Verified-Loop-Namjoshi-Singhania/0993b6b0bf7256922439771fdad2b4c2c7256b19) ([pdf](https://www.seas.upenn.edu/~nimits/papers/sas16.pdf))
- [Parallelization and characterization of SIFT on multi-core systems, Hao Feng, Eric Q. Li, Yurong Chen, Yimin Zhang, IEEE International Symposium on Workload Characterization (2008), https://doi.org/10.1109/iiswc.2008.4636087](https://www.semanticscholar.org/paper/Parallelization-and-characterization-of-SIFT-on-Feng-Li/6d6befc93dca5d5b2b4b949990608a83d3296432)

## Presentations
- [Parallelization and Characterization of SIFT on Multi-Core Systems, Hao Feng, Eric Li, Yurong Chen, Yimin Zhang](http://www.iiswc.org/iiswc2008/sildes/1-2.pdf)

## C++
- [C++ 11: Move Semantics, Sandy Engelhardt, MITK BugsquashingSeminar, March 2016](http://mitk.org/images/c/ca/MoveConstructor.pdf)
- [Conditions for automatic generation of default/copy/move ctor and copy/move assignment operator?](https://stackoverflow.com/questions/4943958/conditions-for-automatic-generation-of-default-copy-move-ctor-and-copy-move-assi)
- [10.7 — std::initializer_list](https://www.learncpp.com/cpp-tutorial/10-7-stdinitializer_list/)
- [Initialization in C++ is bonkers](https://blog.tartanllama.xyz/initialization-is-bonkers/)
- [You may use braced initializer lists](https://www.jarchitect.com/QACenter/index.php?qa=77&qa_1=you-may-use-braced-initializer-lists)

## Articles / Blogs
- [Adventures in JIT compilation: Part 2 - an x64 JIT, Eli Bendersky](https://eli.thegreenplace.net/2017/adventures-in-jit-compilation-part-2-an-x64-jit/)
- [SIMD approaches in C++ – comparison](https://gain-performance.com/2017/10/22/simd-approaches-in-c-comparison/)
- [https://attractivechaos.wordpress.com/](https://attractivechaos.wordpress.com/)
- [Memory Dump In Cloud](http://oliveryang.net/)
- [Performance explained easy](https://easyperf.net/)
- [Daniel Lemire's blog](https://lemire.me/blog/)
- [Performance Matters](https://travisdowns.github.io/)
- [SHORTJUMP! Reversing engineering, programming and what not…](http://0xeb.net/)
- [Inverting Binary Trees Considered Harmful](https://web.archive.org/web/20190220134908/http://www.jasq.org/just-another-scala-quant/inverting-binary-trees-considered-harmful)
- [Nicholas Frechette's Blog - Raw bits](https://nfrechette.github.io/)
- [Destroying x86_64 instruction decoders with differential fuzzing](https://blog.trailofbits.com/2019/10/31/destroying-x86_64-instruction-decoders-with-differential-fuzzing/)
- [C++ links - A categorized list of C++ resources.](https://github.com/MattPD/cpplinks)
- [Pavel Zemtsov - Experiments in program optimisation](https://pzemtsov.github.io/)
- [Speeding-up algorithms with SSE](https://shybovycha.github.io/2017/02/21/speeding-up-algorithms-with-sse.html) ([https://shybovycha.github.io/](https://shybovycha.github.io/))

## Floating-point representation
- [Sample single precision floating-point values for IEEE 754 arithmetic](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0475g/BABFGDBH.html)
- [`std::fixed`](https://en.cppreference.com/w/cpp/io/manip/fixed)
- [Convert Double to Hex String?](https://stackoverflow.com/questions/22668797/convert-double-to-hex-string)
- [C/C++ Initialise double with hex](https://stackoverflow.com/questions/25923238/c-c-initialise-double-with-hex)
- [Negative infinity](https://stackoverflow.com/questions/20016600/negative-infinity)
- [In which order should floats be added to get the most precise result?](https://stackoverflow.com/questions/6699066/in-which-order-should-floats-be-added-to-get-the-most-precise-result)
- [Kahan summation algorithm](https://en.wikipedia.org/wiki/Kahan_summation_algorithm)

## Cache analysis / Memory Cache
- [C++ Performacne analysis of tiled matrix multiplication with valgrind](https://stackoverflow.com/questions/26892504/c-performacne-analysis-of-tiled-matrix-multiplication-with-valgrind)
- [What Every Programmer Should Know About Memory?](https://stackoverflow.com/questions/8126311/what-every-programmer-should-know-about-memory/47714514#47714514)
- [How can cache be that fast?](https://electronics.stackexchange.com/questions/329789/how-can-cache-be-that-fast/329955#329955)
- [Intel’s Sandy Bridge Microarchitecture - Memory Subsystem](https://www.realworldtech.com/sandy-bridge/7/)
- [Analysis of Haswell’s Transactional Memory](https://www.realworldtech.com/haswell-tm/)
- [Effect of cache misses on time of matrix multiplication](https://stackoverflow.com/questions/41452781/effect-of-cache-misses-on-time-of-matrix-multiplication)
- [Linux C++: how to profile time wasted due to cache misses?](https://stackoverflow.com/questions/2486840/linux-c-how-to-profile-time-wasted-due-to-cache-misses)
- [Cache Oblivious Algorithms, Piyush Kumar](https://www.csd.uoc.gr/~hy460/pdf/AMH/9.pdf) ([Algorithms for Memory Hierarchies, Ulrich Meyer, Peter Sanders, Jop Sibeyn](https://link.springer.com/book/10.1007/3-540-36574-5))
- [Memory, Cache, CPU optimization resources.md](https://gist.github.com/ocornut/cb980ea183e848685a36)
- [Physics Optimization Strategies (Sergiy Migdalskiy, Valve, GDC 2015)](http://media.steampowered.com/apps/valve/2015/Migdalskiy_Sergiy_Physics_Optimization_Strategies.pdf)
- [CPU Caches and Why You Care, Scott Meyers](https://www.aristeia.com/TalkNotes/ACCU2011_CPUCaches.pdf)
- [Relation between cache line and memory page](https://softwareengineering.stackexchange.com/questions/270192/relation-between-cache-line-and-memory-page)
- [Cache Management](https://www.cs.umd.edu/users/meesh/411/website/projects/outer/hoc/manage.htm)
- [How to get the size of CPU Cache in Linux](https://stackoverflow.com/questions/30207256/how-to-get-the-size-of-cpu-cache-in-linux)
- Courses:
  - [CS 201 - Writing Cache-Friendly Code, Gerson Robboy - Portland State University](http://web.cecs.pdx.edu/~jrb/cs201/lectures/cache.friendly.code.pdf) ([lectures](http://web.cecs.pdx.edu/~jrb/cs201/lectures/))
  - [Reducing Cache Miss Penalty - Multilevel caches, critical work first, reads priority over writes, merging write buffer](http://www.taoli.ece.ufl.edu/teaching/fall06/private/lectures/eel5764-lec05-part3.pdf)
  - [COMP303 - ComputerArchitecture - Lecture15 - Calculating and Improving Cache Performance](http://home.ku.edu.tr/comp303/public_html/Lecture15.pdf)
  - [Cache Associativity](http://csillustrated.berkeley.edu/PDFs/handouts/cache-3-associativity-handout.pdf)

## Matrix transpose
- [An Efficient Matrix Transpose in CUDA C/C++](https://devblogs.nvidia.com/efficient-matrix-transpose-cuda-cc/)
- [Why is transposing a matrix of 512x512 much slower than transposing a matrix of 513x513?](https://stackoverflow.com/questions/11413855/why-is-transposing-a-matrix-of-512x512-much-slower-than-transposing-a-matrix-of)
- [What is the fastest way to transpose a matrix in C++?](https://stackoverflow.com/questions/16737298/what-is-the-fastest-way-to-transpose-a-matrix-in-c)
- [Cache Oblivious Matrix Transposition Implementation in C++](https://stackoverflow.com/questions/47554044/cache-oblivious-matrix-transposition-implementation-in-c)
- [A Cache Efficient Matrix Transpose Program?](https://stackoverflow.com/questions/5200338/a-cache-efficient-matrix-transpose-program)
- [A better 8x8 bytes matrix transpose with SSE?](https://stackoverflow.com/questions/42162270/a-better-8x8-bytes-matrix-transpose-with-sse)
- [How to transpose a 16x16 matrix using SIMD instructions?](https://stackoverflow.com/questions/29519222/how-to-transpose-a-16x16-matrix-using-simd-instructions)
- [How to transpose a 16×16 byte matrix using SSE](https://pzemtsov.github.io/2014/10/01/how-to-transpose-a-16x16-matrix.html)
- [Bug story 2: Unrolling the 16×16 matrix transposition, or be careful with macros](https://pzemtsov.github.io/2014/10/21/bug-story-2-unrolling-16x16-transposition.html)

## BLAS
- [Examples - Compiling, linking, and running a simple matrix multiplication ATLAS program (IBM Knowledge Center)](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.cbcpx01/atlasexample1.htm)
- [Getting started with ATLAS, BLAS and LAPACK](https://michaellindon.github.io/lindonslog/programming/atlas-blas-lapack-linear-algebra-libraries/index.html)
- [Using BLAS from C with row major data](https://www.christophlassner.de/using-blas-from-c-with-row-major-data.html)
- [A collection of math tutorials in C](https://github.com/Foadsf/Cmathtuts)
- [Performance experiments with matrix multiplication](https://vorner.github.io/2018/05/12/Mat-perf.html) ([fastmatmult](https://github.com/vorner/fastmatmult))
- [BLISlab: A Sandbox for Optimizing GEMM, Jianyu Huang, Robert A. van de Geijn, Published in ArXiv 2016](https://www.semanticscholar.org/paper/BLISlab%3A-A-Sandbox-for-Optimizing-GEMM-Huang-Geijn/f99b3e370136f13a9e2138db31bebc8b3b69883d)

## Benchmarks
- [CppPerformanceBenchmarks](https://gitlab.com/chriscox/CppPerformanceBenchmarks)
- [Pitfalls of TSC usage](http://oliveryang.net/2015/09/pitfalls-of-TSC-usage/)

## PRNG
- [https://www.random.org/analysis/](https://www.random.org/analysis/)
- [Generating random numbers in C++](https://diego.assencio.com/?index=6890b8c50169ef45b74db135063c227c)
- [Random number generators for C++ performance tested](http://thompsonsed.co.uk/random-number-generators-for-c-performance-tested)
- [xoshiro / xoroshiro generators and the PRNG shootout](http://prng.di.unimi.it/)
- [Xorshift1024*, Xorshift1024+, Xorshift128+ and Xoroshiro128+ Fail Statistical Tests for Linearity](https://lemire.me/en/publication/arxiv1810.05313/)
- [PCG, A Family of Better Random Number Generators](http://www.pcg-random.org/)
- [Visualizing the Heart of Some PRNGs](http://www.pcg-random.org/posts/visualizing-the-heart-of-some-prngs.html)
- [Fast Random Number Generator on the Intel® Pentium® 4 Processor](https://software.intel.com/en-us/articles/fast-random-number-generator-on-the-intel-pentiumr-4-processor)
- [Pseudo-Random vs. True Random](https://boallen.com/random-numbers.html)
- [PHP rand(0,1) on Windows < OpenSSL rand() on Debian](http://cod.ifies.com/2008/05/php-rand01-on-windows-openssl-rand-on.html)
- [Randomness Test](https://www.shadertoy.com/view/wljXDz)
- [C++ super fast thread-safe rand function](https://stackoverflow.com/questions/8285067/c-super-fast-thread-safe-rand-function)
- [Python: Calculating pi using random numbers](http://www.stealthcopter.com/blog/2009/09/python-calculating-pi-using-random-numbers/)
- [Entropy and Random Number Generators - a study of RNG and a custom RNG solution](https://calomel.org/entropy_random_number_generators.html)

## Online tools
- [Quick C++ Benchmark](http://quick-bench.com/)
- [Compiler Explorer](https://godbolt.org/)

## Sanitizers
- [Finding races and memory errors with LLVM instrumentation - AddressSanitizer, ThreadSanitizer](http://llvm.org/devmtg/2011-11/Serebryany_FindingRacesMemoryErrors.pdf)
- [Sanitize, Fuzz, and Harden Your C++ Code, Kostya Serebryany](https://www.usenix.org/sites/default/files/conference/protected-files/enigma_slides_serebryany.pdf)
- [Integrating sanitizer tools to CMake builds](http://www.stablecoder.ca/2018/02/01/analyzer-build-types.html)

## Docs
- [MATLAB array manipulation tips and tricks](https://www.ee.columbia.edu/~marios/matlab/mtt.pdf)
- [NumPy for MATLAB users](http://mathesaurus.sourceforge.net/matlab-numpy.html)
- [Machine Learning Cheatsheet](https://ml-cheatsheet.readthedocs.io/en/latest/)

## Misc
- [ScalFMM: Fast Multipole Method](https://gitlab.inria.fr/solverstack/ScalFMM)
