#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=06:00:00
#SBATCH --job-name=hap2_vs_pyr_minimap2
#SBATCH --output=hap2_vs_pyr_%j.out
#SBATCH --error=hap2_vs_pyr_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate dotplot_env


REF="CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa"
QRY="CPYR002hifiasm24_hic_hap1_6_large_contigs.fa"

minimap2 -x asm5 -t 8 $REF $QRY > CPYR002_vs_hap2.paf

echo "finished"
