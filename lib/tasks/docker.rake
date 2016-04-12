require 'docker/docker_helper'

namespace :docker do

  # runs setup commands to enable docker in terminal window, starting daemon if necessary
  task :enable do
    Docker::DockerHelper.enable
  end

  # generates .env file for db configuration of docker-compose
  task :preconfigure do
    Docker::DockerHelper.preconfigure
  end

  # builds docker compose after preconfiguring (for database)
  task :build => [:preconfigure] do
    puts `docker-compose build`
  end

  # runs docker compose after building
  task :up => [:build] do
    puts `docker-compose up`
  end

  # runs db setup rake tasks in docker-compose web container
  task :setup do
    Docker::DockerHelper.setup
  end
end
