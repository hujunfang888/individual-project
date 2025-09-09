#!/bin/bash

#SBATCH --job-name=prokka_groenlandica
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=03:00:00
#SBATCH --output=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_groenlandica.out
#SBATCH --error=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_groenlandica.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate prokka

prokka \
  --outdir /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_output \
  --prefix groenlandica_large_contigs \
  --cpus 8 \
  /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa

conda deactivate
