#!/bin/sh
gem install bundle rake
apt-get update
apt-get install vim git build-essential
apt-get upgrade grub
apt-get -y autoremove ;  apt-get -y clean ; rm -rf /var/lib/apt/lists/*
