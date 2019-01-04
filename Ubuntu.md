### Software
- [Latest Gimp version in Ubuntu 16.04](https://doc.ubuntu-fr.org/gimp#pour_disposer_des_dernieres_versions_stables):
```
sudo add-apt-repository ppa:otto-kesselgulasch/gimp
sudo apt-get update
sudo apt-get install gimp
```
- [Latest Gimp version in Ubuntu 16.04 (Flatpak)](https://www.tecmint.com/install-gimp-in-ubuntu/):
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
