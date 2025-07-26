#!/bin/bash
#SBATCH --job-name=prokka_hap2
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=80G
#SBATCH --time=05:00:00
#SBATCH --output=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/prokka_hap2.out
#SBATCH --error=/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/prokka_hap2.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate prokka

prokka \
  --outdir /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/prokka_hap2_output \
  --prefix hap2_large_contigs \
  --cpus 8 \
  /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa

conda deactivate

