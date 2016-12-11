# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |s|
  s.name = 'vagrant-rancheros-commands-plugin'
  s.version     = '1.0.0'
  s.date        = '2016-12-10'
  s.summary     = 'RancherOS Commands'
  s.description = 'RancherOS Commands support commands for the Rancheros Vagrant Machine '
  s.authors     = ['Fabrizio Torelli']
  s.email       = 'hellgate75@gmail.com'
  s.homepage    = 'https://github.com/hellgate75/vagrant-rancheros-plugin.git'
  s.license = 'MIT'
  if s.respond_to?(:metadata=)
    s.metadata = {
      'allowed_push_host' => 'https://rubygems.org',
      'issue_tracker' => 'https://github.com/hellgate75/vagrant-rancheros-plugin/issues'
    }
    end

  s.files = ['README.md', 'Rakefile', 'LICENSE', 'locales/en.yml', 'lib/vagrant-rancheros-commands-plugin.rb']

  s.required_ruby_version     = '>= 2.0.0'
  s.required_rubygems_version = '>= 1.3.6'
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
  # s.files       = ["lib/vagrant-rancheros-commands-plugin.rb"]
  #		s.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
  #  	s.require_path  = 'lib'
end
