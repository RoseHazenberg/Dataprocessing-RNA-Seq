args <- commandArgs(trailingOnly=TRUE)
a <- read.csv(args[1], header = T , check.names = F)
a1 <- t(a)
jpeg(args[2])
matplot(a1, type = c("b"), pch = 1:14, col = 1:14,
        xlab = "Sample pairs", ylab = "Relative Expression")
legend("bottomleft", legend = 1:14, col = 1:14, pch = 1:14, cex = 0.5)
dev.off()