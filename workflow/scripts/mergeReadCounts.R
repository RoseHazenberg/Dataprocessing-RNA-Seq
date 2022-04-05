args = commandArgs(trailingOnly=TRUE)
s1 <- read.csv(args[1], header = T, sep = "", check.names = F)
s2 <- read.csv(args[2], header = T, sep = "", check.names = F)

s12 <- merge(s1, s2, by = "GeneID", all.x = T)
write.csv(s12, quote = FALSE, row.names = FALSE, args[3])