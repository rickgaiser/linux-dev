#!/bin/bash

cd "`dirname $0`" || error_exit
BASEDIR="`pwd`"
DEVICE=
STICK_SIZE_MB=480
GENTOO_ROOTFS=stage3-mipsel3-musl-vanilla-20160414.tar.bz2
RELEASE=ps2linux3.8_v0.3

error_exit()
{
	echo >&2 "Error occured"
	exit -1
}

usage()
{
	echo "$0 [parameters]"
	echo
	echo "This script builds a usb stick release for Playstation 2."
	echo
	echo "--device=            Set device (/dev/sd?)"
}

for arg; do
	param=
	case $arg in
	*=*)
		param="${arg/*=/}"
		;;
	esac
	case $arg in
	--device=*)
		DEVICE="$param"
		;;
	--help|-h)
		usage
		exit 0
		;;
	*)
		echo "Error: unknown parameter $arg"
		usage
		error_exit
		;;
	esac
done

# Zero out the block device (for better compression)
dd if=/dev/zero of=$DEVICE bs=1M count=$STICK_SIZE_MB

sleep 1

# Create partition layout
parted $DEVICE mklabel msdos
parted $DEVICE mkpart primary fat32         4   64
parted $DEVICE mkpart primary linux-swap   64  128
parted $DEVICE mkpart primary ext4        128  $STICK_SIZE_MB

sleep 1

# Format and name partitions
mkfs.vfat "$DEVICE"1 -n BOOT
mkswap    "$DEVICE"2 -L SWAP
mkfs.ext4 "$DEVICE"3 -L ROOT

# Download gentoo stage3
#wget http://distfiles.gentoo.org/experimental/mips/uclibc/mipsel3/stage3-mipsel3-uclibc-vanilla-20160410.tar.bz2
#wget http://distfiles.gentoo.org/experimental/mips/uclibc-ng/mipsel3/stage3-mipsel3-uclibc-vanilla-20160728.tar.bz2
#wget http://distfiles.gentoo.org/experimental/mips/musl/stage3-mipsel3-musl-vanilla-20160414.tar.bz2

# Install boot filesystem
mkdir tmp
mount "$DEVICE"1 tmp
cd tmp
cp -R ../boot-overlay/* .
cd ..
umount tmp
rm -rf tmp

# Install root filesystem
mkdir tmp
mount "$DEVICE"3 tmp
cd tmp

# buildroot
cp -R ../../buildroot/output/target/* .
cp -R ../root-overlay/* .
cp -R ../root-overlay-buildroot/* .
chown -R root:root *

# gentoo
#tar xvjpf ../$GENTOO_ROOTFS --xattrs
#cp -R ../root-overlay/* .
#cp -R ../root-overlay-gentoo/* .

cd ..
sync
umount tmp
rm -rf tmp

# Create distributable image
dd if=$DEVICE of=$RELEASE.img bs=1M count=$STICK_SIZE_MB
gzip -k $RELEASE.img

