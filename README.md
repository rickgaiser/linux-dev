# linux-dev
Linux development environment for the Playstation2

This environment will download and build:
- kernelloader, needed to load a linux kernel on the ps2
- buildroot, used as the default root filesystem
- binutils, needed to build linux
- gcc, needed to build linux
- linux, the kernel itself
- firmware, these are modules running on the IOP

Required before installation:
- working ps2dev / ps2sdk environment
- git

To get started type:
- ./build-all.sh

Then to create a live USB stick type:
- cd usb-stick
- sudo ./create --device=/dev/sdX (be carefull, this will format the selected drive)
