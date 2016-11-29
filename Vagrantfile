# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Boxes: https://atlas.hashicorp.com/search
  config.vm.box = 'ubuntu/xenial64'

  # Set hostname
  config.vm.hostname = 'test'

  # Configure node
  config.vm.provider 'virtualbox' do |vb|
    # Customize the amount of memory and cpus on the VM:
    vb.memory = '512'
    vb.cpus = '1'
  end

  # Provision
  config.vm.provision 'shell', inline: <<-SHELL
    # Update APT
    apt-get -qy update && apt-get -qy upgrade
  SHELL
end
