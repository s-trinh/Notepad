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

### Misc
- [Command alias](https://doc.ubuntu-fr.org/alias):
```
gedit ~/.bash_aliases
alias alias_name='command'
source ~/.bashrc
```
- [How can I add a bookmark in my nautilus folder explorer](https://askubuntu.com/questions/188083/how-can-i-add-a-bookmark-in-my-nautilus-folder-explorer/206683#206683): hit `Ctrl + D`
