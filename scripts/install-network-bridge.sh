#!/bin/bash

# install dependencies
sudo apt-get install -y bridge-utils iptables dnsmasq

# disable dnsmasq, because we need it for QEMU NAT networking
sudo systemctl stop dnsmasq.service
sudo systemctl disable dnsmasq.service

# deploy QEMU bridge start script
cp /vagrant/files/etc/qemu-ifup-NAT /etc/qemu-ifup
chmod 755 /etc/qemu-ifup
cp /vagrant/files/etc/qemu-ifdown-NAT /etc/qemu-ifdown
chmod 755 /etc/qemu-ifdown
