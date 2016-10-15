#!/usr/bin/env bash

set -e

dev="${1:-/dev/mmcblk0}"
part="${2:-p1}"
part_dev="${dev}${part}"
mnt='/mnt/rpi'

sudo apt-get install binutils-arm-none-eabi gcc-arm-none-eabi

# Generate kernel7.img
arm-none-eabi-as start.S -o start.o
arm-none-eabi-gcc -Wall -Werror -O2 -nostdlib -nostartfiles -ffreestanding -c main.c -o main.o
arm-none-eabi-ld start.o main.o -T ldscript -o main.elf
# Get the raw assembly out of the generated elf file.
arm-none-eabi-objcopy main.elf -O binary kernel7.img

# Get the firmware. Those are just magic blobs, likely compiled
# from some Broadcom proprietary C code which we cannot access.
wget -O bootcode.bin https://github.com/raspberrypi/firmware/blob/597c662a613df1144a6bc43e5f4505d83bd748ca/boot/bootcode.bin?raw=true
wget -O start.elf https://github.com/raspberrypi/firmware/blob/597c662a613df1144a6bc43e5f4505d83bd748ca/boot/start.elf?raw=true

# Prepare the filesystem.
sudo umount "$part_dev"
echo 'start=2048, type=c' | sudo sfdisk "$dev"
sudo mkfs.vfat "$part_dev"
sudo mkdir -p "$mnt"
sudo mount "${part_dev}" "$mnt"
sudo cp kernel7.img bootcode.bin start.elf "$mnt"

# Cleanup.
sync
sudo umount "$mnt"
