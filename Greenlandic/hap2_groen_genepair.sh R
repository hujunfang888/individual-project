##extract direct one-to-one homologous gene pairs of hap2 and groen
library(dplyr)
library(readr)

# rread orthogonal group information
orthogroups <- read_tsv("Orthogroups.tsv")

# read single_copy
single_copy_ogs <- read_lines("Orthogroups_SingleCopyOrthologues.txt")

# filter out single copy orthogonal group data
single_copy_df <- orthogroups %>%
  filter(Orthogroup %in% single_copy_ogs)

names(single_copy_df)

# extract gene pairs of hap2 and groen
gene_pairs <- single_copy_df %>%
  rename(
    groenlandica_large_contigs.faa = groen,
    hap2_large_contigs.faa        = hap2
  ) %>%
  select(Orthogroup,
         groenlandica_large_contigs.faa,
         hap2_large_contigs.faa) %>%
  filter(!is.na(groenlandica_large_contigs.faa),
         !is.na(hap2_large_contigs.faa))


write.csv(gene_pairs, "hap2_groen_single_copy_orthologs.csv", row.names = FALSE)

head(gene_pairs)
