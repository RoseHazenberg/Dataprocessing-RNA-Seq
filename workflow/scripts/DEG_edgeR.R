library(edgeR)
args <- commandArgs(trailingOnly=TRUE)

counts <-read.csv(args[1], header = T, check.names = F, row.names = 1)
l <- apply(counts, 1, function(y){all(y==0)})
f <- counts[l,]
m <- match(row.names(f), row.names(counts))
xx <- counts[-m,]

group <- factor(c(1,2))
design <- model.matrix(~group)

y <- DGEList(counts = xx, group = group)
nF <- calcNormFactors(y)

bcv <- 0.1
et1 <- exactTest(nF, dispersion = bcv^2)
et1new <- cbind(et1$table, p.adjust(et1$table$PValue, method = "fdr"))
colnames(et1new) <- c("logFC","logCPM","PValue","adjsutedPValue")
write.csv(et1new, quote = FALSE, args[2])