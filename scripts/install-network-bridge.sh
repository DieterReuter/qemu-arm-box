#!/bin/bash

# install dependencies
sudo apt-get install -y bridge-utils

# define bridge
sudo tee -a /etc/network/interfaces <<EOF

auto br0
iface br0 inet dhcp
    bridge_ports eth0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0
EOF

# create bridge device
brctl addbr br0

# deplay QEMU bridge start script 
cp /vagrant/files/etc/qemu-ifup-br /etc/qemu-ifup-br
