#!/usr/bin/env bash
#
# NanoPlot \
# --fastq /data/reads/lrrnaseq/parietal_cortex-5238-batch1.fastq.gz \
# --N50 \
# --prefix parietal_cortex-5238-batch1_ \
# -o ~/nanoplot
#
# nanoQC \
# -o ~/nanoplot \
# /data/reads/lrrnaseq/parietal_cortex-5238-batch1.fastq.gz

## approx. 10 minutes on 3 cores
# minimap2 \
# -a \
# -x splice \
# -G 500k \
# /data/references/GRCh38.p13.chr12.fa \
# /data/reads/lrrnaseq/parietal_cortex-5238-batch1.fastq.gz \
# | samtools sort \
# | samtools view -bh > ~/parietal_cortex-5238-batch1.bam
#
# samtools index ~/parietal_cortex-5238-batch1.bam

mkdir ~/read_alignment

minimap2 \
-a \
-x splice \
-G 500k \
/data/references/GRCh38.p13.chr12.fa \
/data/reads/lrrnaseq/batch_combined/*.fastq.gz \
| samtools sort \
| samtools view -bh > ~/read_alignment/CACNA1C_combined.bam

samtools index ~/read_alignment/CACNA1C_combined.bam
