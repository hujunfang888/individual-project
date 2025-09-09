# for length distribution 
library(dplyr)

gene_pairs <- single_copy_df %>%
  select(
    Orthogroup,
    groen_id = groen,
    hap2_id  = hap2
  ) %>%
  filter(!is.na(groen_id), !is.na(hap2_id))

library(Biostrings)
library(dplyr)
library(ggplot2)

#read whole protein fasta of the Prokka product
groen_all <- readAAStringSet("groenlandica_large_contigs.faa")
hap2_all  <- readAAStringSet("hap2_large_contigs.faa")

# simplify the names in fasta to pure ID  , removing description
names(groen_all) <- sub(" .*", "", names(groen_all))
names(hap2_all)  <- sub(" .*", "", names(hap2_all))

# extract subsets according to gene_pairs
sel_groen_prot <- groen_all[ gene_pairs$groen_id ]
sel_hap2_prot  <- hap2_all[  gene_pairs$hap2_id  ]

# check if there is an ID that cannot be retrieved
miss_g <- setdiff(gene_pairs$groen_id, names(sel_groen_prot))
miss_h <- setdiff(gene_pairs$hap2_id,  names(sel_hap2_prot))
if(length(miss_g)) message("Groen missing：", paste0(miss_g, collapse=",")) 
if(length(miss_h)) message("Hap2 missing：",  paste0(miss_h, collapse=","))

# Calculate the length of each sequence
len_df <- tibble(
  Orthogroup = gene_pairs$Orthogroup,
  groen_len   = width(sel_groen_prot[gene_pairs$groen_id]),
  hap2_len    = width(sel_hap2_prot[ gene_pairs$hap2_id])
)

# simplely statistical differences
len_df %>% 
  summarise(
    mean_diff = mean(groen_len - hap2_len),
    sd_diff   = sd(groen_len - hap2_len)
  ) %>% print()

ggplot(len_df, aes(x = groen_len, y = hap2_len)) +
  geom_point(alpha = 0.6) +
  geom_abline(slope = 1, intercept = 0, 
              linetype = "dashed", color = "grey") +
  labs(
    title = "Comparison of lengths of Groen vs Hap2 single copy homologous proteins",
    x = "Groen protein length (aa)",
    y = "Hap2  protein length(aa)"
  ) +
  theme_bw()

# for sequence similarity

if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
BiocManager::install("pwalign")
library(pwalign)


library(Biostrings)
library(dplyr)


ids <- gene_pairs$groen_id

identity_vec <- vapply(seq_along(ids), function(i) {
  gid <- gene_pairs$groen_id[i]
  hid <- gene_pairs$hap2_id[i]
  aln <- pairwiseAlignment(
    sel_groen_prot[gid],
    sel_hap2_prot[hid],
    substitutionMatrix = "BLOSUM62",
    gapOpening = -10, gapExtension = -0.5
  )
  pid(aln) 
}, numeric(1))

# built result
id_df <- tibble(
  Orthogroup = gene_pairs$Orthogroup,
  identity   = identity_vec
)

print(summary(id_df$identity))

ggplot(id_df, aes(x = identity)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black") +
  labs(
    title = "Distribution of Pairwise Identity (%)",
    x     = "Global Identity (PID1)",
    y     = "Number of Orthogroups"
  ) +
  theme_minimal()


# The threshold 60% individually 
# whether their pairing is reliable or whether they are candidates with the largest functional differences:

library(dplyr)

threshold <- 60

#pick out highly conservative Orthogroup from id_df
high_ogs <- id_df %>%
  filter(identity >= threshold) %>%
  pull(Orthogroup)

#extract the gene IDs corresponding to these Orthogroups from gene_pairs
high_pairs <- gene_pairs %>%
  filter(Orthogroup %in% high_ogs)

#get ID lists for the two species separately
high_groen_ids <- high_pairs$groen_id
high_hap2_ids  <- high_pairs$hap2_id


writeLines(high_groen_ids, "high_identity_groen_ids.txt")
writeLines(high_hap2_ids,  "high_identity_hap2_ids.txt")
write.csv(high_pairs, "high_identity_gene_pairs.csv", row.names = FALSE)


