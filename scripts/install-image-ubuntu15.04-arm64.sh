#!/bin/bash -x

# download a ARM64 QEMU image
DIRECTORY="$HOME/qemu/images/arm64"
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
  cd $DIRECTORY

  if [ ! -f "vivid-server-cloudimg-arm64-uefi1.img" ]; then
    wget -q http://cloud-images.ubuntu.com/vivid/20150602/vivid-server-cloudimg-arm64-uefi1.img
  fi
fi
