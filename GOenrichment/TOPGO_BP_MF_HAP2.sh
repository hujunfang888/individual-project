library(topGO)
library(ggplot2)

low_ids <- unique(trimws(readLines("hap2_lowid.txt")))

go_data$goid <- sprintf("GO:%07d", as.integer(go_data$goid))
# BP
go_bp <- go_data[go_data$ontology == "BP", ]
gene2go_bp <- by(go_bp$goid, go_bp$qpid, function(x) unique(as.character(x)))
gene2go_list_bp <- as.list(gene2go_bp)

geneUniverse <- names(gene2go_list_bp)
geneList <- factor(as.integer(geneUniverse %in% low_ids))
names(geneList) <- geneUniverse
geneList <- factor(geneList, levels = c(0, 1))

library(topGO)

GOdata_BP <- new("topGOdata",
                 ontology = "BP",
                 allGenes = geneList,
                 annot = annFUN.gene2GO,
                 gene2GO = gene2go_list_bp)

# using Fisher to check accurately
resultFisher_BP <- runTest(GOdata_BP, algorithm = "classic", statistic = "fisher")

# select top 20 GO term results

allRes_BP <- GenTable(GOdata_BP,
                      classicFisher = resultFisher_BP,
                      orderBy = "classicFisher",
                      topNodes = 20)


print(allRes_BP)

write.table(allRes_BP, file = "topGO_BP_results.tsv", sep = "\t", quote = FALSE, row.names = FALSE)

# MF
#Filter MF type annotations
go_mf <- go_data[go_data$ontology == "MF", ]

# bulit gene2GO list
gene2go_mf <- by(go_mf$goid, go_mf$qpid, function(x) unique(as.character(x)))
gene2go_list_mf <- as.list(gene2go_mf)

geneUniverse <- names(gene2go_list_mf)
geneList <- factor(as.integer(geneUniverse %in% low_ids))
names(geneList) <- geneUniverse
geneList <- factor(geneList, levels = c(0, 1))

GOdata_MF <- new("topGOdata",
                 ontology = "MF",
                 allGenes = geneList,
                 annot = annFUN.gene2GO,
                 gene2GO = gene2go_list_mf)

resultFisher_MF <- runTest(GOdata_MF, algorithm = "classic", statistic = "fisher")

allRes_MF <- GenTable(GOdata_MF,
                      classicFisher = resultFisher_MF,
                      orderBy = "classicFisher",
                      topNodes = 20)

print(allRes_MF)

write.table(allRes_MF, file = "topGO_MF_results.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# Here is for bar graph
library(ggplot2)

ggplot(df, aes(x = Term, y = as.numeric(Significant))) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(x = "GO Term", y = "Number of Significant Genes", title = "GO Enrichment (MF)") +
  theme_bw()


library(ggplot2)

ggplot(allRes_BP, aes(x = reorder(Term, -Significant), y = Significant)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "GO Enrichment (BP)",
       x = "GO Term",
       y = "Number of Significant Genes") +
  theme_minimal()
