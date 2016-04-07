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

# add application
ADD . $APP_HOME

# add user who will run app
ENV USERNAME wsops
RUN adduser $USERNAME --home /$USERNAME --shell /bin/bash --disabled-password --gecos ""
RUN chown -R $USERNAME:$USERNAME $APP_HOME

# set bundle path to volume on separate container (configured in docker-compose)
ENV BUNDLE_PATH /gembox

# copy over private key, and set permissions
RUN mkdir /$USERNAME/.ssh/
ADD id_rsa /$USERNAME/.ssh/id_rsa
RUN chown -R $USERNAME:$USERNAME /$USERNAME/.ssh/

# switch to applicaton user for ssh setup
USER $USERNAME

# create known_hosts
RUN touch /$USERNAME/.ssh/known_hosts
# add github key
RUN ssh-keyscan -t rsa github.com >> /$USERNAME/.ssh/known_hosts

WORKDIR $APP_HOME
