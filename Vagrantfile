# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provision "init", type: "shell", path: "pre-install.sh"

  config.vm.define "git" do |git|
    git.vm.box = "ubuntu/bionic64"
    git.vm.hostname = 'git'

    git.vm.network :private_network, ip: "192.168.16.101"

    git.vm.provider "virtualbox" do |v|
      v.name = "git"
    end

    git.vm.provision "configure", type: "shell", path: "install-git-server.sh"
  end

  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "ubuntu/bionic64"
    ansible.vm.hostname = 'ansible'

    ansible.vm.network :private_network, ip: "192.168.16.103"

    ansible.vm.provider "virtualbox" do |v|
      v.name = "ansible"
    end

    ansible.vm.provision "configure", type: "shell", path: "install-ansible-server.sh"
  end
end
