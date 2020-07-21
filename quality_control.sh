#!/bin/bash

mkdir ~/quality_control
READS=`ls /data/lrrnaseq/reads/ERR*.fastq.gz`

NanoPlot --fastq $READS \
--N50 \
-o ~/quality_control \
--readtype 2D

nanoQC -o ~/quality_control \
/data/lrrnaseq/reads/ERR3577080.fastq.gz
