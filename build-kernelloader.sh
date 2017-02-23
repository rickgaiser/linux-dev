#!/bin/bash

source "config/config.cfg"

#
# Make kernelloader
#
cd ${KERNELLOADER_DIR}
#	make clean || exit -1
	make || exit -1
	cp loader/kloader.elf ../${USB_BOOT_DIR}/BOOT/KLOADER.ELF || exit -1
cd ..

