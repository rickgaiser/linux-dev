#!/bin/bash

source "config/config.cfg"

./get-sources.sh || exit -1
./build-toolchain.sh || exit -1
./build-buildroot.sh || exit -1
./build-kernelloader.sh || exit -1
cp kernelloader/loader/kloader.elf ${USB_BOOT_DIR}/BOOT/KLOADER.ELF || exit -1
./build-firmware.sh || exit -1
./build-linux.sh || exit -1

#ls -l /var/www/html/

