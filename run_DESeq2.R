cts <- read.delim("~/flair_output/counts_matrix.tsv", row.names = 1)
coldata <- read.delim("~/reads_manifest.tsv", header = F)
coldata$V1 <- gsub("dorsolateral_prefrontal", "dlp", coldata$V1)
tiss_subj <- do.call(rbind, strsplit(coldata$V1, '-'))
coldata <- data.frame(tissue = factor(tiss_subj[,1]), subject = factor(tiss_subj[,2]), row.names = coldata$V1)


library(DESeq2)

dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ tissue + subject)
dds <- DESeq(dds)

ntd <- normTransform(dds)
vsd <- varianceStabilizingTransformation(dds)
rld <- rlog(dds, blind=FALSE)

library("vsn")
meanSdPlot(assay(ntd))

library("pheatmap")
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:30]
df <- as.data.frame(colData(dds)[,c("subject","tissue")])
pheatmap(assay(ntd)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=TRUE, annotation_col=df)

df <- as.data.frame(colData(dds)[,c("tissue","subject")])
pheatmap(assay(ntd)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)

pheatmap(assay(vsd)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)

pheatmap(assay(rld)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)

sampleDists <- dist(t(assay(ntd)))

library("RColorBrewer")
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$tissue, vsd$subject, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)

DESeq2::plotPCA(vsd, intgroup=c("tissue"))
DESeq2::plotPCA(vsd, intgroup=c("subject"))
