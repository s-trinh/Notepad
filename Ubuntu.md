### Software
- [Latest Gimp version on Ubuntu 16.04](https://doc.ubuntu-fr.org/gimp#pour_disposer_des_dernieres_versions_stables):
```
sudo add-apt-repository ppa:otto-kesselgulasch/gimp
sudo apt-get update
sudo apt-get install gimp
```
- [Latest Gimp version on Ubuntu 16.04 (Flatpak)](https://www.tecmint.com/install-gimp-in-ubuntu/):
```
sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt update
sudo apt install flatpak
#
flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
flatpak run org.gimp.GIMP
#
# (uninstall)
sudo apt install ppa-purge
sudo ppa-purge ppa:otto-kesselgulasch/gimp
```
- [Latest ffmpeg version on Ubuntu 16.04](https://tecadmin.net/install-ffmpeg-on-linux/):
```
sudo add-apt-repository ppa:jonathonf/ffmpeg-4
sudo apt-get update
sudo apt-get install ffmpeg
ffmpeg -version
```
- [Latest Terminator version on Ubuntu 16.04](https://nikitashalnov.github.io/terminator-crashes-in-ubuntu-1604/):
```
sudo add-apt-repository ppa:gnome-terminator/nightly-gtk3
sudo apt-get update
apt-cache policy terminator
sudo apt-get install terminator
```
- [Latest VLC version on Ubuntu 16.04](http://ubuntuhandbook.org/index.php/2018/05/install-vlc-3-0-2-ubuntu-16-04-ppa/):
```
sudo add-apt-repository ppa:jonathonf/vlc-3
sudo add-apt-repository ppa:jonathonf/ffmpeg-4
sudo add-apt-repository ppa:jonathonf/meson
sudo apt-get update && sudo apt-get install vlc
# revert / restore
sudo apt-get install ppa-purge && sudo ppa-purge ppa:jonathonf/vlc-3
sudo ppa-purge ppa:jonathonf/ffmpeg-4
```
- [Problems with libGl, fbConfigs, swrast through each update?](https://askubuntu.com/questions/541343/problems-with-libgl-fbconfigs-swrast-through-each-update):
```
#error:
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
#
find /usr -iname "*libGL.so*" -exec ls -l -- {} + 
```
- [Steam: libGL error: No matching fbConfigs or visuals found libGL error: failed to load driver: swrast](https://askubuntu.com/questions/834254/steam-libgl-error-no-matching-fbconfigs-or-visuals-found-libgl-error-failed-t):
```
sudo ldconfig -p | grep -i gl.so
#
libwayland-egl.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libwayland-egl.so.1
libftgl.so.2 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libftgl.so.2
libcogl.so.20 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libcogl.so.20
libQt5OpenGL.so.5 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libQt5OpenGL.so.5
libQtOpenGL.so.4 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libQtOpenGL.so.4
libQtOpenGL.so.4 (libc6) => /usr/lib/i386-linux-gnu/libQtOpenGL.so.4
libOpenGL.so.0 (libc6,x86-64) => /usr/lib/nvidia-378/libOpenGL.so.0
libOpenGL.so (libc6,x86-64) => /usr/lib/nvidia-378/libOpenGL.so
libGL.so.1 (libc6,x86-64) => /usr/lib/nvidia-378/libGL.so.1
libGL.so.1 (libc6) => /usr/lib/i386-linux-gnu/mesa/libGL.so.1
libGL.so.1 (libc6) => /usr/lib32/nvidia-378/libGL.so.1
libGL.so (libc6,x86-64) => /usr/lib/nvidia-378/libGL.so
libGL.so (libc6) => /usr/lib32/nvidia-378/libGL.so
libEGL.so.1 (libc6,x86-64) => /usr/lib/nvidia-378/libEGL.so.1
libEGL.so.1 (libc6) => /usr/lib32/nvidia-378/libEGL.so.1
libEGL.so (libc6,x86-64) => /usr/lib/nvidia-378/libEGL.so
libEGL.so (libc6) => /usr/lib32/nvidia-378/libEGL.so
```
- [Fix ‘add-apt-repository command not found’ Error on Ubuntu and Debian](https://itsfoss.com/add-apt-repository-command-not-found/):
```
sudo apt-get install software-properties-common
```
- [Install Proprietary Nvidia GPU Drivers on Ubuntu 16.04 / 17.10 / 18.04](https://websiteforstudents.com/install-proprietary-nvidia-gpu-drivers-on-ubuntu-16-04-17-10-18-04/):
```
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt install nvidia-387 #use desired drivers version
```

### Misc
- [Command alias](https://doc.ubuntu-fr.org/alias):
```
gedit ~/.bash_aliases
alias alias_name='command'
source ~/.bashrc
```
- [How can I add a bookmark in my nautilus folder explorer](https://askubuntu.com/questions/188083/how-can-i-add-a-bookmark-in-my-nautilus-folder-explorer/206683#206683): hit `Ctrl + D`
- [Safely removing USB 3.0 drive freezes the system - why and how to fix?](https://askubuntu.com/questions/1099414/safely-removing-usb-3-0-drive-freezes-the-system-why-and-how-to-fix/1100480#1100480)
- [Ubuntu 16.04.5 kernel 4.4.0-139 hard freezes when unmounting USB drive](https://ubuntuforums.org/showthread.php?t=2406277)

### Update kernel version
- [How to update kernel in Ubuntu 16.04?](https://askubuntu.com/questions/905049/how-to-update-kernel-in-ubuntu-16-04/905063#905063): [LTSEnablementStack](https://wiki.ubuntu.com/Kernel/LTSEnablementStack#Ubuntu_16.04_LTS_-_Xenial_Xerus)
```
dpkg --print-architecture
uname -r
sudo apt-get install --install-recommends linux-generic-hwe-16.04 xserver-xorg-hwe-16.04 
```
