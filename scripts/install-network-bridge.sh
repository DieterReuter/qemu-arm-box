#!/bin/bash

# install dependencies
sudo apt-get install -y bridge-utils iptables dnsmasq

# disable dnsmasq, because we need it for QEMU NAT networking
sudo systemctl stop dnsmasq.service
sudo systemctl disable dnsmasq.service

# deploy QEMU bridge start script
sudo cp /vagrant/files/etc/qemu-ifup-NAT /etc/qemu-ifup
sudo chmod 755 /etc/qemu-ifup
sudo cp /vagrant/files/etc/qemu-ifdown-NAT /etc/qemu-ifdown
sudo chmod 755 /etc/qemu-ifdown
