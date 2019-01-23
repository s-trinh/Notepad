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
- [It is more complicated than I thought: -mtune, -march in GCC](https://lemire.me/blog/2018/07/25/it-is-more-complicated-than-i-thought-mtune-march-in-gcc/)
- [GCC: how is march different from mtune?](https://stackoverflow.com/questions/10559275/gcc-how-is-march-different-from-mtune)

### GCC 8 in Ubuntu 16.04
- [How to install latest gcc on Ubuntu LTS (12.04, 14.04, 16.04)](https://gist.github.com/application2000/73fd6f4bf1be6600a2cf9f56315a2d91#gistcomment-1813119):
```
sudo apt-get update -y && 
sudo apt-get install build-essential software-properties-common -y && 
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && 
sudo apt-get update -y && 
sudo apt-get install gcc-8 g++-8 -y && 
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-8 && 
sudo update-alternatives --config gcc
```
- [How to install gcc-7 or clang 4.0?](https://askubuntu.com/questions/859256/how-to-install-gcc-7-or-clang-4-0/887791#887791)
- [Install gcc-8 only on Ubuntu 18.04?](https://askubuntu.com/questions/1028601/install-gcc-8-only-on-ubuntu-18-04/1028656#1028656):
```
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
#
sudo update-alternatives --config gcc
There are 2 choices for the alternative gcc (providing /usr/bin/gcc).

  Selection    Path            Priority   Status
------------------------------------------------------------
* 0            /usr/bin/gcc-8   800       auto mode
  1            /usr/bin/gcc-7   700       manual mode
  2            /usr/bin/gcc-8   800       manual mode

Press <enter> to keep the current choice[*], or type selection number: 
```
- GCC 8:
```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-8 g++-8
gcc-8 --version
```

### Misc
- [How do I force make/gcc to show me the commands?](https://stackoverflow.com/questions/5820303/how-do-i-force-make-gcc-to-show-me-the-commands): `make VERBOSE=1`
- [How do I list the symbols in a .so file](https://stackoverflow.com/questions/34732/how-do-i-list-the-symbols-in-a-so-file/34796#34796): `nm -gC yourLib.so`
