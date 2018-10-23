### Flags
- [How to use profile guided optimizations in g++?](https://stackoverflow.com/questions/4365980/how-to-use-profile-guided-optimizations-in-g/19388485#19388485):
```
g++ -O3 -fprofile-generate [more params here, like -march=native ...] -o executable_name
// run my program's benchmarks, or something to stress its most common path
g++ -O3 -fprofile-use [more params here, like -march=native...] -o executable_name
```
- [Some GCC Optimizations for Embedded Software](http://events17.linuxfoundation.org/sites/events/files/slides/elc14_raj.pdf)
- [GCC optimization](https://wiki.gentoo.org/wiki/GCC_optimization)
- [Get the compiler options from a compiled executable?](https://stackoverflow.com/questions/12112338/get-the-compiler-options-from-a-compiled-executable/12112479#12112479):
```
$ gcc -O2 -frecord-gcc-switches a.c
$ readelf -p .GCC.command.line a.out 

String dump of section '.GCC.command.line':
  [     0]  a.c
  [     4]  -mtune=generic
  [    13]  -march=x86-64
  [    21]  -O2
  [    25]  -frecord-gcc-switches
```
