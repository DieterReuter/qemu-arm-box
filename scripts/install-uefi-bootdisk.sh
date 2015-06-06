#!/bin/bash -x

# create a UEFI boot disk for QEMU
DIRECTORY="$HOME/qemu/bootdisk"
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
  cd $DIRECTORY

  if [ ! -f "QEMU_EFI.fd" ]; then
    wget -q http://releases.linaro.org/15.01/components/kernel/uefi-linaro/release/qemu64-intelbds/QEMU_EFI.fd
  fi

  if [ ! -f "flash0.img" ]; then
    dd if=/dev/zero of=flash0.img bs=1M count=64
    dd if=QEMU_EFI.fd of=flash0.img conv=notrunc
  fi

  if [ ! -f "flash1.img" ]; then
    dd if=/dev/zero of=flash1.img bs=1M count=64
  fi
fi
