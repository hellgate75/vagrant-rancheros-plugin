# Dockerfile
# The FROM directive sets the Base Image for subsequent instructions
FROM ruby:2.2.6-slim

RUN ulimit -c unlimited
RUN ulimit -m unlimited
RUN ulimit -s unlimited
RUN ulimit -n 10000

MAINTAINER Fabrizio Torelli (hellgate75@gmail.com)

# Install bundle and rake
RUN gem install bundle rake

# ...
# Run updates
RUN apt-get update

# Install depts
RUN apt-get install -y -q --no-install-recommends \
    vim \
    git \
    build-essential

# Upgrde grub
RUN apt-get upgrade -y grub

# Clean and purge space
RUN  rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoclean \
    && apt-get -y clean

# Crate working directory and entry-point
RUN mkdir -p /home/rake/vagrant-plugin

# set working directory
WORKDIR /home/rake/vagrant-plugin

#Expose the volume
VOLUME ["/home/rake/vagrant-plugin"]
