#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=06:00:00
#SBATCH --job-name=mash_dist
#SBATCH --output=mash_dist_%j.out
#SBATCH --error=mash_dist_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate mash_env

REF="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa"
QRY="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/pyrenica/CPYR002hifiasm24_hic_hap1_6_large_contigs.fa"

mash sketch -o hap2.msh $REF
mash sketch -o pyr.msh $QRY

mash dist hap2.msh pyr.msh
