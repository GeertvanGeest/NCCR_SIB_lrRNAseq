# Exercises day 1

## 1.1 First login
><img border="0" src="https://www.svgrepo.com/show/14756/person-silhouette.svg" width="30" height="30"> 1 hour


### Login to AWS EC2 remote server
You will receive an e-mail shortly before the workshop with a key, username and IP address to login on a cloud server.
Login like this:

```sh
ssh -i path/to/key/key_[USERNAME].pem [USERNAME]@[AWS_IP]
```

### Initiate conda

Once you have logged in, initiate conda:

```sh
/opt/miniconda3/bin/conda init
```

This modifies your `.bashrc`. So logout and login again, and you can use conda.

### Setup your favourite editor to work remotely

To directly initiate and modify scripts on the remote server you can use plugins:
* Notepadd++: NppFTP
* Atom: remote-edit-ni

With the following details:
* protocol: sftp
* username: your username
* hostname: server IP
* port: 22
* authentication/logon type: path to private key file

## 1.2 Quality control
><img border="0" src="https://www.svgrepo.com/show/14756/person-silhouette.svg" width="30" height="30"> 30 minutes

Check out the summary statistics and visualisations of a single fastq file:

```sh
NanoPlot \
--fastq /data/lrrnaseq/reads/cerebellum-5238-batch2.fastq.gz \
--N50 \
--prefix cerebellum-5238-batch2_ \
-o ~/compare_nanoplot_fastqc
```

### Question 1.2A:
* Check out the file ... There seems to be a bias towards specific nucleotides in the beginning of the reads. Is that a problem?

## 1.3 Read alignment
><img border="0" src="https://www.svgrepo.com/show/14756/person-silhouette.svg" width="30" height="30"> 1 hour

The sequence aligner [`minimap2`](https://github.com/lh3/minimap2) is specifically developed for (splice-aware) alignment of long reads. Checkout the helper `minimap2 --help` and/or the [github readme](https://github.com/lh3/minimap2).

### Question 1.3A:
* What would be the most logical parameter for our dataset to the option `-x`?

Introns can be quite long in mammals; up to a few hundred kb. Look up the CACNA1C gene at the [UCSC genome browser](https://genome-euro.ucsc.edu/cgi-bin/hgGateway?redirect=manual&source=genome.ucsc.edu) and roughly estimate the length of the longest intron.

### Question 1.3B:
* How does this relate to the default parameter to option `-G` of `minimap2`?

Modify the command below for `minimap2` and run it from a script:

```sh
#!/usr/bin/env bash

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

## 1.4 Read alignment entire dataset
><img border="0" src="https://www.svgrepo.com/show/220819/group-team.svg" width="30" height="30"> 30 minutes

Start the job for the read alignment for all the fastq files. It might run for more than an hour, so make sure you run it in the background with `nohup` (see README.md)

```sh
#!/usr/bin/env bash

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
