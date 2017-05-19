#!/bin/bash
#
# Build and install npm and nodejs.
# Build node_modules as cloud scheduler GUI distro
# 

. /opt/rocks/share/devel/src/roll/etc/bootstrap-functions.sh

# install nodejs
compile_and_install nodejs

# build node_modules and create distro tar file for building rpm
(cd src/gui; make prep)
