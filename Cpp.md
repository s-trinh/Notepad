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
