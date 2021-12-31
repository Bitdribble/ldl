#!/bin/bash

DOCKER_NAME=ldl
DOCKER_IMAGE=ldl

# Is an instance already running?
if [[ $(docker ps --filter name=$DOCKER_NAME -aq) ]]; then
  # Open a shell on that instance
  docker start $DOCKER_NAME >/dev/null 2>&1
  docker exec -it $DOCKER_NAME bash
  exit 0
fi

# Create a brand new instance, but don't make it interactive yet
docker run -it --name $DOCKER_NAME -v ~/build:/build $DOCKER_IMAGE
# Install emacs
docker exec $DOCKER_NAME "apt update; apt install -y emacs"

# Enter a shell
docker exec -it $DOCKER_NAME bash
exit 0
