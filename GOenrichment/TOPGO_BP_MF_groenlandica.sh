# here is for drawing BP
library(topGO)
gene2go <- read.table("gene2go_topGO_cptxt.txt", sep="\t", header=FALSE, stringsAsFactors=FALSE)
colnames(gene2go) <- c("gene", "go")

geneID2GO_groen <- strsplit(gene2go$go, ",")
names(geneID2GO_groen) <- gene2go$gene

low_ids_groen <- readLines("groen_lowid.txt")
geneUniverse <- names(geneID2GO_groen)
geneList_groen <- factor(as.integer(geneUniverse %in% low_ids_groen))
names(geneList_groen) <- geneUniverse
geneList_groen <- factor(geneList_groen, levels = c(0, 1))

library(topGO)
GOdata_groen_BP <- new("topGOdata",
                       ontology = "BP",
                       allGenes = geneList_groen,
                       annot = annFUN.gene2GO,
                       gene2GO = geneID2GO_groen)

resultFisher_groen_BP <- runTest(GOdata_groen_BP, algorithm = "classic", statistic = "fisher")

allRes_groen_BP <- GenTable(GOdata_groen_BP,
                            classicFisher = resultFisher_groen_BP,
                            orderBy = "classicFisher",
                            topNodes = 20)

print(allRes_groen_BP)


df <- allRes_groen_BP 


ggplot(df, aes(x = reorder(Term, Significant), y = Significant)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "GO Enrichment (BP) - Groen", x = "GO Term", y = "Number of Significant Genes") +
  theme_minimal()

go_data <- read.delim("GO_hap2_lowid.tsv..txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)


# here is for drawing MF
gene2go <- read.table("gene2go_topGO_cptxt.txt", sep="\t", header=FALSE, stringsAsFactors=FALSE)
colnames(gene2go) <- c("gene", "go")
geneID2GO_groen <- strsplit(gene2go$go, ",")
names(geneID2GO_groen) <- gene2go$gene

low_ids_groen <- readLines("groen_lowid.txt")

geneUniverse <- names(geneID2GO_groen)
geneList_groen <- factor(as.integer(geneUniverse %in% low_ids_groen))
names(geneList_groen) <- geneUniverse
geneList_groen <- factor(geneList_groen, levels = c(0, 1))

library(topGO)

GOdata_groen_MF <- new("topGOdata",
                       ontology = "MF",
                       allGenes = geneList_groen,
                       annot = annFUN.gene2GO,
                       gene2GO = geneID2GO_groen)

resultFisher_groen_MF <- runTest(GOdata_groen_MF, algorithm = "classic", statistic = "fisher")

allRes_groen_MF <- GenTable(GOdata_groen_MF,
                            classicFisher = resultFisher_groen_MF,
                            orderBy = "classicFisher",
                            topNodes = 20)
print(allRes_groen_MF)

library(ggplot2)

df <- allRes_groen_MF  


ggplot(df, aes(x = reorder(Term, Significant), y = Significant)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "GO Enrichment (MF) - Groen", x = "GO Term", y = "Number of Significant Genes") +
  theme_minimal()
