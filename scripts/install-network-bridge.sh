#!/bin/bash

# install dependencies
sudo apt-get install -y bridge-utils iptables dnsmasq

# deploy QEMU bridge start script
cp /vagrant/files/etc/qemu-ifup /etc/qemu-ifup
chmod 755 /etc/qemu-ifup
