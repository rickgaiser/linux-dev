#!/bin/bash

source "config/config.cfg"

#
# Make iop modules
#
cd "${FIRMWARE_DIR}"
#	make clean || exit -1
	make || exit -1
	make install || exit -1
cd ..

