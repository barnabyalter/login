require 'docker_helper'

namespace :docker do
  # generates .env file for db configuration of docker-compose
  task :preconfigure do
    DockerHelper.preconfigure
  end
  
  # runs setup commands to enable docker in terminal window, starting daemon if necessary
  task :enable do
    DockerHelper.enable
  end
  
  task :up do
    `docker-compose up`
  end
  
  # runs db setup rake tasks in docker-compose web container
  task :setup do
    DockerHelper.setup
  end
end