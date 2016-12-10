#!/bin/sh
set -e
if [$1 == '--uninstall']; then
  echo 'Uninstalling old vagrant plugins ....'
  vagrant plugin uninstall vagrant-rancheros-commands-plugin
  vagrant plugin uninstall vagrant-rancheros-vbadditions-plugin
fi
echo 'Removing old gem files ....'
rm -f ./vagrant-rancheros-commands-plugin-1.0.0.gem
rm -f ./vagrant-rancheros-vbadditions-plugin-1.0.0.gem
echo 'Uninstalling old plugins ....'
gem uninstall 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-commands-plugin.gemspec'
gem uninstall 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-vbadditions-plugin.gemspec'
echo 'Removing old plugins ....'
rm -f 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-commands-plugin.gemspec'
rm -f 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-vbadditions-plugin.gemspec'
rm -f 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-commands-plugin-1.0.0.gem'
rm -f 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-vbadditions-plugin-1.0.0.gem'
echo 'Build new plugins ....'
gem build ./vagrant-rancheros-commands-plugin.gemspec
gem build ./vagrant-rancheros-vbadditions-plugin.gemspec
echo 'Copy plugins to vagrant ....'
cp ./definitions/vagrant-rancheros-commands-plugin.gemspec 'C:\HashiCorp\Vagrant\embedded\gems\specifications\'
cp ./vagrant-rancheros-commands-plugin-1.0.0.gem 'C:\HashiCorp\Vagrant\embedded\gems\cache\'
cp ./definitions/vagrant-rancheros-vbadditions-plugin.gemspec 'C:\HashiCorp\Vagrant\embedded\gems\specifications\'
cp ./vagrant-rancheros-vbadditions-plugin-1.0.0.gem 'C:\HashiCorp\Vagrant\embedded\gems\cache\'
echo 'Installing plugins ....'
gem install -g 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-commands-plugin.gemspec'
gem install -g 'C:\HashiCorp\Vagrant\embedded\gems\specifications\vagrant-rancheros-vbadditions-plugin.gemspec'
if [$2 == '--bundle']; then
  echo "Sorry not yet working ...."
#  rm -f *specs.*
#  rm -rf gems
#  mkdir gems
#  cp -f *.gem gems/
#  rm -rf specifications
#  mkdir specifications
#  cp -f *.gemspec specifications/
#  gem generate_index
#  echo 'Install bundles ....'
#  rm -rf ./executables
#  mkdir -p ./executables
#  bundle install --binstubs=./executables
else
  echo 'Not installing bundles ....'
  echo 'run with --bundle to install bundles'
fi
#echo 'Running rake ....'
#rake --rakefile ./vagrant-rancheros-vbadditions-plugin.rake
vagrant plugin install vagrant-rancheros-commands-plugin
vagrant plugin install vagrant-rancheros-vbadditions-plugin
vagrant plugin license vagrant-rancheros-commands-plugin LICENSE
vagrant plugin license vagrant-rancheros-vbadditions-plugin LICENSE
vagrant plugin list
