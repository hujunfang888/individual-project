# Comparative genomics of Cochlearia danica haplotype 2 and its putative parental species

## Background
Allopolyploid species arise from hybridization between different parental species, combining two or more distinct genomes. Cochlearia danica is an allopolyploid plant with multiple haplotypes, and its origin has been debated. In this study, we focus on haplotype 2 (hap2) and compare it with two putative parents: C. groenlandica and C. pyrenaica.
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
### All scripts in scripts/ were developed by me unless otherwise stated. Where adapted from external sources, I have cited and credited the original authors in the script headers and in the References below.
##### Note on Species Names
During earlier stages of this project, some species names were mistakenly written with the wrong spelling in the code, figures, or documentation. Please note the correct names below:
Cochlearia groenlandica (sometimes incorrectly written as greenlandic)
Cochlearia pyrenaica (sometimes incorrectly written as pyrenica)
These have now been corrected in the report and will be gradually updated across the repository.
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

## Data Aviliable
### This repository does not include raw datasets (FASTQ/VCF etc.) because of unpublished/controlled data policies. All analyses are documented with scripts and small configuration/example files only.
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
Formenti, G. et al. (2022) Gfastats: conversion, evaluation and manipulation of genome sequences using assembly graphs. Bioinformatics, 38(17), pp. 4214–4216. Available at: https://doi.org/10.1093/bioinformatics/btac460.

Kurtz, S. et al. (2004) Versatile and open software for comparing large genomes. Genome biology, 5(2), R12. Available at: https://doi.org/10.1186/gb-2004-5-2-r12.

Ondov, B.D. et al. (2016) Mash: fast genome and metagenome distance estimation using MinHash. Genome Biology, 17(1). Available at: https://doi.org/10.1186/s13059-016-0997-x.

### Genome annotation and completeness assessment
Seemann, T. (2014) ‘Prokka: rapid prokaryotic genome annotation’, Bioinformatics, 30(14), pp. 2068–2069. Available at: https://doi.org/10.1093/bioinformatics/btu153.

Simão, F.A. et al. (2015) ‘BUSCO: assessing genome assembly and annotation completeness with single-copy orthologs’, Bioinformatics, 31(19), pp. 3210–3212. Available at: https://doi.org/10.1093/bioinformatics/btv351.

Huang, N. and Li, H. (2023) ‘compleasm: a faster and more accurate reimplementation of BUSCO’, Bioinformatics, 39(10). Available at: https://doi.org/10.1093/bioinformatics/btad595.

Lovell, J.T. et al. (2022) ‘GENESPACE tracks regions of interest and gene copy number variation across multiple genomes’, eLife, 11. Available at: https://doi.org/10.7554/eLife.78526.

Törönen, P., Medlar, A. and Holm, L. (2018) ‘PANNZER2: a rapid functional annotation web server’, Nucleic Acids Research, 46(W1), pp. W84–W88. Available at: https://doi.org/10.1093/nar/gky350.

### Sequence alignment and manipulation
Li, H. (2018) ‘Minimap2: pairwise alignment for nucleotide sequences’, Bioinformatics, 34(18), pp. 3094–3100. Available at: https://doi.org/10.1093/bioinformatics/bty191.

Shen, W. et al. (2016) ‘SeqKit: A Cross-Platform and Ultrafast Toolkit for FASTA/Q File Manipulation’, PLoS ONE, 11(10). Available at: https://doi.org/10.1371/journal.pone.0163962.

### Transposable element annotation and classification
Ou, S. et al. (2019) ‘Benchmarking transposable element annotation methods for creation of a streamlined, comprehensive pipeline’, Genome Biology, 20(1). Available at: https://doi.org/10.1186/s13059-019-1905-y.

Smit, A.F.A., Hubley, R. and Green, P. (2013) RepeatMasker Open-4.0. Available at: http://www.repeatmasker.org (Accessed: 6 August 2025).

Wicker, T. et al. (2007) ‘A unified classification system for eukaryotic transposable elements’, Nature Reviews Genetics, 8(12), pp. 973–982. Available at: https://doi.org/10.1038/nrg2165.

### Functional enrichment and statistical analysis
Emms, D.M. and Kelly, S. (2019) ‘OrthoFinder: phylogenetic orthology inference for comparative genomics’, Genome Biology, 20(1). Available at: https://doi.org/10.1186/s13059-019-1832-y.

Yu, G., Wang, L.G., Han, Y. and He, Q.Y. (2012) ‘clusterProfiler: an R package for comparing biological themes among gene clusters’, OMICS: A Journal of Integrative Biology, 16(5), pp. 284–287. Available at: https://doi.org/10.1089/omi.2011.0118.

Alexa, A. and Rahnenfuhrer, J. (2025) topGO: Enrichment Analysis for Gene Ontology. R package version 2.60.1. Available at: https://bioconductor.org/packages/topGO (Accessed: 27 August 2025).


### Data visualization and R environment
Wickham, H. (2016) ggplot2: elegant graphics for data analysis. 2nd edn. Cham: Springer International Publishing. Available at: https://doi.org/10.1007/978-3-319-24277-4.

Tang, Y., Horikoshi, M. and Li, W. (2016) ‘ggfortify: unified interface to visualize statistical results of popular R packages’, The R Journal, 8(2), pp. 478–489.

R Core Team (2024) R: A language and environment for statistical computing. Vienna: R Foundation for Statistical Computing. Available at: https://www.R-project.org/ (Accessed: 26 August 2025).

## Acknowledgements
I sincerely thank Professor Levi Yant and his laboratory for providing the genomic data used in this study, as well as their valuable support and guidance throughout the research.
I also acknowledge the use of the University of Nottingham High-Performance Computing (HPC) facility for computational resources, without which the analyses in this project would not have been possible.

## Contact 
Maintainer: Junfang Hu

Email: [alyjh38@nottingham.ac.uk]


