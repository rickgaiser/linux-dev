#!/bin/bash

source "config/config.cfg"

#
# Get buildroot
#
if [ ! -d "${BUILDROOT_DIR}" ]; then
	git clone "${BUILDROOT_GIT}" "${BUILDROOT_DIR}" || exit -1
	cd "${BUILDROOT_DIR}" || exit -1
	git checkout "${BUILDROOT_BRANCH}" || exit -1
	cd .. || exit -1
fi

#
# Get kernelloader
#
if [ ! -d "${KERNELLOADER_DIR}" ]; then
	git clone "${KERNELLOADER_GIT}" "${KERNELLOADER_DIR}" || exit -1
	cd "${KERNELLOADER_DIR}" || exit -1
	git checkout "${KERNELLOADER_BRANCH}" || exit -1
	cd .. || exit -1
fi

#
# Get linux
#
if [ ! -d "${LINUX_DIR}" ]; then
	git clone "${LINUX_GIT}" "${LINUX_DIR}" || exit -1
	cd "${LINUX_DIR}" || exit -1
	git checkout "${LINUX_BRANCH}" || exit -1
	cd .. || exit -1
fi

#
# Get linux-firmware-ps2
#
if [ ! -d "${FIRMWARE_DIR}" ]; then
	git clone "${FIRMWARE_GIT}" "${FIRMWARE_DIR}" || exit -1
	cd "${FIRMWARE_DIR}" || exit -1
	git checkout "${FIRMWARE_BRANCH}" || exit -1
	cd .. || exit -1
fi

# Make toolchain dir
if [ ! -d "${TOOLCHAIN_DIR}" ]; then
	mkdir "${TOOLCHAIN_DIR}" || exit -1
fi

#
# Get binutils
#
if [ ! -d "${TOOLCHAIN_DIR}/${BINUTILS_DIR}" ]; then
	git clone "${BINUTILS_GIT}" "${TOOLCHAIN_DIR}/${BINUTILS_DIR}" || exit -1
	cd "${TOOLCHAIN_DIR}/${BINUTILS_DIR}" || exit -1
	git checkout "${BINUTILS_BRANCH}" || exit -1
	cd ../..
fi

#
# Get gcc
#
if [ ! -d "${TOOLCHAIN_DIR}/${GCC_DIR}" ]; then
	git clone "${GCC_GIT}" "${TOOLCHAIN_DIR}/${GCC_DIR}" || exit -1
	cd "${TOOLCHAIN_DIR}/${GCC_DIR}" || exit -1
	git checkout "${GCC_BRANCH}" || exit -1
	cd ../..
fi

