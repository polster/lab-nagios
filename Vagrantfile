# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "inventory/hosts_dev"
    ansible.playbook = "site.yml"
    ansible.verbose = "extra"
  end

  config.vm.define "docker-node01-dev" do |machine|
    machine.vm.box = "centos/7"
    machine.vm.hostname = "docker-node01-dev"
    machine.vm.network :private_network, ip: "192.168.9.70"

    machine.vm.provider :virtualbox do |v, override|
     v.memory = "2048"
     v.name = "docker-node01-dev"
     v.cpus = 2
    end
  end

  config.vm.define "nagios-client01-dev" do |machine|
    machine.vm.box = "centos/7"
    machine.vm.hostname = "nagios-client01-dev"
    machine.vm.network :private_network, ip: "192.168.9.71"

    machine.vm.provider :virtualbox do |v, override|
     v.memory = "1024"
     v.name = "nagios-client01-dev"
     v.cpus = 1
    end
  end

end
