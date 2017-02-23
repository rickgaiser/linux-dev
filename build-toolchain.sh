#!/bin/bash

source "config/config.cfg"

#
# Make binutils and gcc for compiling linux
#
#   NOTE1: buildroot compiles its own toolchains (can we change this?)
#   NOTE2: firmware (iop modules) needs the ps2sdk toolchain
#
cd "${TOOLCHAIN_DIR}"
	# Change to another binutils branch?
#	cd "${BINUTILS_DIR}"
#	git checkout ps2-v2.24 || exit -1
#	cd ..

	# Change to another gcc branch?
#	cd "${GCC_DIR}"
#	git checkout ps2-v4.9.0 || exit -1
#	cd ..

	# Remove the next line to rebuild the entire toolchain
#	rm -rf build
	if [ ! -d build ]; then
		mkdir build || exit -1
	fi

	cd build
		# Remove the next line to rebuild binutils
#		rm -rf "${BINUTILS_DIR}"
		if [ ! -d "${BINUTILS_DIR}" ]; then
			mkdir "${BINUTILS_DIR}" || exit -1
			cd "${BINUTILS_DIR}"
			../../${BINUTILS_DIR}/configure --program-prefix="${TOOLCHAIN_PROGRAMPREFIX}" --target=${TOOLCHAIN_TARGET} --enable-targets=${TOOLCHAIN_TARGET} --enable-shared --enable-plugins || exit -1
			make -j 5 || exit -1
			sudo make install || exit -1
			cd ..
		fi

		# Remove the next line to rebuild gcc
#		rm -rf "${GCC_DIR}"
		if [ ! -d "${GCC_DIR}" ]; then
			mkdir "${GCC_DIR}" || exit -1
			cd "${GCC_DIR}"
			../../${GCC_DIR}/configure --program-prefix="${TOOLCHAIN_PROGRAMPREFIX}" --target=${TOOLCHAIN_TARGET} --enable-languages=c --disable-nls --disable-shared --disable-libssp --disable-libmudflap --disable-threads --disable-libgomp --disable-libquadmath --disable-target-libiberty --disable-target-zlib --without-ppl --without-cloog --with-headers=no --disable-libada --disable-libatomic || exit -1
			make -j 5 || exit -1
			sudo make install || exit -1
			cd ..
		fi
	cd ..
cd ..

