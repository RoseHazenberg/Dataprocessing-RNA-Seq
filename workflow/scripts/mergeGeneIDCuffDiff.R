args <- commandArgs(trailingOnly=TRUE)
sC <- read.csv(args[1], header = T,check.names = F, sep = "")
sD <- read.csv(args[2], header = T, check.names = F, sep = ",")
sE <- read.csv(args[3], header = T, check.names = F, sep = ",")
geneidname <- read.csv(args[4], header = T, check.names = F)
a1 <- sC[which(sC$q_value <= 0.05),]
a2 <- sD[which(sD$padj <= 0.05),]
a3 <- sE[which(sE$FDR<= 0.05),]
a1g <- merge(a1, geneidname, by = "gene", all.x = T)
write.csv(a1g, quote = FALSE, row.names = FALSE, args[5])
write.csv(a2, quote = FALSE, row.names = FALSE, args[6])
write.csv(a3, quote = FALSE, row.names = FALSE, args[7])

sC <- read.csv(args[1], header = T, check.names = F, sep = "")
sD <- read.csv(args[2], header = T, check.names = F, sep = ",")
sE <- read.csv(args[3], header = T, check.names = F, sep = ",")
sCD <- merge(sC, sD, by.x = "gene_id", by.y = "id", all.x = T)
colnames(sE)[1] <- c('id')
sCDE <- merge(sCD, sE, by.x = "gene_id", by.y = "id", all.x = T)
write.csv(sCDE, quote = FALSE, row.names = FALSE, args[8])