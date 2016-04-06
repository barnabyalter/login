require 'figs'

class DockerHelper
  def self.preconfigure
    puts "Writing .env.db..."
    File.open(".env.db", "w"){|f| f.write hash_to_env get_db_config }
    # puts "Writing .env.web..."
    # File.open(".env.db", "w"){|f| f.write hash_to_env get_web_config }
  end
  
  def self.setup
    enable
    puts "Creating PostgreSQL database..."
    puts `docker-compose run db createdb -U postgres #{ENV['LOGIN_DB_DATABASE'] || "login_development"}`
    puts "Creating PostgreSQL user..."
    puts `docker-compose run db createuser -U postgres --createdb --encrypted --login #{ENV['LOGIN_DB_USER'] || "login"}`
    puts "Running Rails migrations..."
    puts `docker-compose run web rake db:create db:migrate`
  end
  
  def self.enable
    puts "Enabling docker..."
    puts `docker-machine start default` # starts docker daemon
    puts `docker-machine env`
    puts `eval "$(docker-machine env default)"`
  end
  
  private

  def self.get_db_config
    {
      POSTGRES_USER: (ENV['LOGIN_DB_USER'] || "login"),
      POSTGRES_PASSWORD: (ENV['LOGIN_DB_PASSWORD'] || ""),
      POSTGRES_DB: (ENV['LOGIN_DB_DATABASE'] || "login_development"),
    }
  end
  
  def self.hash_to_env(hash)
    hash.map{|k,v| "#{k}=#{v}"}.join("\n")
  end


end




# `docker-compose run db psql -h db -U #{ENV['LOGIN_DB_USER']} -c ""`