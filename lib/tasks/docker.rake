require 'docker/docker_helper'

namespace :docker do

  # runs setup commands to enable docker in terminal window, starting daemon if necessary
  desc "Enable docker daemon and prints command needed to modify PATH for command-line tools"
  task :enable do
    puts "Starting docker daemon..."
    Docker::DockerHelper.enable
    puts "You may need to run the following to modify your PATH to access docker command-line tools:\n   eval \"$(docker-machine env default)\""
  end

  # generates .env file for db configuration of docker-compose
  desc "Generate environment files specifying database configuration"
  task :preconfigure do
    puts "Writing .env.db..."
    Docker::DockerHelper.preconfigure
  end

  # builds docker compose after preconfiguring (for database)
  desc "Build docker compose after preconfiguring"
  task :build => [:preconfigure] do
    puts `docker-compose build`
  end

  # runs docker compose after building
  desc "Run docker compose after building (and preconfiguring)"
  task :up => [:build] do
    puts `docker-compose up`
  end

  # runs db setup rake tasks in docker-compose web container
  desc "Setup development and test databases and create database test user"
  task :setup do
    puts "Creating test db user..."
    Docker::DockerHelper.create_test_db_user
    puts "Creating database and running migrations..."
    Docker::DockerHelper.setup_db
  end

  desc "Update dockerhost host in /etc/hosts with IP of docker machine"
  task :update_dockerhost do
    `script/update_dockerhost`
  end
end
