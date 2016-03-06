#!/bin/bash
#MAINTAINER Codelitt, Inc.

####### Project configuration example #######
PROJECT_NAME=
PROJECT_MAIN_LANGUAGE=
#############################################

if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_MAIN_LANGUAGE" ]; then
  echo 'Please setup the PROJECT_NAME and the PROJECT_MAIN_LANGUAGE!'
  exit
fi

UPPERCASE_PROJECT_NAME=$(echo $PROJECT_NAME | tr '[a-z]' '[A-Z]')
ATTACH_ON_CONTAINER=$PROJECT_MAIN_LANGUAGE
DB_CONTAINER_NAME=$PROJECT_NAME-db
PROJECT_CONTAINER_NAME=$PROJECT_NAME-$PROJECT_MAIN_LANGUAGE

attach_to_project_container() {
  echo 'attaching to project container'
  docker attach $PROJECT_CONTAINER_NAME
}

start_container() {
  container_name=$1
  docker_id=$container_name
  for action in "stop" "start"
  do
    docker $action $docker_id
  done
}

run_db_container() {
  docker_id=$DB_CONTAINER_NAME
  if [ $docker_id ] ; then
    echo 'Starting db container on docker'
    start_container $DB_CONTAINER_NAME
  else
    echo 'Creating db container'
    docker run --name $DB_CONTAINER_NAME -e POSTGRES_PASSWORD=postgres -d postgres
  fi
}

run_project_container() {
  docker_id=$PROJECT_CONTAINER_NAME

  if [ $docker_id ] ; then
    echo 'Starting project container on docker'
    start_container $PROJECT_CONTAINER_NAME
    attach_to_project_container
  else
    echo 'Creating project container'

    cp Dockerfile.development Dockerfile
    docker build -t codelittinc/$PROJECT_NAME .
    rm Dockerfile
    docker run -d \
      -ti \
      --name $PROJECT_CONTAINER_NAME \
      -e $UPPERCASE_PROJECT_NAME'_DATABASE_PASSWORD'=postgres \
      -e $UPPERCASE_PROJECT_NAME'_DATABASE_USER'=postgres \
      -v $(pwd):/share \
      -p 9018:3000 \
      -p 9019:8080 \
      --link $DB_CONTAINER_NAME:db codelittinc/$PROJECT_NAME /bin/bash -l

    docker_id=$PROJECT_CONTAINER_NAME
    docker start $docker_id

    docker exec -it $docker_id echo 'Running bundle install'
    docker exec -it $docker_id bundle install
    docker exec -it $docker_id echo 'Setup the database'
    docker exec -it $docker_id rake db:setup
    docker exec -it $docker_id rake db:seed
    attach_to_project_container
  fi
}

init() {
  run_db_container
  run_project_container
}

init
