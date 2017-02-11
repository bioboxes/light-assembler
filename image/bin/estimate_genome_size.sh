#!/bin/bash

READS=$1

cd $(mktemp -d)

# Switch to 10x the estimated genome size as LightAssembler appears to fail
# otherwise. Described in further detail -
# https://github.com/SaraEl-Metwally/LightAssembler/issues/5
tadpole.sh in=${READS} out=contigs.fa overwrite=true > output.txt 2> /dev/null
SIZE=$(tail -n 10 output.txt | egrep "^\s*250" | tr -d ' ' | cut -f 5 | tr -d ',')
echo "${SIZE}*10" | bc
