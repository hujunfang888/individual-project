# Comparative genomics reveals Cochlearia groenlandica as a major parental lineage of C. danica haplotype 2

## Background
Allopolyploid species arise from hybridization between different parental species, combining two or more distinct genomes. Cochlearia danica is an allopolyploid/ allohexaploid plant with multiple haplotypes, and its origin has been debated. In this study, I focus on haplotype 2 (hap2) and compare it with two pptencial parents: C. groenlandica and C. pyrenaica.

The goals are to:
 check genome quality and choose good assemblies for comparison;
 Compare whole-genome similarity, structure, and transposable element (TE) content.
 Find gene differences that may explain adaptation after allopolyploidy.
## Workflow
### 
    A[Genome assemblies] --> B[Quality assessment: gfastats + Compleasm]
    B --> C[Filter contigs by length(use 10 mb and 1mb thresholds)]
    C --> D[TE annotation: EDTA + RepeatMasker]
    C --> E[Protein annotation: Prokka]
    C --> F[Orthology inference: OrthoFinder]
    F --> G[Whole-genome similarity: Mash + minimap2]
    G --> H[Pairwise identity & length distribution]
    H --> I[Low-identity gene set (<60%)]
    I --> J[GO annotation & enrichment: PANNZER2 + clusterProfiler + topGO]
    D --> K[TE composition analysis: R + PCA + stacked bar plots]
    E --> L[Dotplot visualisation]

##  Folders and scripts
All scripts are `sbatch` jobs for Ada HPC. ‘awk’ works were run locally on my laptop since they finish much faster without queuing. 
Conda environments needed such as `gfastats_env`, `compleasm_env`, `repeatmasker_env`, `edta_env`, `orthofinder_env` , and an R environment with topGO and ggplot2.  
###  `Genome_Quality/`
`gfastats_*.sh` – run gfastats to get contig and scaffold statistics.  
`compleasm_*.sh` – run Compleasm with BUSCO (brassicales lineage) to check assembly completeness (tested with 1 Mb and 10 Mb cut-offs).  

###  `TE/`
`EDTA_*.sh` – run EDTA for de novo TE annotation.  
`RepeatMasker_*.sh` – run RepeatMasker with `-species viridiplantae` to identify repeats.  
`TE_length_awk_summary.sh` – calculate genome coverage and TE class lengths.  
`TE_statistics_*.sh` – check overlap between TE and CDS using bedtools.  
`TE_PCA_R.sh` – PCA of TE composition.  
`TE_composition_R.sh` – barplots of TE classes.
  
###  `OrthoFinder/`
`Prokka_*.sh` – annotate CDS and proteins with Prokka.  
`OrthoFinder_Groen_Hap2.sh` – find orthologous genes with OrthoFinder.  
`Mash_*.sh` – compute genome distances with Mash
`Groen_Hap2_PAFfile_for_dotplot.sh` – minimap2 alignment for dotplots.  

###  `GOenrichment/`
`TOPGO_BP_MF_*.sh` – GO enrichment tests (BP and MF) using topGO.  
`Length_distribution_and_Sequence_similarity_R.sh` – plot protein length distributions and similarities.  
`seqkit_for_Pannzer2.sh` – prepare sequences for Pannzer2 functional annotation.  
`single_copy_gene_hap2_groenlandica.sh` – prepare single-copy orthologs for GO.  

##  Scripts Index 
### I wrote all the scripts in these folders. The tools I used (e.g. Prokka, OrthoFinder, EDTA, etc.) are properly cited in the script headers and in the References.
##### Note on Species Names
During earlier stages of this project, some species names were mistakenly written with the wrong spelling in the code, figures, or documentation. Please note the correct names below:
Cochlearia groenlandica (sometimes incorrectly written as greenlandic)
Cochlearia pyrenaica (sometimes incorrectly written as pyrenica)
These have now been corrected in the report and will be gradually updated across the repository.

### Genome quality assessment
| Script                                                         | Species     | Function                                  | Input        | Output                 |
| -------------------------------------------------------------- | ----------- | ----------------------------------------- | ------------ | ---------------------- |
| `compleasm_10mb` / `compleasm_1mb` | all   | Compleasm (BUSCO) assembly completeness   | `.fa` genome | BUSCO/Compleasm report |
| `gfastats_*.sh`       | all     | Contig statistics    | `.fa` genome | `.tsv` summary   |

### TE annotation & analysis
| Script                                                              | Species            | Function                         | Input      | Output                     |
| ------------------------------------------------------------------- | ------------------ | -------------------------------- | ---------- | -------------------------- |
| `EDTA_*.sh `      | all                | Comprehensive TE annotation | `.fa` genome | `TE.gff` / `TE.fasta`          |
| `RepeatMasker_*.sh` | all | RepeatMasker TE masking          |` .fa` genome | masked genome / `repeat.gff` |
| `TE_statistics_groen.sh`  | C.groenlandica  |  TE statistics and visualization    | `TE.gff`     | Number of CDS overlapped by `TE.bed`  |
| `TE_PCA_R.sh`  |all | PCA for species| TE length of three genome/`TE.tsv`|PCA plot on R|
| `TE_composition_R.sh`| all|  composition of TE clasees across genomes| data| TEplot|
| `TE_length_awk_summary.sh`| all | TE total length statistic | `raw.gff3` | `.tsv` |

### Orthofinder
| Script                                          | Species     | Function                      | Input             | Output          |
| ----------------------------------------------- | ----------- | ----------------------------- | ----------------- | --------------- |
| `prokka_*.sh` | all     | Prokka gene annotation  | `.fa` genome   | `.gff` / `.faa` |
| `Othofinder_Groen_Hap2.sh`   | C.grolendica and C.hap2   | Run OrthoFinder   | protein `.faa`    | orthogroups     |
| `Groen_Hap2_PAFfile_for_dotplot.sh`  | C.groenlandica and C.hap2 | drawing dotplots('hap2 vc groenlandica' and'hap2 vs pyrenaica') and put them togeter |`.paf` files | dotplot on R|       
| `Mash_hap2_*.sh` | all | compute genomes(groenlandica and pyrenaica) distances with Mash| `.fa`  | `.msh ` |

### GOenrichment
| Script                                                    | Species              | Function                               | Input               | Output           |
| --------------------------------------------------------- | -------------------- | -------------------------------------- | ------------------- | ---------------- |
| `seqkit_for_Pannzer2.sh` |all | Extract protein sequences for PANNZER2 | `.faa` | `.faa` subset    |
|  `TOPGO_BP_MF_*.sh`     | C. groenlandica and C. hap2  | GO visualisation (barplots, BP and MF)| GO enrichment table | `.pdf` / `.png`  |
| `Length_distribution_ang_Sequence_similarity_R.sh`| C. groenlandica and C. hap2 |Length distribution and sequence similarity for GO input|`faa`genome|length distribution plot and sequence similarity plot `.png`|


## Data Aviliable
### This project does not include raw data files (like FASTQ or VCF) because I cannot share them(controlled data policy).  Here I only put the scripts and some small test files to show how the analysis was done.

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
###### Most ortholog proteins between hap2 and C. groenlandica are near the diagonal line, which shows their lengths are almost the same.
#### Pairwise global identity distribution:
###### A single strong peak at 100% identity indicates extremely close evolutionary relationship.
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


