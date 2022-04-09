args <- commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1], header = T, check.names = F)
e1 <- "S1S2"
df["Sample1_Sample2"] <- e1
df1 <- df[,c("gene_id", "Sample1_Sample2")]
write.csv(df, quote = FALSE, row.names = FALSE, args[2])
write.csv(df1, quote = FALSE, row.names = FALSE, args[3])
