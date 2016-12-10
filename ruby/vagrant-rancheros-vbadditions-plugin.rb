require 'ipaddr'

## Hacking this until we get a real plugin

# Borrowing from http://stackoverflow.com/questions/1825928/netmask-to-cidr-in-ruby
IPAddr.class_eval do
  def to_cidr
    self.to_i.to_s(2).count("1")
  end
end
guest "linux" do
  require_relative "rancheros-guest"
  RancherosGuest
end
class RancherosGuest < Vagrant.plugin("2", "rancheros-guest")
  name "rancheros-vbadditions"
  def detect?(machine)
    machine.communicate.test("cat /etc/myos-release")
  end
 
  guest_capability "linux", "change_host_name"  do
	require_relative "cap/change_host_name"
	Cap::ChangeHostName
  end

  guest_capability "linux", "configure_networks" do
	require_relative "cap/configure_networks"
	Cap::ConfigureNetworks
  end
end
class Command < Vagrant.plugin(2, :command)
  def execute(machine, networks)
    puts "Hello!"
    0
  end
end
module Cap
	class ConfigureNetworks
		def self.configure_networks(machine, networks)
			machine.communicate.tap do |comm|
				interfaces = []
				comm.sudo("ip link show|grep eth[1-9]|awk '{print $2}'|sed -e 's/:$//'") do |_, result|
					interfaces = result.split("\n")
				end

				networks.each do |network|
					dhcp = "true"
					iface = interfaces[network[:interface].to_i - 1]

					if network[:type] == :static
						cidr = IPAddr.new(network[:netmask]).to_cidr
						comm.sudo("ros config set rancher.network.interfaces.#{iface}.address #{network[:ip]}/#{cidr}")
						comm.sudo("ros config set rancher.network.interfaces.#{iface}.match #{iface}")

						dhcp = "false"
					end
					comm.sudo("ros config set rancher.network.interfaces.#{iface}.dhcp #{dhcp}")
				end

				comm.sudo("system-docker restart network")
			end
		end
	end
	class ChangeHostName
		def self.change_host_name(machine, name)
			machine.communicate.tap do |comm|
				if !comm.test("sudo hostname --fqdn | grep '#{name}'")
					comm.sudo("hostname #{name.split('.')[0]}")
				end
			end
		end
	end
end
