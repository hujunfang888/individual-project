go_data$goid <- sprintf("GO:%07d", as.integer(go_data$goid))

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

# 运行 Fisher 精确检验
resultFisher_BP <- runTest(GOdata_BP, algorithm = "classic", statistic = "fisher")

# 提取前 20 个 GO term 结果
allRes


allRes_BP <- GenTable(GOdata_BP,
                      classicFisher = resultFisher_BP,
                      orderBy = "classicFisher",
                      topNodes = 20)

# 查看结果
print(allRes_BP)

# 保存为文件
write.table(allRes_BP, file = "topGO_BP_results.tsv", sep = "\t", quote = FALSE, row.names = FALSE)

####MF
# 筛选 MF 类型注释
go_mf <- go_data[go_data$ontology == "MF", ]

# 构建 gene2GO 列表
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

# 查看结果
print(allRes_MF)

# 保存为文件
write.table(allRes_MF, file = "topGO_MF_results.tsv", sep = "\t", quote = FALSE, row.names = FALSE)





###pics
library(ggplot2)

df$Term <- factor(df$Term, levels = rev(df$Term))

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

