#!/bin/bash -x

# download a ARM64 QEMU image
DIRECTORY="$HOME/qemu/images/arm64"
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
  cd $DIRECTORY

  # download a stock Ubuntu Cloud Image
  if [ ! -f "vivid-server-cloudimg-arm64-uefi1.img" ]; then
    wget -q http://cloud-images.ubuntu.com/vivid/20150602/vivid-server-cloudimg-arm64-uefi1.img
  fi
fi

if [ -d "$DIRECTORY" ]; then
  cd $DIRECTORY

  # modify the image for using login credentials user=ubuntu,password=ubuntu
  if [ ! -f "vivid-server-cloudimg-arm64-uefi1-modified.img" ]; then
#---IMAGE-MOUNTING---
#qemu-img convert -c -O qcow2 vivid-server-cloudimg-arm64-uefi1.img vivid-server-cloudimg-arm64-uefi1-modified.img
cp vivid-server-cloudimg-arm64-uefi1.img vivid-server-cloudimg-arm64-uefi1-modified.img
qemu-img resize vivid-server-cloudimg-arm64-uefi1-modified.img 5G
sudo modprobe nbd
sudo qemu-nbd -c /dev/nbd0 `pwd`/vivid-server-cloudimg-arm64-uefi1-modified.img
mkdir -p image
sudo mount /dev/nbd0p1 image
#---IMAGE-MOUNTING---
#---IMAGE-MODIFICATION---
sudo sed -ri 's|(/boot/vmlinuz-3.19.0-18-generic\s*root=LABEL=cloudimg-rootfs.*)$|\1 ds=nocloud|' image/boot/grub/grub.cfg
sudo sed -ri 's|^(GRUB_CMDLINE_LINUX_DEFAULT=).*$|\1" ds=nocloud"|' image/etc/default/grub

sudo sed -ri 's|^#(GRUB_TERMINAL=console)$|\1|' image/etc/default/grub

sudo mkdir -p image/var/lib/cloud/seed/nocloud

sudo tee image/var/lib/cloud/seed/nocloud/meta-data <<EOF
instance-id: ubuntu
local-hostname: ubuntu
EOF

sudo tee image/var/lib/cloud/seed/nocloud/user-data <<EOF
#cloud-config
password: ubuntu
chpasswd: { expire: False }
ssh_pwauth: True
EOF

sudo sed -ri "s|^(127.0.0.1\s*localhost)$|\1\n127.0.0.1 `cat image/etc/hostname`|" image/etc/hosts
#---IMAGE-MODIFICATION---
#---IMAGE-UNMOUNTING---
sudo sync
sudo umount image
sudo qemu-nbd -d /dev/nbd0
sudo modprobe -r nbd
rm -fr image
#---IMAGE-UNMOUNTING---
  fi
fi
