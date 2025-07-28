
# 读取orthogroup信息和低相似度OG列表
orthos <- read.table("Orthogroups.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE, quote = "")
lowid <- read.table("low_id_otho_gro_hap2.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# 保证列名正确
colnames(orthos)[1:3] <- c("Orthogroup", "groen", "hap2")
colnames(lowid)[1] <- "Orthogroup"

# 只保留低相似度OG
target_og <- orthos[orthos$Orthogroup %in% lowid$Orthogroup, ]

# 分别获取groen和hap2所有蛋白ID（去掉逗号和空格，展开为一列）
library(tidyr)
groen_ids <- unlist(strsplit(paste(target_og$groen, collapse=","), ",\\s*"))
hap2_ids  <- unlist(strsplit(paste(target_og$hap2, collapse=","), ",\\s*"))

# 去重（可选）
groen_ids <- unique(groen_ids[groen_ids != ""])
hap2_ids  <- unique(hap2_ids[hap2_ids != ""])

# 写入文件
writeLines(groen_ids, "groen_lowid.txt")
writeLines(hap2_ids,  "hap2_lowid.txt")

getwd()

groenlandica]$ seqkit grep -f groen_lowid.txt /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_output/groenlandica_large_contigs.faa > groen_largecontigs_lowid.fasta
