#!/bin/bash

URL="https://github.com/SaraEl-Metwally/LightAssembler/archive/${LIGHT_VERSION}.tar.gz"
fetch_archive.sh ${URL} light_assembler
cd /usr/local/light_assembler
make
mkdir bin
mv LightAssembler bin
ln -s /usr/local/light_assembler/bin/LightAssembler /usr/local/bin/
