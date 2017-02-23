#!/bin/bash

source "config/config.cfg"
MAKELINUX="make -j5 ARCH=mips CROSS_COMPILE=${CROSS_COMPILE}"

#
# Make linux kernel
#
cd ${LINUX_DIR}
	# Make sure we have the right branch
	git checkout ps2-v${LINUX_VERSION} || exit -1

	# Config
#	make mrproper || exit -1
	cp ../config/kernelconfig-v${LINUX_VERSION}.txt .config || exit -1
#	${MAKELINUX} clean || exit -1
#	${MAKELINUX} oldconfig || exit -1
#	${MAKELINUX} menuconfig || exit -1
	cp .config ../config/kernelconfig-v${LINUX_VERSION}.txt || exit -1

	# Make kernel
	${MAKELINUX} vmlinux || exit -1

	# Make modules
#	rm -rf ${ROOT_PART}/lib
	${MAKELINUX} modules || exit -1
	${MAKELINUX} INSTALL_MOD_PATH=../${USB_ROOT_DIR} INSTALL_MOD_STRIP=1 modules_install || exit -1

	# Install
	cp vmlinux vmlinux.strip || exit -1
	rm -f vmlinux.strip.gz || exit -1
	${CROSS_COMPILE}strip vmlinux.strip || exit -1
	gzip -9 vmlinux.strip || exit -1
	cp vmlinux.strip.gz /var/www/html/vmlinux.gz || exit -1
	cp vmlinux.strip.gz ../${USB_BOOT_DIR}/BOOT/vmlinux-v${LINUX_VERSION}.gz || exit -1
	cp .config ../${USB_BOOT_DIR}/BOOT/kernelconfig-v${LINUX_VERSION}.txt || exit -1
cd ..

