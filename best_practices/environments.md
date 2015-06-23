
This is a shell script which basically any engineer can run in development or production to spin everything up. It will live in `scripts/dev.sh`

```shell
#!/bin/bash

set -e

cp Dockerfile.development Dockerfile
docker build -t codelittinc/<project-name> .
rm Dockerfile

docker run --name <project-name>-db -e POSTGRES_PASSWORD=postgres -d postgres
docker run \
	-ti \
	--name <project-name>-ruby \
	-e <project-name>_DATABASE_PASSWORD=postgres \
	-v $(pwd):/share \
	-p 9018:3000 \
	-p 9019:8080 \
	--link <project-name>-db:db codelittinc/<project-name> /bin/bash -l

echo -e "Next steps:\n"
echo -e "\t1. Bundle install"
echo -e "\t2. rake db:create"
echo -e "\t3. run ./script/seed.sh from your docker host"
```

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


This make file predefines several commands which build our assets and our frontend app (React or Backbone depending)


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
