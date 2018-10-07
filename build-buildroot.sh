#!/bin/bash

source "config/config.cfg"

#
# Make buildroot
#
cd ${BUILDROOT_DIR}
	# Config
	cp ../config/buildrootconfig.txt .config || exit -1
#	make clean || exit -1
#	make oldconfig || exit -1
#	make menuconfig || exit -1
	cp .config ../config/buildrootconfig.txt || exit -1

	# Make
	make || exit -1

	# Install
	mkdir -p ../${USB_BOOT_DIR}/BOOT
	cp .config ../${USB_BOOT_DIR}/BOOT/buildrootconfig.txt || exit -1
#	cp output/images/rootfs.cpio.gz /var/www/html/initrd.gz || exit -1
cd ..

