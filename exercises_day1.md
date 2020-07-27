# Exercises day 1

## 1.1 Quality control (individual; 30 minutes)

Check out the summary statistics and visualisations thereof of a single fastq file:
```
NanoPlot \
--fastq /data/lrrnaseq/reads/cerebellum-5238-batch2.fastq.gz \
--N50 \
--prefix cerebellum-5238-batch2_ \
-o ~/compare_nanoplot_fastqc
```

### Question 1.1A:
* Check out the file ... There seems to be a bias towards specific nucleotides in the beginning of the reads. Is that a problem?

## 1.2 Quality control (group work; 30 minutes)

Do QC on the same file with [`fastqc`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/). `fastqc` is preinstalled. Check out the helper of fastqc like so: `fastqc --help`.

### Question 1.2A:
* Compare the outputs of `fastqc` and `NanoPlot`. Do you have a preference for one of the two?

## 1.3 Read alignment (individual; 1 hour)

The sequence aligner [`minimap2`](https://github.com/lh3/minimap2) is specifically developed for (splice-aware) alignment of long reads. Checkout the helper `minimap2 --help` and/or the [github readme](https://github.com/lh3/minimap2).

### Question 1.3A:
* What would be the most logical parameter to the option `-x`?

Introns can be quite long in mammals; up to a few hundred kb. Look up the CACNA1C gene at the [UCSC genome browser](https://genome-euro.ucsc.edu/cgi-bin/hgGateway?redirect=manual&source=genome.ucsc.edu) and roughly estimate the length of the longest intron.

### Question 1.3B:
* How does this relate to the default parameter to option `-G` of `minimap2`?

Modify the command below for `minimap2` and run it from a script:

```
minimap2 \
-a \
-x [PARAMETER] \
-G [PARAMETER] \
/data/lrrnaseq/references/Homo_sapiens.GRCh38.dna.chromosome.12.fa \
/data/lrrnaseq/reads/cerebellum-5238-batch2.fastq.gz \
| samtools sort \
| samtools view -bh > ~/cerebellum-5238-batch2.bam

samtools index ~/cerebellum-5238-batch2.bam
```

## 1.4 Read alignment entire dataset (group work; 30 minutes)

Start the job for the read alignment for all the fastq files. It might run for more than an hour, so make sure you run it in the background with `nohup` (see README.md)

```
mkdir ~/read_alignment

minimap2 \
-a \
-x [PARAMETER] \
-G [PARAMETER] \
/data/lrrnaseq/references/Homo_sapiens.GRCh38.dna.chromosome.12.fa \
/data/lrrnaseq/reads/batch_combined/*.fastq.gz \
| samtools sort \
| samtools view -bh > ~/read_alignment/CACNA1C_combined.bam

samtools index ~/read_alignment/CACNA1C_combined.bam
```
