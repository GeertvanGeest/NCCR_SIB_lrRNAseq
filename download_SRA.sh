#!/bin/bash


cd /data/lrrnaseq/reads

# last two entries are raw data
for SRR in `tail -n +2 SraRunInfo.csv | head -24 | cut -f 1 -d ',' `
do
  echo $SRR

  prefetch $SRR && \
  fastq-dump \
  --gzip \
  $SRR
done
