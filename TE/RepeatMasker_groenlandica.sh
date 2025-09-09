#!/bin/bash

#SBATCH --job-name=repeatmasker_groen
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/repeatmasker_groen.out
#SBATCH --error=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/repeatmasker_groen.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate repeatmasker_env

RepeatMasker -pa 8 \
  -gff \
  -dir /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/repeatmasker_groen_output \
  -species viridiplantae \
  /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa

conda deactivate
