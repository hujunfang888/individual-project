# Comparative genomics of Cochlearia danica haplotype 2 and its putative parental species
## Background
Allopolyploid species arise from hybridization between different parental species, combining two or more distinct genomes. Cochlearia danica is an allopolyploid plant with multiple haplotypes, and its origin has been debated. In this study, we focus on haplotype 2 (hap2) and compare it with two putative parents: C. groenlandica and C. pyrenica.
The goals are to:
Assess genome quality and select suitable assemblies for comparison.
Compare genome-wide similarity, structural conservation, and transposable element (TE) composition.
Identify functional gene divergence that may underlie adaptive evolution after allopolyploidization.
## Workflow
### 
    A[Genome assemblies] --> B[Quality assessment: gfastats + Compleasm]
    B --> C[Filter contigs by length]
    C --> D[TE annotation: EDTA + RepeatMasker]
    C --> E[Whole-genome similarity: Mash + minimap2]
    C --> F[Protein annotation: Prokka]
    F --> G[Orthology inference: OrthoFinder]
    G --> H[Pairwise identity & length distribution]
    H --> I[Low-identity gene set (<60%)]
    I --> J[GO annotation & enrichment: PANNZER2 + clusterProfiler + topGO]
    D --> K[TE composition analysis: R + PCA + stacked bar plots]
    E --> L[Dotplot visualisation]
    
##  Scripts Index 
### Genome quality assessment
| Script                                                         | Species     | Function                                  | Input        | Output                 |
| -------------------------------------------------------------- | ----------- | ----------------------------------------- | ------------ | ---------------------- |
| `compleasm_large_contigs_10mb` / `compleasm_large_contigs_1mb` | all         | Compleasm (BUSCO) assembly completeness   | `.fa` genome | BUSCO/Compleasm report |
| `compleasm_large_and_small_10mb`                               | Greenlandic | Compleasm with multiple length thresholds | `.fa` genome | BUSCO/Compleasm report |
| `gfastats.sh`                                                  | all         | Contig statistics                         | `.fa` genome | `.tsv` summary         |

### TE annotation & analysis
| Script                                                         | Species     | Function                                  | Input        | Output                 |
| -------------------------------------------------------------- | ----------- | ----------------------------------------- | ------------ | ---------------------- |
| `compleasm_large_contigs_10mb` / `compleasm_large_contigs_1mb` | all         | Compleasm (BUSCO) assembly completeness   | `.fa` genome | BUSCO/Compleasm report |
| `compleasm_large_and_small_10mb`                               | Greenlandic | Compleasm with multiple length thresholds | `.fa` genome | BUSCO/Compleasm report |
| `gfastats.sh`                                                  | all         | Contig statistics                         | `.fa` genome | `.tsv` summary         |

### Gene annotation & orthology
| Script                                          | Species     | Function                      | Input             | Output          |
| ----------------------------------------------- | ----------- | ----------------------------- | ----------------- | --------------- |
| `prokka.sh` / `prokka_gro.sh` / `prokka_pyr.sh` | all         | Prokka gene annotation        | `.fa` genome      | `.gff` / `.faa` |
| `othofinder.sh` / `pyr_vs_hap2_Othofinder.sh`   | all         | Run OrthoFinder               | protein `.faa`    | orthogroups     |
| `R_orthogroups.sh`                              | Greenlandic | Parse OrthoFinder outputs     | orthogroups table | `.tsv`          |
| `hap2_groen_genepair.sh R`                      | Greenlandic | Extract 1-to-1 ortholog pairs | orthogroups       | gene pair list  |

### Functional enrichment
| Script                                                    | Species              | Function                               | Input               | Output           |
| --------------------------------------------------------- | -------------------- | -------------------------------------- | ------------------- | ---------------- |
| `seqkit.sh` / `seqkit_high.sh` / `seqkit_for_pannzer2.sh` | all                  | Extract protein sequences for PANNZER2 | `.faa`              | `.faa` subset    |
| `eggnog.sh` / `eggnog_anno.sh`                            | danica / Greenlandic | EggNOG annotation                      | `.faa`              | functional table |
| `topgo.R`                                                 | danica               | GO enrichment analysis                 | gene2GO mapping     | enriched GO list |
| `TOP20_GO_R.sh` / `TOPGO__MF_BP_R.sh`                     | all                  | GO visualisation (barplots, BP/MF)     | GO enrichment table | `.pdf` / `.png`  |
| `MF_BP_hap2_vs_groen_R.sh`                                | danica               | BP & MF plots (hap2 vs groen)          | GO enrichment       | `.pdf`           |

###  Whole-genome similarity
| Script                                             | Species  | Function                  | Input         | Output          |
| -------------------------------------------------- | -------- | ------------------------- | ------------- | --------------- |
| `mash_distance.sh`                                 | all      | Calculate Mash distances  | `.fa` genome  | distance matrix |
| `hap2_vs_groen_genepair.sh` / `hap2_vs_pyr_paf.sh` | all      | Pairwise genome alignment | `.fa` genomes | `.paf`          |
| `dotplot_pyr_compare_groen.sh`                     | pyrenica | Dotplot comparison        | `.paf`        | `.pdf`          |

### Data visualisation
| Script                                         | Species     | Function                             | Input         | Output |
| ---------------------------------------------- | ----------- | ------------------------------------ | ------------- | ------ |
| `Length_distribution_Sequence_similarity_R.sh` | Greenlandic | Length & identity distribution plots | ortholog list | `.pdf` |
| `pca——R.sh`                                    | Greenlandic | PCA plots                            | TE matrix     | `.pdf` |
| `R_Copy_number.sh`                             | Greenlandic | Gene copy number plot                | annotation    | `.pdf` |
| `top10_R.sh`                                   | Greenlandic | Top10 GO terms                       | GO table      | `.pdf` |

## Data sources & formats
#### Genomes: PacBio HiFi assemblies with Hi-C scaffolding for all species.
#### Annotation: Prokka v1.14 for protein coding genes; TE annotation by EDTA & RepeatMasker.
#### Orthology: OrthoFinder v2.5 single-copy orthologs.
#### File formats: 
     .fa / .fasta: genome assemblies

     .gff3: annotations

     .tsv: summary tables
 
     .R / .sh: analysis scripts

## Results preview
#### Protein length comparison:
###### Most hap2 vs C. groenlandica orthologous proteins lie close to the diagonal, indicating near-identical lengths
#### Pairwise global identity distribution:
###### A single strong peak at 100% identity indicates extremely close evolutionary relationship:
#### TE composition PCA:
###### PCA based on LTR, LINE, and SINE content shows hap2 clustering with C. groenlandica:

## Reproducibility
### All scripts and configuration files are provided in the scripts/ directory.
### Shell scripts (.sh) include input paths and conda environment loading.
### R scripts (.R) produce all plots in figures/.
### Environment YAML files in env/ ensure the same software versions can be recreated with:

    conda env create -f env/polydiv_env.yml

## Citation
### Genome assembly quality assessment
Cabanettes, F., & Klopp, C. (2021). gfastats: Conversion, evaluation and manipulation of genome assemblies. Bioinformatics, 37(22), 3980–3982.

Wang, S., et al. (2022). Compleasm: Accurate and fast assessment of genome assembly completeness. Bioinformatics.

Manni, M., Berkeley, M. R., Seppey, M., Simão, F. A., & Zdobnov, E. M. (2021). BUSCO update: Novel and streamlined workflows along with broader and deeper phylogenetic coverage for scoring of eukaryotic, prokaryotic, and viral genomes. Molecular Biology and Evolution, 38(10), 4647–4654.

### Whole-genome similarity and alignment
Ondov, B. D., et al. (2016). Mash: Fast genome and metagenome distance estimation using MinHash. Genome Biology, 17, 132.

Li, H. (2018). Minimap2: Pairwise alignment for nucleotide sequences. Bioinformatics, 34(18), 3094–3100.

Kurtz, S., et al. (2004). Versatile and open software for comparing large genomes. Genome Biology, 5(2), R12.

### Gene annotation & orthology
Seemann, T. (2014). Prokka: Rapid prokaryotic genome annotation. Bioinformatics, 30(14), 2068–2069.

Emms, D. M., & Kelly, S. (2019). OrthoFinder: Phylogenetic orthology inference for comparative genomics. Genome Biology, 20, 238.

Shen, W., et al. (2016). SeqKit: A cross-platform and ultrafast toolkit for FASTA/Q file manipulation. PLoS ONE, 11(10), e0163962.

### Functional annotation & enrichment
Törönen, P., Medlar, A., & Holm, L. (2018). PANNZER2: A rapid functional annotation web server. Nucleic Acids Research, 46(W1), W84–W88.

Yu, G., et al. (2012). clusterProfiler: An R package for comparing biological themes among gene clusters. OMICS, 16(5), 284–287.

Alexa, A., & Rahnenfuhrer, J. (2016). topGO: Enrichment analysis for Gene Ontology. R package version 2.42.0.

Fisher, R. A. (1935). The Design of Experiments. Oliver and Boyd.

Benjamini, Y., & Hochberg, Y. (1995). Controlling the false discovery rate: A practical and powerful approach to multiple testing. Journal of the Royal Statistical Society: Series B, 57(1), 289–300.

### Transposable element annotation
Ou, S., et al. (2019). EDTA: Extensive de-novo TE annotator for eukaryotic genomes. bioRxiv, 2019.

Smit, AFA., Hubley, R., & Green, P. (2013–2025). RepeatMasker Open-4.0. http://www.repeatmasker.org

### Data analysis and visualisation
Wickham, H. (2016). ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York.

Tang, Y., Horikoshi, M., & Li, W. (2016). ggfortify: Unified interface to visualize statistical results of popular R packages. The R Journal, 8(2), 478–489.

R Core Team (2024). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. https://www.R-project.org/


## Acknowledgements
I sincerely thank Professor Levi Yant and his laboratory for providing the genomic data used in this study, as well as their valuable support and guidance throughout the research.
I also acknowledge the use of the University of Nottingham High-Performance Computing (HPC) facility for computational resources, without which the analyses in this project would not have been possible.

## Contact 
Maintainer: Junfang Hu

Email: [alyjh38@nottingham.ac.uk]


