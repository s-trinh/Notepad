### Load image from disk
- `docker load < img.tar.gz`
- `docker load -i img.tar.gz` # equivalent?

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
