#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

# This used JQ syntax to fetch the fastq entries from the biobox.yaml file
INPUTS=$(biobox_args.sh 'select(has("fastq")) | .fastq | map(.value) | join(" ")')

# Fetch the task provided, for example this if the user provides the task "default"
# the args you have defined /usr/local/share/biobox/Taskfile are returned. This
# allows to create different ways of running the software.
FLAGS=$(fetch_task_from_taskfile.sh ${TASKFILE} $1)

# Create combined read file
READS=$(mktemp -d)/reads.fq.gz
cat ${INPUTS} > ${READS}

cd $(mktemp -d)

# Split into left and right read pairs
reformat.sh in=${READS} out=read_1.fq.gz out2=read_2.fq.gz

LightAssembler -G $(estimate_genome_size.sh ${READS}) -t $(nproc) -o genome read_1.fq.gz read_2.fq.gz

mv genome.contigs.fasta ${OUTPUT}/contigs.fa

cat << EOF > ${OUTPUT}/biobox.yaml
version: 0.9.0
arguments:
  - fasta:
    - id: contigs_1
      value: contigs.fa
      type: contigs
EOF

rm -rf /tmp/tmp.*
