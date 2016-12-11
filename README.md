## RancherOs Vagrant plugins

The vagrant machine doesn't support RancherOS for Virtual Box extensions or specific DNS change because it's managed with the ros command (RancherOS config command).

Provided Plugins :

1) vagrant-rancheros-commands-plugin - Provides features to modify the network

2) vagrant-rancheros-vbadditions-plugin - Provides features modify machine states during the Virtual Box Additions provisioning


## Requirements

1) Ruby < 3.0 and > 1.9 (I have tested successfully with Ruby 2.2.6)

2) Vagrant


## Getting started

_WIP_


## Docker build image (No suitable Ruby installed)

1) You can create a custom image with the Dockerfile e.g. :

     `docker build --force-rm --rm --no-cache --label 'Custom Vagrant Ruby 2.2.6 Docker Image' --tag custom-ruby:2.2.6-slim .`

2) You can run a container based on that image e.g. :

     `docker run -d -it --tty -v <my path>:/home/rake/vagrant-plugin --name custom-ruby-2.2.6 custom-ruby:2.2.6-slim`

3) Connect to the container e.g. :

     `docker exec -it --tty custom-ruby-2.2.6 bash`

4) You can follow the steps 5+ for the following 'Build plugins' section

(I have a script file :

  `./create-docker-image.sh`

  This script creates the docker image and accepts the parameter shrink to export and import a packed docker image :

*  `./create-docker-image.sh --shrink`

)

5) To execute the job from outsie the docker container you can run :

`docker exec -it --tty custom-ruby-2.2.6 bash build-install-plugin.sh`


## Build plugins

 1) Install bundle and rake (`gem install bundle rake`)

 2) Install git (`apt-get git`)

 3) Install build essentials (`apt-get build-essentials`)

 4) If needed install new grub (`apt-get upgrade rub`) - I have a specific setup script (`set-up-machine.sh`)

 5) Move current Gemfile to \_Gemfile in both the plugins (`mv Gemfile _Gemfile`)

 6) Run bundle init in both the plugins (`bundle init`)

 7) Move backup \_Gemfile to Gemfile in both the plugins (`mv _Gemfile Gemfile`)

 8) Run bundle install in both the projects (`bundle install`)

 9) Run rake RuboCop task to correct errors `rake rubocop:auto_correct`

10) Run rake build and install tasks to complete : `rake build install`

(The build steps from \#5 are available in the build script file : `build-install-plugin.sh`, outside the virtual machine you can use the same file with argument `--vagrant` to recover the plugins from the docker container and install in vagrant ...)

# License

Licensed under the [https://opensource.org/licenses/MIT](MIT "License") you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[https://opensource.org/licenses/MIT](https://opensource.org/licenses/MIT)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
