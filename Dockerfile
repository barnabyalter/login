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

# use to run app
RUN adduser wsops --home /wsops --shell /bin/bash --disabled-password --gecos ""

# set bundle path to volume on separate container (configured in docker-compose)
ENV BUNDLE_PATH /gembox

# add application and set
ADD . $APP_HOME
RUN chown -R wsops:wsops $APP_HOME

USER wsops
# copy over private key, and set permissions
RUN mkdir /wsops/.ssh/
ADD id_rsa /wsops/.ssh/id_rsa

# create known_hosts
RUN touch /wsops/.ssh/known_hosts
# add github key
RUN ssh-keyscan -t rsa github.com >> /wsops/.ssh/known_hosts

WORKDIR $APP_HOME
