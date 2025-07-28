####MF_HAP2 VS GROEN

write.table(allRes_groen_MF,
            file = "topGO_MF_groen_results.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)

hap2_mf <- read.delim("topGO_MF_results.tsv", sep = "\t", stringsAsFactors = FALSE)
groen_mf <- read.delim("topGO_MF_groen_results.tsv", sep = "\t", stringsAsFactors = FALSE)

hap2_goids <- hap2_mf$GO.ID
groen_goids <- groen_mf$GO.ID

# 差异项
hap2_only <- setdiff(hap2_goids, groen_goids)
groen_only <- setdiff(groen_goids, hap2_goids)
common_goids <- intersect(hap2_goids, groen_goids)

# 输出数量
cat("hap2 独有 GO terms:", length(hap2_only), "\n")
cat("groen 独有 GO terms:", length(groen_only), "\n")
cat("共有 GO terms:", length(common_goids), "\n")

install.packages("VennDiagram")

library(VennDiagram)

venn.plot <- venn.diagram(
  x = list(hap2 = hap2_goids, groen = groen_goids),
  filename = NULL,
  fill = c("skyblue", "lightgreen"),
  alpha = 0.5,
  cex = 1.5,
  cat.cex = 1.5,
  cat.pos = c(-20, 20),
  main = "GO Term Overlap (MF)"
)

grid::grid.newpage()
grid::grid.draw(venn.plot)

hap2_only_terms <- hap2_mf[hap2_mf$GO.ID %in% hap2_only, c("GO.ID", "Term")]
groen_only_terms <- groen_mf[groen_mf$GO.ID %in% groen_only, c("GO.ID", "Term")]

print(hap2_only_terms)
print(groen_only_terms)


write.table(allRes_groen_BP,
            file = "topGO_BP_groen_results.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)

hap2_bp <- read.delim("topGO_BP_results.tsv", sep = "\t", stringsAsFactors = FALSE)
groen_bp <- read.delim("topGO_BP_groen_results.tsv", sep = "\t", stringsAsFactors = FALSE)

hap2_goids_bp <- hap2_bp$GO.ID
groen_goids_bp <- groen_bp$GO.ID

# 差异项
hap2_only_bp <- setdiff(hap2_goids_bp, groen_goids_bp)
groen_only_bp <- setdiff(groen_goids_bp, hap2_goids_bp)
common_goids_bp <- intersect(hap2_goids_bp, groen_goids_bp)

# 输出数量
cat("hap2 独有 GO terms (BP):", length(hap2_only_bp), "\n")
cat("groen 独有 GO terms (BP):", length(groen_only_bp), "\n")
cat("共有 GO terms (BP):", length(common_goids_bp), "\n")

hap2_only_terms_bp <- hap2_bp[hap2_bp$GO.ID %in% hap2_only_bp, c("GO.ID", "Term")]
groen_only_terms_bp <- groen_bp[groen_bp$GO.ID %in% groen_only_bp, c("GO.ID", "Term")]

print(hap2_only_terms_bp)
print(groen_only_terms_bp)


library(VennDiagram)


venn.diagram(
  x = list(hap2 = hap2_goids_bp, groen = groen_goids_bp),
  category.names = c("hap2", "groen"),
  filename = "Venn_GO_BP_hap2_vs_groen_colored.png",
  fill = c("skyblue", "salmon"),
  output = TRUE
)


