begin
  require 'vagrant'
rescue LoadError
  raise 'The Vagrant RancherOs Commands plugin must be run within Vagrant'
end
begin
  require 'ipaddr'
rescue LoadError
  raise 'The Vagrant RancherOs Commands plugin must load ipaddr module'
end

IPAddr.class_eval do
  def to_cidr
    self.to_i.to_s(2).count("1")
  end
end
module VagrantPlugins
  module RancherosCommand
    class RancherosCommands < Vagrant.plugin("2")
      name "rancheros-commands"
      description <<-DESC
          A Vagrant plugin to automate commands for RancherOS.
          DESC
      def detect?(machine)
        machine.communicate.test("cat /bin/system-docker")
      end

      command "change-dns"  do
    	require_relative "cap/change_dns"
    	CommandImpl::ChangeDns
      end

    end
    module CommandImpl
    	class ChangeDns < Vagrant.plugin(2, :command)
        attr_reader :dnslist

        def initialize(dns_list)
          @dnslist      = dnslist
        end
        def self.change_dns(machine, network)
          with_target_vms(argv, reverse: true) do |machine|
            puts argv
            machine.communicate.tap do |comm|
          			comm.sudo("ros config set rancher.network.dns.nameservers [#{dnslist}]")
          		  comm.sudo("system-docker restart network")
          	end
          end
          0
        end
    	end
    end
  end
end
