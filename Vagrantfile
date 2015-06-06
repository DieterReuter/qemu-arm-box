# -*- mode: ruby -*-
# vi: set ft=ruby :

# this Vagrantfile only works with DigitalOcean so we set the default provider here
# so we can skip the --provider virtualbox option
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'digital_ocean'

Vagrant.configure('2') do |config|
  config.vm.define :"qemu-arm-box" do |box|
    box.ssh.forward_agent = true
    box.ssh.private_key_path = '~/.ssh/id_rsa'
    box.vm.hostname = "qemu-arm-box"
    box.vm.box = 'digital_ocean'
    box.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    box.vm.provision "shell", path: "scripts/provision.sh", privileged: false
    box.vm.provision "shell", path: "scripts/install-qemu-aarch64.sh", privileged: false
    box.vm.provision "shell", path: "scripts/install-uefi-bootdisk.sh", privileged: false
    box.vm.provision "shell", path: "scripts/install-image-ubuntu15.04-arm64.sh", privileged: false
    #box.vm.provision "shell", path: "scripts/install-network-bridge.sh", privileged: false
  end

  config.vm.provider :digital_ocean do |provider|
    provider.token = ENV['DIGITAL_OCEAN_TOKEN']
    provider.image = 'ubuntu-15-04-x64'
    provider.region = 'fra1'
    provider.size = '1gb'
  end
end
