### SIMD programming
- [https://software.intel.com/sites/landingpage/IntrinsicsGuide/#](https://software.intel.com/sites/landingpage/IntrinsicsGuide/#)
- [x86 Intrinsics Cheat Sheet](https://db.in.tum.de/~finis/x86-intrin-cheatsheet-v2.2.pdf)
- [Disable AVX2 functions on non-Haswell processors](https://stackoverflow.com/questions/23676426/disable-avx2-functions-on-non-haswell-processors/23677889#23677889)
- [cpu dispatcher for visual studio for AVX and SSE](https://stackoverflow.com/questions/15406658/cpu-dispatcher-for-visual-studio-for-avx-and-sse/25884902#25884902)
- [Proper way to enable SSE4 on a per-function / per-block of code basis?](https://stackoverflow.com/questions/24101875/proper-way-to-enable-sse4-on-a-per-function-per-block-of-code-basis/)
- [How to check with Intel intrinsics if AVX extensions is supported by the CPU?](https://stackoverflow.com/questions/24260490/how-to-check-with-intel-intrinsics-if-avx-extensions-is-supported-by-the-cpu/24265862#24265862)
- [Do I need to make multiple executables for targetting different instruction sets?](https://stackoverflow.com/questions/22161682/do-i-need-to-make-multiple-executables-for-targetting-different-instruction-sets/22166828#22166828)
- [Preventing GCC from automatically using AVX and FMA instructions when compiled with -mavx and -mfma](https://stackoverflow.com/questions/18868235/preventing-gcc-from-automatically-using-avx-and-fma-instructions-when-compiled-w/25911959#25911959)
- [Mixing SSE2 and AVX intrinsics with different compilers](https://stackoverflow.com/questions/49226452/mixing-sse2-and-avx-intrinsics-with-different-compilers/49228001#49228001)
- [Vectorization with Compilers (C/C++)](https://events.prace-ri.eu/event/590/contributions/400/attachments/543/792/Vectorization_Compilers.pdf)
- [Guide to Automatic Vectorization with Intel AVX-512 Instructions in Knights Landing Processors](https://colfaxresearch.com/knl-avx512/)
- [SSE and AVX intrinsics mixture](https://stackoverflow.com/questions/18319488/sse-and-avx-intrinsics-mixture)
- [What is the status of VZEROUPPER use?](https://software.intel.com/en-us/forums/intel-isa-extensions/topic/704023)
- [Why is this SSE code 6 times slower without VZEROUPPER on Skylake?](https://stackoverflow.com/questions/41303780/why-is-this-sse-code-6-times-slower-without-vzeroupper-on-skylake/41349852#41349852)
- [AVX CPU dispatching - based on Agner Fog's C++ vector class library [http://www.agner.org/optimize/vectorclass.zip] ](https://gist.github.com/zchothia/3078968)
- [x86 CPU Dispatching for SSE/AVX in C++](https://stackoverflow.com/questions/4788592/x86-cpu-dispatching-for-sse-avx-in-c)
- [How to use the auto-dispatching for AVX (plus some more questions)](https://software.intel.com/en-us/forums/intel-c-compiler/topic/544561)
- [The significance of SIMD, SSE and AVX](https://www.polyhedron.com/web_images/intel/productbriefs/3a_SIMD.pdf)
- [Using AVX CPU instructions: Poor performance without “/arch:AVX”](https://stackoverflow.com/questions/7839925/using-avx-cpu-instructions-poor-performance-without-archavx/28356924#28356924)
- [VC++ /arch:AVX option – unsafe at any speed](https://randomascii.wordpress.com/2016/12/05/vc-archavx-option-unsafe-at-any-speed/)

### SIMD Libraries / Wrappers
- [UME::SIMD A library for explicit simd vectorization](https://github.com/edanor/umesimd)
- [Vectorization EDSL library](https://github.com/edanor/umevector)
- [MyIntrinsics++ (MIPP)](https://github.com/aff3ct/MIPP)
- [VOLK - The Vector Optimized Library of Kernels](https://github.com/gnuradio/volk) ([http://libvolk.org/](http://libvolk.org/))
- [tsimd - Fundamental C++ SIMD types for Intel CPUs (sse to avx512)](https://github.com/ospray/tsimd) ([OSPRay](http://www.ospray.org/))
- [xsimd - C++ wrappers for SIMD intrinsics](https://github.com/xtensor-stack/xsimd)

### Visual Studio
- [Predefined Macros](https://docs.microsoft.com/en-us/cpp/preprocessor/predefined-macros?view=vs-2017)

### Code
- [Prevent GCC from optimizing away a snippet of code](https://yangzhang.tech/blog/2015/04/27/prevent-gcc-optimize-away-code/):
```
#pragma GCC push_options
#pragma GCC optimize("O0")
void doTest() {
    int a;
    a = 15;
    a += 1;
}
#pragma GCC pop_options
#
# or
__attribute__((optimize("O0")))
```
- Infinity representation:
  - [Sample single precision floating-point values for IEEE 754 arithmetic](https://developer.arm.com/docs/dui0475/g/floating-point-support/sample-single-precision-floating-point-values-for-ieee-754-arithmetic)
  - [Sample double precision floating-point values for IEEE 754 arithmetic](https://developer.arm.com/docs/dui0475/g/floating-point-support/sample-double-precision-floating-point-values-for-ieee-754-arithmetic)
  - [`std::numeric_limits::infinity`](https://en.cppreference.com/w/cpp/types/numeric_limits/infinity)
  - [`HUGE_VAL`](https://en.cppreference.com/w/cpp/numeric/math/HUGE_VAL)
  - [`INFINITY`](https://en.cppreference.com/w/cpp/numeric/math/INFINITY)
  - [IEEE 754 - Standard binary arithmetic float](http://www.softelectro.ru/ieee754_en.html)
  - [Infinity and NaNs](https://www.doc.ic.ac.uk/~eedwards/compsys/float/nan.html)
  - [IEEE Standard 754 Floating Point Numbers](https://steve.hollasch.net/cgindex/coding/ieeefloat.html)
  - [http://cpp.sh/2xok2](http://cpp.sh/2xok2)
  <details>
  
  ```
  #include <iostream>
  #include <limits>
  #include <cstring>
  #include <cmath>

  union U_INF {
      uint64_t l;
      double d;
  };

  double hex_inf_pos() {
      int64_t i_val = 0x7FF0000000000000;
      double d_val = 0;
      memcpy(reinterpret_cast<void*>(&d_val), reinterpret_cast<void*>(&i_val), sizeof(double));
      return d_val;
  }

  double hex_inf_neg() {
      uint64_t i_val = 0xFFF0000000000000;
      double d_val = 0;
      memcpy(&d_val, &i_val, sizeof(double));
      return d_val;
  }

  double union_inf_pos() {
      U_INF u_val;
      u_val.l = 0x7FF0000000000000;
      return u_val.d;
  }

  static inline double double_pos_inf() {
      union {double d; int64_t i;} u;
      u.i = 0x7FF0000000000000;
      return u.d;
  }

  static inline double double_neg_inf() {
      union {double d; int64_t i;} u;
      u.i = 0xFFF0000000000000;
      return u.d;
  }

  static inline float float_pos_inf() {
      union {float f; int32_t i;} u;
      u.i = 0x7F800000;
      return u.f;
  }

  static inline float float_neg_inf() {
      union {float f; uint32_t i;} u;
      u.i = 0xFF800000;
      return u.f;
  }

  int main()
  {
      double val1 = std::numeric_limits<double>::infinity();
      double val2 = -std::numeric_limits<double>::infinity();
      double val3 = hex_inf_pos();
      double val4 = hex_inf_neg();
      double val5 = HUGE_VALF;
      float val6 = HUGE_VALF;
      double val7 = 0x7F800000;
      float val8 = 0x7F800000;
      double val9 = union_inf_pos();
      double val10 = double_pos_inf();
      double val11 = double_neg_inf();
      float val12 = float_pos_inf();
      float val13 = float_neg_inf();
      std::cout << "val1: " << val1 << std::endl;
      std::cout << "val2: " << val2 << std::endl;
      std::cout << "val3: " << val3 << std::endl;
      std::cout << "val4: " << val4 << std::endl;
      std::cout << "HUGE_VALF: " << val5 << std::endl;
      std::cout << "HUGE_VALF: " << val6 << std::endl;
      std::cout << "INFINITY: " << INFINITY << std::endl;
      std::cout << "0x7F800000: " << val7 << std::endl;
      std::cout << "0x7F800000: " << val8 << std::endl;
      std::cout << "val9: " << val9 << std::endl;
      std::cout << "double_pos_inf: " << val10 << std::endl;
      std::cout << "double_neg_inf: " << val11 << std::endl;
      std::cout << "float_pos_inf: " << val12 << std::endl;
      std::cout << "float_neg_inf: " << val13 << std::endl;
  }
  ```
  </details>

### C++
- [Lazy Initialisation in C++](https://www.bfilipek.com/2019/10/lazyinit.html)
- [Bartek's coding blog - C++ and native programming stories.](https://www.bfilipek.com/)
