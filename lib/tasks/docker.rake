require 'docker_helper'

namespace :docker do

  # runs setup commands to enable docker in terminal window, starting daemon if necessary
  task :enable do
    DockerHelper.enable
  end

  # generates .env file for db configuration of docker-compose
  task :preconfigure do
    DockerHelper.preconfigure
  end

  task :build => [:preconfigure] do
    puts `docker-compose build`
  end

  task :up => [:build] do
    puts `docker-compose up`
  end

  # runs db setup rake tasks in docker-compose web container
  task :setup do
    DockerHelper.setup
  end
end
