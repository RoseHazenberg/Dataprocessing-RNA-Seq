args <- commandArgs(trailingOnly=TRUE)
a <- read.csv(args[1], header = T , check.names = F)
a1 <- t(a)
jpeg(args[2])
matplot(a1, type = c("b"), pch = 1:14, col = 1:14,
        xlab = "Sample pairs", ylab = "Relative Expression")
legend("bottomleft", legend = 1:14, col = 1:14, pch = 1:14, cex = 0.5)
dev.off()

library(ggplot2)
er <- read.csv(args[3], header = T , check.names = F, sep = ",", row.names = 1)
er$diffexpressed <- "NO"
er$diffexpressed[er$logFC > 0.6 & er$PValue < 0.05] <- "UP"
er$diffexpressed[er$logFC < -0.6 & er$PValue < 0.05] <- "DOWN"

jpeg(args[4])
ggplot(data = er, aes(x = logFC, y = -log10(PValue), col=er$diffexpressed)) +
  geom_point() +
  theme_minimal() +
  ggtitle("Volcano plot of DEG from edgeR") +
  geom_vline(xintercept=c(-0.6, 0.6), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red") +
  guides(col=guide_legend(title="differentially expressed"))
dev.off()