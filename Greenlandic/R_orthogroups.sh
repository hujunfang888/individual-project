# 载入数据
getwd()

setwd("/Users/phoebe/Desktop/individual project/bigcontigs_real")

df <- read.delim("Orthogroups.tsv", header = TRUE, check.names = FALSE)
# 查看列名（确保物种列是否是 "groen" 和 "hap2"）
colnames(df)

# 筛选两个物种都非空的正交群
common_orthogroups <- df[!is.na(df$groen) & !is.na(df$hap2), ]

# 保存结果
write.csv(common_orthogroups, "common_orthogroups_groen_hap2.csv", row.names = FALSE)

# 筛选两个物种都有基因的正交群
common_orthogroups <- df[!is.na(df$groen) & !is.na(df$hap2), ]

# 只保留正交群名和两个物种基因ID
result <- common_orthogroups[, c("Orthogroup", "groen", "hap2")]

# 保存结果到文件
write.csv(result, "common_orthogroups_groen_hap2.csv", row.names = FALSE)
# 可选：筛选单拷贝共同基因
single_copy <- common_orthogroups[!grepl(",", common_orthogroups$groen) & !grepl(",", common_orthogroups$hap2), ]
write.csv(single_copy, "single_copy_common_orthogroups.csv", row.names = FALSE)
