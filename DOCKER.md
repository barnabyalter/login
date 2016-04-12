# Login on Docker

## Installation

Follow the docker documentation to install: https://docs.docker.com/engine/installation/mac/

This docker configuration was built on the following versions:

$ docker -v
=> Docker version 1.10.3, build 20f81dd

$ docker-compose -v
=> docker-compose version 1.6.2, build 4d72027

$ docker-machine -v
=> docker-machine version 0.6.0, build e27fb87

You may need to run `docker login` for access to pre-built images.

## Building and running Login

Run `rake docker:enable` to start the docker daemon then `eval "$(docker-machine env default)"` to enable docker commands in your terminal.

Run `rake docker:up` to preconfigure, build, and run the application in its docker container, linked to its database. _Before_ running this, you will need to add a private key to the application directory named `id_rsa`. Docker uses this private key to run Figs.

Run `rake docker:setup` to finish database setup for development and test environments.

Execute arbitrary commands on the docker container with `docker-compose run web` followed by the command in question, for example: `docker-compose run web bin/rake spec` to run specs on docker.

## Docker images and containers

Run `docker ps` to list running containers and `docker ps -a` to list running and stopped containers. Run `docker rm` with the docker container hash to remove a container

Run `docker images` to list top-level images and `docker ps -a` to list top-level and intermediate images. Docker uses intermediate images to cache steps of the build process. Run `docker rmi` with the docker image hash to remove an image.

To destroy all your containers, run `docker rm $(docker ps -a -q)`, and to destroy all your images, run `docker rmi $(docker images -q)`.

## Note about bundler

Dockerfile configures bundler to install gems into a separate container "gembox" configured in docker-compose, based on a [blog post](https://medium.com/@fbzga/how-to-cache-bundle-install-with-docker-7bed453a5800#.bpd1rz5ya))

## Note about postgres

You can connect to the database container (built with default development configuration) using:

`psql -h localhost -p 5432 -d login_development -U login`

## View in browser

Use `docker-machine ip` to determine the IP of the virtual host. Alias this in `etc/hosts` as "dockerhost" and you should be able to view in browser

## Security

While many Dockerfiles online seem to run applications as root (by default), we run as a separate user. Others have [demonstrated](https://news.ycombinator.com/item?id=7909622) that its possible to "break out" of a docker container running as non-root user, and while the issue was patched, according to a Docker maintainer: "Please remember that at this time, we don't claim Docker out-of-the-box is suitable for containing untrusted programs with root privileges." (Obviously, our own applications should be "trusted" but I thought I should note this issue.)

Note that our database users (for both development and test) are setup as superusers.
