#!/bin/bash

#SBATCH --job-name=repeatmasker_hap2
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=repeatmasker_hap2_%j.out
#SBATCH --error=repeatmasker_hap2_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate repeatmasker_env

GENOME="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa"
OUTDIR="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/repeatmasker_hap2_output"

mkdir -p $OUTDIR


RepeatMasker -pa 8 -species viridiplantae -gff -dir $OUTDIR $GENOME

conda deactivate
