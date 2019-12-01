### ARM Toolchain / Compilation
- [ArmEabiPort](https://wiki.debian.org/ArmEabiPort)
- [GNU Toolchain for the A-profile Architecture](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads)
- [Compiler flags across architectures: -march, -mtune, and -mcpu](https://community.arm.com/developer/tools-software/tools/b/tools-software-ides-blog/posts/compiler-flags-across-architectures-march-mtune-and-mcpu)

### ARM
- [ArmHardFloatBuildHardware](https://wiki.debian.org/ArmHardFloatBuildHardware)
- [DietPi-Survey report page](https://dietpi.com/survey)

### OpenBLAS build on ARM
- Install `gfortran` package?
- [User Manual](https://github.com/xianyi/OpenBLAS/wiki/User-Manual)
- [https://gitlab.com/arm-hpc/packages/wikis/packages/openblas](https://gitlab.com/arm-hpc/packages/wikis/packages/openblas)

### Odroid-XU4
- [ODROID-XU4 Manual](https://magazine.odroid.com/odroid-xu4) ([pdf](https://magazine.odroid.com/wp-content/uploads/odroid-xu4-user-manual.pdf))
- [ODROID-XU4 Wiki](https://wiki.odroid.com/odroid-xu4/odroid-xu4)
- [Présentation Odroid XU4 et installation Ubuntu 16.04](https://linuxfr.org/wiki/presentation-odroid-xu4-et-installation-ubuntu-16-04)
- [Odroid-XU4 Old Wiki](https://odroid.com/dokuwiki/doku.php?id=en:odroid-xu4)
- [ODROID-XU4: Much Better Performance Than The Raspberry Pi Plus USB3](https://www.phoronix.com/scan.php?page=article&item=odroid-xu4-arm)
- [USB Wifi Dongle](https://forum.odroid.com/viewtopic.php?t=17928)
- [TP-Link TL-WN725N Clé WiFi N 150 Mbps, nano adaptateur USB wifi, dongle wifi, compatible avec Windows 10/8.1/8/7/XP/Vista, Mac OS X 10.9-10.13, Linux. , Noir](https://www.amazon.fr/TP-Link-TL-WN725N-adaptateur-compatible-10-9-10-13/dp/B008IFXQFU/)
- [recommended wifi usb dongle?](https://forum.odroid.com/viewtopic.php?t=7887)
- [Le logiciel Solaar (protocole Logitech™ Unifying Receiver)](https://doc.ubuntu-fr.org/solaar)
- [How to Add a Swap File On Ubuntu](https://www.howtoforge.com/ubuntu-swap-file):
```
sudo swapon -s
df
# of=/swapfile” designates the file’s name. In this case the name is swapfile.
sudo dd if=/dev/zero of=/swapfile bs=1024 count=256k
sudo mkswap /swapfile
sudo swapon /swapfile
swapon -s
sudo gedit /etc/fstab
echo 10 | sudo tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
sudo chown root:root /swapfile
top
```

### Raspberry Pi 4
- [Raspberry Pi 4 Case (with cooling fan) Assembly Guide](https://thepihut.com/blogs/raspberry-pi-tutorials/raspberry-pi-4-case-with-cooling-fan-assembly-guide)
- [5V 4-pin PWM Noctua A4X10 on Raspberry Pi](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=244194)
- [Raspberry Pi 4 Bootloader Firmware Updating / Recovery Guide](https://jamesachambers.com/raspberry-pi-4-bootloader-firmware-updating-recovery-guide/)
- [RPi USB Wi-Fi Adapters](https://elinux.org/RPi_USB_Wi-Fi_Adapters)
