# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  config.vm.post_up_message = "Vulnerable Web Forum Box Running!"
  config.vm.hostname = "vulnerableforum"
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 4567, host: 4567
  config.vm.network "private_network", ip: "192.168.100.100"
  config.vm.synced_folder ".", "/vulnerable_forum"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider "virtualbox" do |vb|
    vb.name = "VulnerableForum"
    vb.cpus = 2
    vb.memory = 2000
  end
  config.vm.provision "shell", path: "setup/apt_https.sh", privileged: false
  config.vm.provision "shell", path: "setup/apt_update.sh", privileged: false
  config.vm.provision "shell", path: "setup/ruby.sh",      privileged: false
  config.vm.provision "shell", path: "setup/passenger.sh", privileged: false
  config.vm.provision "shell", path: "setup/app.sh",       privileged: false
  config.vm.provision "shell", path: "setup/mysql.sh",     privileged: false
  config.vm.provision "shell", path: "setup/gems.sh",      privileged: false
end
