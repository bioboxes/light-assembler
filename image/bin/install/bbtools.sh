#!/bin/bash

URL="http://downloads.sourceforge.net/project/bbmap/BBMap_${BBMAP_VERSION}.tar.gz"
fetch_archive.sh ${URL} bbmap
ln -s /usr/local/bbmap/*.sh /usr/local/bin
