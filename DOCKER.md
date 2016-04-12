# Login on Docker

## Docker

Install docker: https://docs.docker.com/engine/installation/mac/

Check your versions:

$ docker -v
=> Docker version 1.10.3, build 20f81dd

$ docker-compose -v
=> docker-compose version 1.6.2, build 4d72027

Run `docker ps` to list running containers and `docker ps -a` to list running and stopped containers. Run `docker rm` with the docker container hash

You may need to run `docker login` for access to pre-built images.

## Rake tasks

Rake tasks for docker are defined in the `docker:` namespace and implemented in `lib/docker_helper.rb`. Run `rake docker:enable` to start the docker daemon and `eval "$(docker-machine env default)"` to enable docker commands in your terminal.

## Note about bundler

Dockerfile configures bundler to install gems into a separate container "gembox" configured in docker-compose, based on a [blog post](https://medium.com/@fbzga/how-to-cache-bundle-install-with-docker-7bed453a5800#.bpd1rz5ya))

## Note about postgres

You can connect to the database using:

`psql -h localhost -p 5432 -d login_development -U login`

## View in browser

## Security

Why we must run as non-root: others have [demonstrated](https://news.ycombinator.com/item?id=7909622) that its possible to "break out" of a docker container running as non-root user, and while the issue was patched, but according to a Docker maintainer: "Please remember that at this time, we don't claim Docker out-of-the-box is suitable for containing untrusted programs with root privileges."
