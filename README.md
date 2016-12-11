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


## Build plugins

 1) Install bundle and rake (gem install bundle rake)

 2) Install git (apt-get git)

 3) Install build essentials (apt-get build-essentials)

 4) If needed install new grub (apt-get upgrade rub)

 5) Move current Gemfile to \_Gemfile in both the plugins

 6) Run bundle init in both the plugins

 7) Move backup \_Gemfile to Gemfile in both the plugins

 8) Run bunle install in both the projects

 9) Run rake RuboCop task to correct errors rake rubocop:auto_correct

10) Run rake build and install tasks to complete : rake build install


# License

Licensed under the MIT(the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[https://opensource.org/licenses/MIT](https://opensource.org/licenses/MIT)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
