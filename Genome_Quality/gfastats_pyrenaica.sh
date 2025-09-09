#!/bin/bash
#SBATCH --job-name=gfastats_pyrenica
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --output=gfastats_pyrenica_%A.out
#SBATCH --error=gfastats_pyrenica_%A.err
#SBATCH --mail-type=END
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate gfastats_env

cd /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/pyrenica

gfastats -f CPYR002hifiasm24_hic_hap1_6.fa > CPYR002hifiasm24_hic_hap1_6.tsv

echo "gfastats finished for pyrenica"
