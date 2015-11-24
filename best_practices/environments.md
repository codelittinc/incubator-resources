Environments 
=======

We've fairly scripted method for maintaining environments across teams, staging, and production. The process/scripts below are for a standard Ruby/React stack, but these can be customized to fit your needs.

## 1. The bash script that starts it all


This is a shell script which basically any engineer can run in development or production to spin everything up. It will live in `scripts/dev.sh`. It handles the build of the docker images and containers. You can customize it to your liking and environment. 


```shell
#!/bin/bash

####### Project configuration #######
PROJECT_NAME=outnix
PROJECT_MAIN_LANGUAGE=ruby
#####################################

UPPERCASE_PROJECT_NAME=$(echo $PROJECT_NAME | tr '[a-z]' '[A-Z]')
ATTACH_ON_CONTAINER=$PROJECT_MAIN_LANGUAGE
DB_CONTAINER_NAME=$PROJECT_NAME-db
PROJECT_CONTAINER_NAME=$PROJECT_NAME-$PROJECT_MAIN_LANGUAGE

find_docker_id() {
  echo $(docker ps -a | grep $1 | sed 's/\([0-9a-z]\+\).*/\1/')
}

attach_to_container(){
  docker attach $(find_docker_id $PROJECT_CONTAINER_NAME)
}

start_container(){
  container_name=$1
  docker_id=$(find_docker_id $container_name)
  for action in "stop" "start"
  do
    docker $action $docker_id
  done
}

run_db_container(){
  docker_id=$(find_docker_id $DB_CONTAINER_NAME)
  if [ $docker_id ] ; then
    echo 'Starting db container on docker'
    start_container $DB_CONTAINER_NAME
  else
    echo 'Creating db container'
    docker run --name $DB_CONTAINER_NAME -e POSTGRES_PASSWORD=postgres -d postgres
  fi
}

run_project_container(){
  docker_id=$(find_docker_id $PROJECT_CONTAINER_NAME)

  if [ $docker_id ] ; then
    echo 'Starting project container on docker'
    start_container $PROJECT_CONTAINER_NAME
    attach_to_container
  else
    echo 'Creating project container'

    cp Dockerfile.development Dockerfile
    docker build -t codelittinc/$PROJECT_NAME .
    rm Dockerfile
    docker run \
      -ti \
      --name $PROJECT_CONTAINER_NAME \
      -e $UPPERCASE_PROJECT_NAME'_DATABASE_PASSWORD'=postgres \
      -e $UPPERCASE_PROJECT_NAME'_DATABASE_USER'=postgres \
      -e SECRET_KEY=sk_test_y7BG4WqA1liD1mRIAO8Uciei \
      -e STRIPE_PUBLISHABLE_KEY=pk_test_LSVTyulbru3fsiBrYJdI8zjx \
      -v $(pwd):/share \
      -p 9018:3000 \
      -p 9019:8080 \
      --link $DB_CONTAINER_NAME:db codelittinc/$PROJECT_NAME /bin/bash -l
  fi
}

init(){
  run_db_container
  run_project_container

  echo -e "Next steps:\n"
  echo -e "\t1. Bundle install"
  echo -e "\t2. rake db:create"
  echo -e "\t3. run ./script/seed.sh from your docker host"
}

init
```

## 2. Dockerfiles used by above script 

### Dockerfile in your repo

This is the Dockerfile.development file that is called by the shell script above. The Dockerfile.production is similar. 

```shell
# This is our DEVELOPMENT dockerfile.
#
# This uses Codelitt's Ruby 2.2 image found at:
# https://github.com/codelittinc/dockerfiles/blob/master/ruby/Dockerfile
FROM codelittinc/ruby:2.2
MAINTAINER Codelitt, Inc.

# Mount any shared volumes from host to container @ /share
VOLUME ["/share"]

# Install dependencies and rails-api
RUN apt-get update \
	&& apt-get install -y nodejs \
	&& rm -rf /var/lib/apt/lists/* \
	&& gem install --no-rdoc --no-ri \
	rails-api

WORKDIR /share

CMD ["/bin/bash", "-l"]
```

###Base image called from Dockerfile.development

This is the base image called from Dockerfile.development. We maintain it [here](https://github.com/codelittinc/dockerfiles/blob/master/ruby/Dockerfile)

```shell
FROM ubuntu
MAINTAINER Tony Holdstock-Brown

RUN echo "$(cat /etc/apt/sources.list) universe multiverse" > /etc/apt/sources.list

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

RUN apt-get update \
    && apt-get install -y wget software-properties-common \
    && wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-add-repository ppa:brightbox/ruby-ng

RUN apt-get update \
    && apt-get install -y --force-yes \
    build-essential \
    curl \
    git \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev \
    libpq-dev \
    ruby2.2 \
    ruby2.2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler --no-ri --no-rdoc

EXPOSE 3000
```


## 3. The makefile for building assets

This makefile predefines several commands which build our assets and our frontend app (React) and is largely used with webpack. It lives alongside the Dockerfile.development and Dockerfile.production in the root directory of the repo.  


```shell
COFFEE_DIR = ./public/assets/coffee
JS_DIR = ./public/assets/js
SASS_DIR = ./public/assets/sass
CSS_DIR = ./public/assets/css
PID_FILE = .watchers

all: build

build: sass coffee require
prod: sass coffee require remove_js move_built_file

sass:
	@echo "Compiling SASS..."
	@`which sass` --compass --style=compressed ${SASS_DIR}:${CSS_DIR} --update

sass_watch:
	exec sass --watch public/assets/sass:public/assets/css -t compact --compass

webpack:
	@echo "Running webpack in watch mode"
	exec webpack --progress -cdw --display-error-details --display-chunks

minify:
	exec webpack --progress -cdp

watch:
	@echo "Running sass and webpack in watch mode"
	@`which sass` --watch public/assets/sass:public/assets/css -t compact --compass &> /dev/null & echo $$! >> ${PID_FILE}
	@`webpack -dw` assets/coffee public/assets/js &> /dev/null & echo $$! >> ${PID_FILE}

unwatch:
	@if [ -f ${PID_FILE} ]; then \
        echo 'Watchers stopped'; \
        for pid in `cat ${PID_FILE}`; do kill -9 $$pid; done; \
        rm ${PID_FILE}; \
	fi;
```
