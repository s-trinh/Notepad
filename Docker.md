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

### Misc
- [In Docker, what's the difference between a container and an image?](https://stackoverflow.com/questions/21498832/in-docker-whats-the-difference-between-a-container-and-an-image/23667302#23667302):
> Images are frozen immutable snapshots of live containers.
>
> Containers are running (or stopped) instances of some image.
