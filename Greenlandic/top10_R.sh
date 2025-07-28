library(dplyr)
library(tidyr)

dup_groen_genes <- dup_groen %>%
  mutate(all_genes = paste(Genes.1, Genes.2, sep=",")) %>%
  mutate(all_genes = strsplit(all_genes, ",")) %>%
  dplyr::select(Orthogroup, all_genes) %>%  # force use of dplyr::select
  tidyr::unnest(all_genes)                  # force use of tidyr::unnest

dup_groen_genes <- dup_groen_genes %>%
  mutate(GeneID = all_genes %>% trimws() %>% 
           sub("^groen_", "", .) %>% sub("^hap2_", "", .)) %>%
  dplyr::select(-all_genes)


# 1. Expand each row to a small data.frame of (Orthogroup, rawGene)
lst <- mapply(function(og, g1, g2){
  genes <- c(strsplit(g1, ",")[[1]], strsplit(g2, ",")[[1]])
  data.frame(Orthogroup = og, raw = trimws(genes), stringsAsFactors=FALSE)
}, dup_groen$Orthogroup, dup_groen$Genes.1, dup_groen$Genes.2, SIMPLIFY=FALSE)

dup_groen_genes <- do.call(rbind, lst)

# 2. Clean the prefixes
dup_groen_genes$GeneID <- dup_groen_genes$raw %>%
  sub("^groen_", "", .) %>%
  sub("^hap2_",  "", .)

library(dplyr)

top10_ogs <- dup_groen_genes %>%
  count(Orthogroup, name="n_genes") %>%
  arrange(desc(n_genes)) %>%
  head(10)

print(top10_ogs)


print(top10_ogs)
   Orthogroup n_genes
1   OG0000110      62
2   OG0000128      59
3   OG0000207      51
4   OG0000259      45
5   OG0000283      44
6   OG0000317      41
7   OG0000341      40
8   OG0000394      35
9   OG0000413      34
10  OG0000479      33
