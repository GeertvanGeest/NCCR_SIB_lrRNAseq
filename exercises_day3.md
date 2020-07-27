# Exercises day 3

## 3.1 Run DESeq2

Load the data into R and modify it to fit DESeq2:

```r
# read count data and metadata (coldata)
cts <- read.delim("~/flair_output/counts_matrix.tsv", row.names = 1)
coldata <- read.delim("~/reads_manifest.tsv", header = F)

# make sample names a bit shorter:
coldata$V1 <- gsub("dorsolateral_prefrontal", "dlp", coldata$V1)

# modify coldata
tiss_subj <- do.call(rbind, strsplit(coldata$V1, '-'))
coldata <- data.frame(tissue = factor(tiss_subj[,1]), subject = factor(tiss_subj[,2]), row.names = coldata$V1)

head(cts[,1:10])
head(coldata)

```

Make a DESeq2 object called `dds`:

```r
dds <- DESeq2::DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ tissue + subject)
```

Normalize the counts for visualisation:

```r
ntd <- normTransform(dds)
```

Let's start with a PCA:

```r
DESeq2::plotPCA(ntd, intgroup=c("tissue"))
DESeq2::plotPCA(ntd, intgroup=c("subject"))
```

It seems that cortex samples cluster, and cerebellum is most different from the rest. Let's change the experimental design:

```
coldata2 <- coldata
coldata2$tissue <- as.character(coldata2$tissue)
ewc <- endsWith(coldata2$tissue, "cortex")
coldata2$tissue[ewc] <- "cortex"

dds2 <- DESeq2::DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata2,
                              design = ~ tissue)
```

Let's compare all cortex sample with cerebellum samples:

```r
dds2 <- DESeq2::DESeq(dds2)

res <- DESeq2::results(dds2, contrast = c("tissue", "cerebellum", "cortex"))
```

And let's see which isoform is most significantly different between the two:

```r
plotCounts(dds2, gene=which.min(res$padj), intgroup="tissue")
```

## 3.2 Biological meaning

Try to answer one or both of the following questions:
* Which isoform is most differentially expressed between cerebellum and cortex? Is it a new isoform?
* Is there a difference between the relative number of productive expressed isoforms between the tissues?

Summarize your findings in a ~5-slide presentation to show to the other participants.
