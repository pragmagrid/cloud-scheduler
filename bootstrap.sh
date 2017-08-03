#!/bin/bash
#
# Build and install npm and nodejs.
# Build node_modules as cloud scheduler GUI distro
# 

# googe drive link for rolls/cloud-scheduler/
export SURL="https://googledrive.com/host/0BzgozEGuMWotM21ZeS02dHJYek0"
. /opt/rocks/share/devel/src/roll/etc/bootstrap-functions.sh

# install nodejs
compile_and_install nodejs

# build node_modules and create distro tar file for building rpm
(cd src/gui; make prep)
