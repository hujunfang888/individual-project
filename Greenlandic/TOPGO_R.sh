library(topGO)

# 读取 GO 注释文件（gene2go格式，无表头）
gene2go <- read.table("gene2go_topGO.txt", sep="\t", header=FALSE, stringsAsFactors=FALSE)
colnames(gene2go) <- c("gene", "go")

# 构建 gene2GO list
geneID2GO <- strsplit(gene2go$go, ",")
names(geneID2GO) <- gene2go$gene

ow_ids <- readLines("groen_lowid.txt")
all.genes <- names(geneID2GO_Groen_low)

geneList <- factor(as.integer(all.genes %in% low_ids))
names(geneList) <- all.genes
geneList <- factor(geneList, levels = c(0,1))



library(topGO)

GOdata <- new("topGOdata",
              ontology = "BP",
              allGenes = geneList,
              annot = annFUN.gene2GO,
              gene2GO = geneID2GO_Groen_low)

resultFisher <- runTest(GOdata, algorithm = "classic", statistic = "fisher")

allRes <- GenTable(GOdata, classicFisher = resultFisher, topNodes = 20)
print(allRes)

write.table(allRes, file = "topGO_lowid_results.txt", sep = "\t", quote = FALSE, row.names = FALSE)
