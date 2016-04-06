FROM ruby:2.2.0

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev
# for nokogiri
# RUN apt-get install -y libxml2-dev libxslt1-dev
# for capybara-webkit
# RUN apt-get install -y libqt4-webkit libqt4-dev xvfb
# for a JS runtime
# RUN apt-get install -y nodejs

# create directory
ENV APP_HOME /login
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add github key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Clone the conf files into the docker container
# RUN git clone git@bitbucket.org:User/repo.git

# install gems
ADD Gemfile* $APP_HOME/
RUN bundle install

# add application
ADD . $APP_HOME