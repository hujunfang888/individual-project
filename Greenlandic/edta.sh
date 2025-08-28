#!/bin/bash

#SBATCH --job-name=edta_groenlandica
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=256G
#SBATCH --time=144:00:00
#SBATCH --output=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/edta_groenlandica.out
#SBATCH --error=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/edta_groenlandica.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate edta_env

EDTA.pl \
  --genome /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa \
  --species others \
  --anno 1 \
  --threads 16

conda deactivate
