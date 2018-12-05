### Shortcuts
- Move a window: press `alt` + left button mouse
- Resize a window: press `alt` + middle button mouse

### SSH
- [How to Enable SSH in Ubuntu 16.04 LTS](http://ubuntuhandbook.org/index.php/2016/04/enable-ssh-ubuntu-16-04-lts/):
```
sudo apt-get install openssh-server
sudo service ssh status
sudo nano /etc/ssh/sshd_config # Optional
sudo service ssh restart
```
- Issue with ssh and Gitlab: `sign_and_send_pubkey: signing failed: agent refused operation`:
```
ssh-add -l # show ssh keys
eval $(ssh-agent) # looks like this solve the issue and looks like gnome-keyring was not the root issue?
```

### Permission
- `sudo chown user:group folder -R`
