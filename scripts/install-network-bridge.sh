#!/bin/bash

# install dependencies
sudo apt-get install -y bridge-utils iptables dnsmasq
sudo update-rc.d dnsmasq disable
sudo update-rc.d dnsmasq remove

# deploy QEMU bridge start script
cp /vagrant/files/etc/qemu-ifup-NAT /etc/qemu-ifup
chmod 755 /etc/qemu-ifup
cp /vagrant/files/etc/qemu-ifdown-NAT /etc/qemu-ifdown
chmod 755 /etc/qemu-ifdown