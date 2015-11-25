#!/bin/bash
#MAINTAINER Codelitt, Inc.

####### Project configuration example #######
PROJECT_NAME=outnix
PROJECT_MAIN_LANGUAGE=ruby
#############################################

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