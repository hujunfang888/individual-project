# read orthogroup information and low similarity OG list
orthos <- read.table("Orthogroups.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE, quote = "")
lowid <- read.table("low_id_otho_gro_hap2.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

colnames(orthos)[1:3] <- c("Orthogroup", "groen", "hap2")
colnames(lowid)[1] <- "Orthogroup"

# only save low similarity
target_og <- orthos[orthos$Orthogroup %in% lowid$Orthogroup, ]

# obtain all protein IDs of groen and hap2 respectively
library(tidyr)
groen_ids <- unlist(strsplit(paste(target_og$groen, collapse=","), ",\\s*"))
hap2_ids  <- unlist(strsplit(paste(target_og$hap2, collapse=","), ",\\s*"))


groen_ids <- unique(groen_ids[groen_ids != ""])
hap2_ids  <- unique(hap2_ids[hap2_ids != ""])

writeLines(groen_ids, "groen_lowid.txt")
writeLines(hap2_ids,  "hap2_lowid.txt")

getwd()

groenlandica]$ seqkit grep -f groen_lowid.txt /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_output/groenlandica_large_contigs.faa > groen_largecontigs_lowid.fasta
