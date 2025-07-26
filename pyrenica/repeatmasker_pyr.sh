#!/bin/bash

#SBATCH --job-name=repeatmasker_pyr
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/pyrenica/repeatmasker_pyr.out
#SBATCH --error=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/pyrenica/repeatmasker_pyr.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate repeatmasker_env

RepeatMasker -pa 8 \
  -gff \
  -dir /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/pyrenica/repeatmasker_pyr_output \
  -species viridiplantae \
  /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/pyrenica/CPYR002hifiasm24_hic_hap1_6_large_contigs.fa

conda deactivate
