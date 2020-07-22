#!/bin/bash

# mkdir ~/flair_output
# mkdir ~/logs

minimap2 \
-ax splice \
-G 500k \
/data/lrrnaseq/references/Homo_sapiens.GRCh38.dna.chromosome.12.fa \
/data/lrrnaseq/reads/batch_combined/cerebellum-5238.fastq.gz \
2> ~/logs/minimap2.log \
| samtools sort \
| samtools view -bh > ~/flair_output/CACNA1C_combined.bam

samtools index ~/flair_output/CACNA1C_combined.bam

# use hg38 in IGV for visualisation. works.

#
# python3 ./flair/bin/bam2Bed12.py \
# -i CACNA1C_combined.bam \
# > CACNA1C_combined.bed12
#
# python3 ./flair/flair.py correct \
# -q CACNA1C_combined.bed12 \
# -g ./reference/Homo_sapiens.GRCh38.dna.chromosome.12.fa \
# -f ./reference/Homo_sapiens.GRCh38.100.gtf \
# -o CACNA1C 2> flair_correct.log
#
# python3 ./flair/flair.py collapse \
# -g ./reference/Homo_sapiens.GRCh38.dna.chromosome.12.fa \
# -r ./reads/ERR3577099_1.fastq,./reads/ERR3577080_1.fastq.gz \
# -q CACNA1C_all_corrected.bed \
# -f ./reference/Homo_sapiens.GRCh38.100.gtf \
# -s 3 \
# -o CACNA1C.collapse \
# --keep_intermediate \
# 2> flair_collapse.log

# python3 ./flair/flair.py quantify \
# -r reads_manifest.tsv \
# -i CACNA1C.collapse.isoforms.fa \
# 2> flair_quantify.log

# python3 ./flair/flair.py diffExp \
# -q counts_matrix.tsv \
# -o diffexp \
# 2> flair_diffExp.log

# python3 ./flair/flair.py diffSplice \
# -i CACNA1C.collapse.isoforms.bed \
# -q counts_matrix.tsv \
# 2> flair_diffSplice.log

# python3 ./flair/bin/predictProductivity.py \
# -i CACNA1C.collapse.isoforms.bed \
# -g ./reference/Homo_sapiens.GRCh38.100.gtf \
# -f ./reference/Homo_sapiens.GRCh38.dna.chromosome.12.fa \
# --longestORF \
# 2> predictProductivity.log \
# > CACNA1C_productivity.bed

# export PATH=$PATH:/Users/geertvangeest/Documents/NCCR_summerschool/flair:/Users/geertvangeest/Documents/NCCR_summerschool/flair/bin
# cd ./flair/bin/
#
# python3 plot_isoform_usage.py \
# ../../CACNA1C_productivity.bed \
# ../../counts_matrix.tsv \
# ENSG00000151067
