# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "geerlingguy/debian9"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  config.vm.define "control" do |machine|
    machine.vm.box = "geerlingguy/debian9"
    machine.vm.network "private_network", ip: "172.17.177.100"
    machine.vm.hostname = "control"
    machine.vm.provider "virtualbox" do |vb|
      vb.name = "curso-devops-control"
      vb.memory = "2048"
      vb.cpus = 1
      vb.gui = false
    end
    # control.vm.provision "shell", inline: "apt-get update && apt-get install vim -y"
    # machine.vm.provision "file", source: "./hosts", destination: "~"
    machine.vm.provision "shell", inline: "sudo mkdir -p /etc/ansible/ && sudo cp /vagrant/hosts /etc/ansible/"
    # machine.vm.provision "shell", path: "provision/update.sh"
    machine.vm.provision "shell", inline: "apt-get update && apt-get install python3 python3-pip -y && LANG=en_US.utf8 LC_ALL=en_US.utf8 pip3 install -q ansible"
    # control.vm.synced_folder ".", "/vagrant", disabled: true
    machine.vm.synced_folder "./configs", "/var/configs", owner: "root", group: "root"
  end

  config.vm.define "web" do |machine|
    machine.vm.box = "geerlingguy/debian9"
    machine.vm.network "private_network", ip: "172.17.177.101"
    machine.vm.hostname = "web"
    machine.vm.provider "virtualbox" do |vb|
      vb.name = "curso-devops-web"
      vb.memory = "512"
      vb.cpus = 1
      vb.gui = false
    end
    machine.vm.provision "shell", path: "provision/update.sh"
    machine.vm.synced_folder "./configs", "/var/configs", owner: "root", group: "root"
  end

  config.vm.define "db" do |machine|
    machine.vm.box = "geerlingguy/debian9"
    machine.vm.network "private_network", ip: "172.17.177.102"
    machine.vm.hostname = "db"
    machine.vm.provider "virtualbox" do |vb|
      vb.name = "curso-devops-db"
      vb.memory = "512"
      vb.cpus = 1
      vb.gui = false
    end
    machine.vm.provision "shell", path: "provision/update.sh"
    machine.vm.synced_folder "./configs", "/var/configs", owner: "root", group: "root"
  end

  config.vm.define "master" do |machine|
    machine.vm.box = "geerlingguy/centos7"
    machine.vm.network "private_network", ip: "172.17.177.110"
    machine.vm.hostname = "master"
    machine.vm.provider "virtualbox" do |vb|
      vb.name = "curso-devops-master"
      vb.memory = "1024"
      vb.cpus = 1
      vb.gui = false
    end
    machine.vm.synced_folder "./configs", "/var/configs", owner: "root", group: "root"
  end

  config.group.groups = {
    "control" => [
      "control",
    ],
    "clients" => [
      "web",
      "db",
    ],
    "nodes" => []
  }

  (1..3).each do |i|
    config.vm.define "node#{i}" do |machine|
      machine.vm.box = "geerlingguy/centos7"
      machine.vm.network "private_network", ip: "172.17.177.11#{i}"
      machine.vm.hostname = "node#{i}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "curso-devops-node#{i}"
        vb.memory = "512"
        vb.cpus = 1
        vb.gui = false
      end
    end
    config.group.groups["nodes"] << "node#{i}"
  end

#  config.group.groups = {
#    "control" => [
#      "control",
#    ],
#    "clients" => [
#      "web",
#      "db",
#    ],
#    "nodes" => [
#      "node1", "node2", "node3"
#    ]
#  }

end
