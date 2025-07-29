library(dplyr)
top_go <- gene2go_enricher %>%
  count(GO_ID, sort = TRUE) %>%
  top_n(20, n)  # 取前20条

desc_vec <- c(
  "nucleic acid binding",
  "DNA integration",
  "cellular process",
  "RNA-dependent DNA biosynthetic process",
  "RNA-directed DNA polymerase activity",
  "membrane",
  "endonuclease activity",
  "aspartic-type endopeptidase activity",
  "zinc ion binding",
  "nucleus",
  "calcium ion transmembrane transport",
  "oxidoreductase activity",
  "response to stimulus",
  "mitochondrion",
  "ATP binding",
  "integral component of membrane",
  "protein homodimerization activity",
  "DNA replication initiation",
  "external encapsulating structure",
  "external encapsulating structure organization",
  "cell projection membrane",
  "cell projection part",
  "cell projection",
  "ATP-dependent DNA helicase activity",
  "DNA-directed DNA polymerase activity",
  "organelle membrane",
  "DNA packaging",
  "ribonuclease H activity",
  "RNA-DNA hybrid ribonuclease activity",
  "DNA recombination",
  "DNA repair",
  "DNA binding",
  "regulation of transcription from RNA pol II promoter",
  "proteolysis",
  "spindle microtubule",
  "response to mechanical stimulus",
  "chromatin organization"
)

top_go$desc <- desc_vec

library(ggplot2)
ggplot(top_go, aes(x = reorder(desc, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(x = "GO Function", y = "Gene Count", title = "Top 20 GO Functions of Expanded Genes") +
  theme_minimal()


 ###bubble

 
library(ggplot2)
ggplot(top_go, aes(x = n, y = desc, size = n, color = n)) +
  geom_point(alpha = 0.8) +
  scale_size(range = c(2, 10)) +
  labs(x="Gene Count", y="GO Function", title="Bubble Plot of GO Annotation") +
  theme_bw(base_size = 14)

  
