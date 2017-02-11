#!/bin/bash

# Exit this script if any errors are encountered
set -o errexit

# Exit this script if any unset bash variables are used
set -o nounset

# Provide verbose logging of installation with interpolated variables
set -o xtrace


NON_ESSENTIAL_BUILD="g++ make zlib1g-dev libc6-dev wget ca-certificates"

ESSENTIAL_BUILD=""

RUNTIME="libc6 zlib1g openjdk-7-jre-headless bc"

apt-get update --yes
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD} ${ESSENTIAL_BUILD}

export PATH=${PATH}:/usr/local/bin/install
light_assembler.sh
bbtools.sh

apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD}
apt-get install --yes --no-install-recommends ${ESSENTIAL_BUILD} ${RUNTIME}

# Clean up any no longer needed apt-files
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/tmp.*

# Remove all no-longer-required build artefacts
EXTENSIONS=("pyc" "c" "cc" "cpp" "h" "o" "pdf")
for EXT in "${EXTENSIONS[@]}"
do
	find /usr/local -name "*.$EXT" -delete
done
