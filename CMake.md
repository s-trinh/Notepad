### Misc
- [Enabling C++11 And Later In CMake](https://crascit.com/2015/03/28/enabling-cxx11-in-cmake/):
```
# Setting the C++ standard directly
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
# If you don’t want to set the global behaviour, target-by-target basis
set_target_properties(myTarget PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)
```
- [OS specific instructions in CMAKE: How to?](https://stackoverflow.com/questions/9160335/os-specific-instructions-in-cmake-how-to)
- [Useful Variables](https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/Useful-Variables)
- [How To Write Platform Checks](https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/How-To-Write-Platform-Checks)
- [Cross-Compiling](https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/CrossCompiling)

### CTest
- [cTest: run a single test in a multi-test directory?](https://cmake.org/pipermail/cmake/2013-July/055225.html):
```
ctest -R pdf5
```
