library(DESeq)
args = commandArgs(trailingOnly=TRUE)

s12 <- read.csv(args[1], header = T, check.names = F, row.names = 1)
condition <- factor(c("untreated", "treated"))
cds <- newCountDataSet(s12, condition)
norm <- estimateSizeFactors(cds)
disp <- estimateDispersions(norm, method = 'blind', sharingMode = 'fit-only')
res <- nbinomTest(disp, "untreated", "treated")
resSig <- res[res$padj < 0.5,]
write.csv(resSig, quote = FALSE, row.names = FALSE, args[2])