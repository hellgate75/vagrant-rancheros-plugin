#!/bin/sh
set -e
if [ "$1" == "--vagrant"]; then
  echo 'Uninstalling old vagrant plugins ....'
  vagrant plugin uninstall vagrant-rancheros-commands-plugin
  vagrant plugin uninstall vagrant-rancheros-vbadditions-plugin
  #scp from docker images
  echo 'Installing new vagrant plugins ....'
  vagrant plugin install vagrant-rancheros-commands-plugin
  vagrant plugin install vagrant-rancheros-vbadditions-plugin
  vagrant plugin license vagrant-rancheros-commands-plugin LICENSE
  vagrant plugin license vagrant-rancheros-vbadditions-plugin LICENSE
  vagrant plugin list
else
  cd vagrant-rancheros-commands-plugin
  echo 'Creating vagrant-rancheros-commands-plugin ...'
  mv -f Gemfile _Gemfile
  bundle init
  mv -f _Gemfile Gemfile
  bundle install
  rake --system --silent rubocop:auto_correct || echo "Specific errors in autocorrect ..."
  rake build install
  cd ../vagrant-rancheros-vbadditions-plugin
  echo 'Creating vagrant-rancheros-vbadditions-plugin ...'
  mv -f Gemfile _Gemfile
  bundle init
  mv -f _Gemfile Gemfile
  bundle install
  rake --system --silent rubocop:auto_correct || echo "Specific errors in autocorrect ..."
  rake build install
  echo 'Plugins created!!'
fi
