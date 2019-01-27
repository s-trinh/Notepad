### Latest Valgrind version on Ubuntu 16.04
- [How to upgrade to Valgrind 3.10.0 on Ubuntu 12.04?](https://askubuntu.com/questions/604137/how-to-upgrade-to-valgrind-3-10-0-on-ubuntu-12-04/801179#801179)
```
# or download latest release here: http://valgrind.org/downloads/
wget http://valgrind.org/downloads/valgrind-3.10.1.tar.bz2
tar -xjf valgrind-3.10.1.tar.bz2
cd valgrind-3.10.1
# read README file for instructions
./configure --prefix=/usr/local
make
sudo make install
# optional?
ccache --clear
```
