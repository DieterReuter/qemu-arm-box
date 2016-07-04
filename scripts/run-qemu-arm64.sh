#!/bin/bash -x

# generate a random mac address for the QEMU nic
export MAC_ADDRESS=$(printf 'DE:AD:BE:EF:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)))
echo "MAC_ADDRESS=$MAC_ADDRESS"

# run the QEMU box
sudo qemu-system-aarch64 -m 512 -cpu cortex-a57 -M virt -nographic \
  -pflash $HOME/qemu/bootdisk/flash0.img \
  -pflash $HOME/qemu/bootdisk/flash1.img \
  -drive if=none,file=$HOME/qemu/images/arm64/xenial-server-cloudimg-arm64-uefi1-modified.img,id=hd0 \
  -device virtio-blk-device,drive=hd0 \
  -device virtio-net-device,netdev=net0,mac=$MAC_ADDRESS -netdev tap,id=net0
