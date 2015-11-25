Environments 
=======

We've fairly scripted method for maintaining environments across teams, staging, and production. The process/scripts below are for a standard Ruby/React stack, but these can be customized to fit your needs.

## 1. The bash script that starts it all
This is a shell script which basically any engineer can run in development or production to spin everything up. 
It will live in `bin/dev.sh`.
It handles the build of the docker images and containers. You can customize it to your liking and environment.

[environment.sh](https://github.com/codelittinc/incubator-resources/blob/master/best_practices/environments/environment.sh)

## 2. Dockerfiles used by above script 

### Dockerfile in your repo

This is the Dockerfile.development file that is called by the shell script above. The Dockerfile.production is similar.

[Dockerfile.development](https://github.com/codelittinc/incubator-resources/blob/master/best_practices/environments/Dockerfile.development)

### Base image called from Dockerfile.development

[Image](https://github.com/codelittinc/dockerfiles/blob/master/ruby/Dockerfile)

#### This uses Codelitt's Ruby image found at

[Ruby Dockerfile](https://github.com/codelittinc/dockerfiles/blob/master/ruby/Dockerfile)

## 3. The makefile for building assets

This makefile predefines several commands which build our assets and our frontend app (React) and is largely used with webpack. It lives alongside the Dockerfile.development and Dockerfile.production in the root directory of the repo.  

[Makefile](https://github.com/codelittinc/incubator-resources/blob/master/best_practices/environments/Makefile)
