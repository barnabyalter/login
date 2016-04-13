# Login on Docker

## Install Docker

Follow the docker documentation to install: https://docs.docker.com/engine/installation/mac/

To start the docker daemon:

```
rake docker:enable
```

To add docker commands to your PATH:

```
eval "$(docker-machine env default)"
```

You may wish to add the above command to your `~/.profile`.

### Versions

This docker configuration was built on the following versions:

```
$ docker -v
=> Docker version 1.10.3, build 20f81dd

$ docker-compose -v
=> docker-compose version 1.6.2, build 4d72027

$ docker-machine -v
=> docker-machine version 0.6.0, build e27fb87
```

You may need to run `docker login` for access to pre-built images.

## Building and running Login

After starting the docker daemon and enabling docker commands, copy a passwordless private key for github into your repo (for use with Figs). Ensure the key is in the application root with filename `id_rsa`. Note that symlinking will not work with docker.

With `id_rsa` in your application root, preconfigure, build, and run the application in its docker containers:

```
rake docker:up
```

After the docker containers are up, finish database setup for development and test environments:

```
rake docker:setup
```

Execute arbitrary commands on the app's docker web container with `docker-compose run web` followed by the desired command. For example, to run tests on the docker web container:

```
docker-compose run web bin/rake spec
```

### View in browser

Determine the IP of the virtual host:

```
docker-machine ip
```

View in browser with that IP on port 3000.

Add a host `dockerhost` with this IP to your `/etc/hosts`:

```
rake docker:update_dockerhost
```

You can then view the app in your browser at `dockerhost:3000`

### Bundler

Dockerfile configures bundler to install gems into a separate container "gembox" configured in docker-compose, based on a [blog post](https://medium.com/@fbzga/how-to-cache-bundle-install-with-docker-7bed453a5800#.bpd1rz5ya). This avoids having to reinstall all gems when the web container must be rebuilt.

### Postgres

You can connect to the database container (built with default development configuration) using:

```
psql -h localhost -p 5432 -d login_development -U login
```

## Docker images and containers

List running docker containers:

```
docker ps
```

List running and stopped containers:

```
docker ps -a
```

Destroy a docker container:

```
docker rm
```

List top-level docker images:

```
docker images
```

List top-level and intermediate images (Docker uses intermediate images to cache steps of the build process):

```
docker images -a
```

Destroy a docker image:

```
docker rmi
```

Destroy all stopped containers:

```
docker rm $(docker ps -a -q)
```

Destroy all images:

```
docker rmi $(docker images -q)
```

## Security

While many Dockerfiles online seem to run applications as root (by default), we run as a separate user. Others have [demonstrated](https://news.ycombinator.com/item?id=7909622) that its possible to "break out" of a docker container running as non-root user, and while the issue was patched, according to a Docker maintainer: "Please remember that at this time, we don't claim Docker out-of-the-box is suitable for containing untrusted programs with root privileges." (Obviously, our own applications should be "trusted" but I thought I should note this issue.)

Note that our database users (for both development and test) are setup as superusers.
