#!/bin/sh
echo "Preconditions for creating the docker image custom-ruby:2.2.6-slim ..."
docker rmi -f custom-ruby:2.2.6-slim > /dev/null 2>&1
echo "Creating docker image custom-ruby:2.2.6-slim ..."
docker build --force-rm --rm --no-cache --label 'Custom Vagrant Ruby 2.2.6 Docker Image' --tag custom-ruby:2.2.6-slim .  > /dev/null 2>&1
if [ "$1" == "--shrink" ]; then
  echo "Exporting image as tarball file ...."
  docker save --output export-custom-ruby.tar custom-ruby:2.2.6-slim > /dev/null 2>&1
  echo "Removing current multi part image from docker ..."
  docker rmi -f custom-ruby:2.2.6-slim > /dev/null 2>&1
  echo "Loading archive image ..."
  docker load -q --input export-custom-ruby.tar
  echo "Removing tarball archive ...."
  rm -f export-custom-ruby.tar  > /dev/null 2>&1
  echo "Removing not necessary un-bounded image parts ...."
  docker images -a | grep '<none>' | awk 'BEGIN {FS = OFS = " "} {print $3}'| xargs docker rmi -f  > /dev/null 2>&1
fi

echo "Docker image creation completed!!"
