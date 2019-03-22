### Load image from disk
- `docker load < img.tar.gz`
- `docker load -i img.tar.gz` # equivalent?

### Save container image
- [How do I use Docker save to backup a local image to a file?](https://stackoverflow.com/questions/45535790/how-do-i-use-docker-save-to-backup-a-local-image-to-a-file):
```
docker commit container_id repo/image_name:tag
docker save -o image_name.tar.gz repo/image_name:tag
```
- [Docker commit](https://docs.docker.com/engine/reference/commandline/commit/):
```
docker commit c3f279d17e0a svendowideit/testimage:version3
```
- [How to save a Docker container state](https://stackoverflow.com/questions/44480740/how-to-save-a-docker-container-state/44480870#44480870)

### Change docker images default location
- use a disk partition with `Ext4` file system on Linux (`NTFS` will not work with docker on Ubuntu)
- mount the disk partition automatically at startup:
  - launch `Gnome-disks`
  - select the partition
  - click on the option button (wheel)
  - and select automount
- edit `etc/docker/daemon.json` and add:
```
"data-root":"/mnt/<disk_uuid>/docker",
```
- then.
```
sudo systemctl stop docker
# Check docker has been stopped
ps aux | grep -i docker | grep -v grep
# Copy the files to the new location
# -a, --archive             archive mode; equals -rlptgoD (no -H,-A,-X)
# -x, --one-file-system     don't cross filesystem boundaries
# -P                        show progress during transfer
# -S, --sparse              handle sparse files efficiently
sudo rsync -axPS /var/lib/docker/ /new/path/to/docker-data
# service docker restart
sudo systemctl start docker
# Check Docker has started up using the new location
docker info | grep 'Docker Root Dir'
# Check everything has started up that should be running
docker ps
# Leave both copies on the server for a few days to make sure no issues arise, then feel free to delete it.
sudo rm -r /var/lib/docker
```
- [Change Docker data directory on Debian](https://blog.adriel.co.nz/2018/01/25/change-docker-data-directory-in-debian-jessie/)
- [How to change the docker image installation directory?](https://stackoverflow.com/questions/24309526/how-to-change-the-docker-image-installation-directory/50217666#50217666)

### Commands
- `docker images` or `docker image ls`
- `docker container ls` or `docker ps`?
- `docker ps -a` # Not only running containers
- [tag an image](https://docs.docker.com/engine/reference/commandline/tag/): `docker tag image_id name`
- [Remove Docker Images](https://tecadmin.net/remove-docker-images-and-containers/):
```
docker rmi  <IMAGE ID>
docker rm  <CONTAINER ID> # Remove docker container
```
- `docker cp <local_file> container_id:docker_path`
- `docker pull repository/image_name`
- `docker exec -it contained_id bash`

### Misc
- [In Docker, what's the difference between a container and an image?](https://stackoverflow.com/questions/21498832/in-docker-whats-the-difference-between-a-container-and-an-image/23667302#23667302):
> Images are frozen immutable snapshots of live containers.
>
> Containers are running (or stopped) instances of some image.
- [Issue with OpenGL and `nvidia-docker-2` (`nvidia-docker-1` is ok)](https://github.com/NVIDIA/nvidia-docker/issues/534) (another [link](https://github.com/jessfraz/dockerfiles/issues/253)):
```
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
```
