require 'figs'

module Docker
  module DockerHelper
    # writes env file for docker-compose db
    def self.preconfigure
      File.open(".env.db", "w") do |f|
        f.write stringify_hash_for_env_file get_db_config('development')
      end
    end

    # setup db: create and run migrations for dev and test
    def self.setup_db
      puts `docker-compose run web bin/rake db:setup`
    end

    # if test db user does not yet exist, create them with superuser
    def self.create_test_db_user
      test_db_config = get_db_config 'test'
      execute_sql "
        DO \\$body\\$
          BEGIN
            IF NOT EXISTS (
              SELECT * FROM pg_catalog.pg_user WHERE usename = '#{test_db_config[:POSTGRES_USER]}'
            ) THEN
              CREATE USER #{test_db_config[:POSTGRES_USER]} WITH SUPERUSER ENCRYPTED PASSWORD '#{test_db_config[:POSTGRES_PASSWORD]}';
            END IF;
          END
        \\$body\\$ LANGUAGE plpgsql;
      "
    end

    #starts docker user
    def self.enable
      puts `docker-machine start default` # starts docker daemon
      puts `docker-machine env`
    end

    # executes arbitrary, unescaped SQL using dev user
    def self.execute_sql(sql)
      dev_db_config = get_db_config 'development'
      `psql -h dockerhost -p 5432 -U #{dev_db_config[:POSTGRES_USER]} -d #{dev_db_config[:POSTGRES_DB]} -c \"#{sql}\"`
    end

    private
    # returns config as hash with keys as environment variable names
    def self.get_db_config(env)
      {
        POSTGRES_USER: (get_env_var(env, 'LOGIN_DB_USER') || "login"),
        POSTGRES_PASSWORD: (get_env_var(env, 'LOGIN_DB_PASSWORD') || ""),
        POSTGRES_DB: (get_env_var(env, 'LOGIN_DB_DATABASE') || "login_development"),
      }
    end

    # converts hash of environment variables to string for env file
    def self.stringify_hash_for_env_file(hash)
      hash.map{|k,v| "#{k}=#{v}"}.join("\n")
    end

    # returns specified environment variable for specified environment
    def self.get_env_var(environment, variable_name)
      Figs.env[environment].try(:[], variable_name) || Figs.env[variable_name]
    end

  end
end




# `docker-compose run db psql -h db -U #{ENV['LOGIN_DB_USER']} -c ""`
