
getwd()

setwd("/Users/phoebe/Desktop/individual project/bigcontigs_real")

df <- read.delim("Orthogroups.tsv", header = TRUE, check.names = FALSE)
# View column names (make sure that the species columns are "groen" and "hap2")
colnames(df)

# Screen orthogonal groups where both species are not empty
common_orthogroups <- df[!is.na(df$groen) & !is.na(df$hap2), ]

write.csv(common_orthogroups, "common_orthogroups_groen_hap2.csv", row.names = FALSE)

# Screen orthogonal groups with genes in both species
common_orthogroups <- df[!is.na(df$groen) & !is.na(df$hap2), ]

# Only the orthogonal group name and two species gene ID are retained
result <- common_orthogroups[, c("Orthogroup", "groen", "hap2")]


write.csv(result, "common_orthogroups_groen_hap2.csv", row.names = FALSE)

single_copy <- common_orthogroups[!grepl(",", common_orthogroups$groen) & !grepl(",", common_orthogroups$hap2), ]
write.csv(single_copy, "single_copy_common_orthogroups.csv", row.names = FALSE)
