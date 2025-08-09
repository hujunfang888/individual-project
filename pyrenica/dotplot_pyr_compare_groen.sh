library(data.table)
library(ggplot2)
library(patchwork)

# C.PYR vs hap2 
paf1 <- fread("CPYR002_vs_hap2.paf", sep="\t", header=FALSE, fill=TRUE)
colnames(paf1)[1:12] <- c("query","qlen","qstart","qend","strand","ref","rlen","rstart","rend","nmatch","alen","mapq")

p1 <- ggplot(paf1, aes(x=rstart, xend=rend, y=qstart, yend=qend)) +
  geom_segment(alpha=0.3, color="blue") +
  labs(x="hap2 large contigs", y="CPYR002 large contigs", title="Dotplot: PYR vs hap2") +
  theme_bw()

#groen vs hap2
paf2 <- fread("groen_vs_hap2.paf", sep="\t", header=FALSE, fill=TRUE)
colnames(paf2)[1:12] <- c("query","qlen","qstart","qend","strand","ref","rlen","rstart","rend","nmatch","alen","mapq")

p2 <- ggplot(paf2, aes(x=rstart, xend=rend, y=qstart, yend=qend)) +
  geom_segment(alpha=0.3, color="purple") +
  labs(x="hap2 large contigs", y="groen large contigs", title="Dotplot: groen vs hap2") +
  theme_bw()

#showing
p1 + p2 + plot_layout(ncol = 2)

