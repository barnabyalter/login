# Login on Docker

## Docker

Install docker: https://docs.docker.com/engine/installation/mac/

Run `docker ps` to list running containers and `docker ps -a` to list running and stopped containers. Run `docker rm` with the docker dontainer hash

You may need to run `docker login` for access to pre-built images.

## Docker Helpers

Rake tasks for docker are defined in the `docker:` namespace and implemented . Run `rake docker:enable` to start the docker daemon and `eval "$(docker-machine env default)"` to enable docker commands in your terminal.