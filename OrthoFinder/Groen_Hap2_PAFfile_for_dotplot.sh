# Since there are too many slurm submitted, this is done in the local terminal, and groen_vs_hap2.paf is generated:
   groenlandica]$ minimap2 -x asm5 -t 8 CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa > groen_vs_hap2.paf
[M::mm_idx_gen::2.859*1.17] collected minimizers
[M::mm_idx_gen::3.094*1.67] sorted minimizers
[M::main::3.094*1.67] loaded/built the index for 51 target sequence(s)
[M::mm_mapopt_update::3.296*1.62] mid_occ = 204
[M::mm_idx_stat] kmer size: 19; skip: 19; is_hpc: 0; #seq: 51
[M::mm_idx_stat::3.460*1.59] distinct minimizers: 13536264 (87.13% are singletons); average occurrences: 1.710; average spacing: 9.981; total length: 230980628
[M::worker_pipeline::42.109*4.90] mapped 7 sequences
[M::main] Version: 2.30-r1287
[M::main] CMD: minimap2 -x asm5 -t 8 CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa
[M::main] Real time: 42.171 sec; CPU: 206.226 sec; Peak RSS: 9.157 GB #Generate groen_vs_hap2.paf

# Here is for dotplot on R
library(data.table)
library(ggplot2)
library(patchwork)

# this step is C.PYR vs hap2 
paf1 <- fread("CPYR002_vs_hap2.paf", sep="\t", header=FALSE, fill=TRUE)
colnames(paf1)[1:12] <- c("query","qlen","qstart","qend","strand","ref","rlen","rstart","rend","nmatch","alen","mapq")

p1 <- ggplot(paf1, aes(x=rstart, xend=rend, y=qstart, yend=qend)) +
  geom_segment(alpha=0.3, color="blue") +
  labs(x="hap2 large contigs", y="CPYR002 large contigs", title="Dotplot: PYR vs hap2") +
  theme_bw()

#this step is groen vs hap2
paf2 <- fread("groen_vs_hap2.paf", sep="\t", header=FALSE, fill=TRUE)
colnames(paf2)[1:12] <- c("query","qlen","qstart","qend","strand","ref","rlen","rstart","rend","nmatch","alen","mapq")

p2 <- ggplot(paf2, aes(x=rstart, xend=rend, y=qstart, yend=qend)) +
  geom_segment(alpha=0.3, color="purple") +
  labs(x="hap2 large contigs", y="groen large contigs", title="Dotplot: groen vs hap2") +
  theme_bw()

#showing togetehr
p1 + p2 + plot_layout(ncol = 2)
