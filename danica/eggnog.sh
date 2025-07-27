#!/bin/bash

#SBATCH --job-name=eggnog_hap2_danica
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=16:00:00
#SBATCH --output=eggnog_hap2_danica_%j.out
#SBATCH --error=eggnog_hap2_danica_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

# Load conda environment
source $HOME/.bash_profile
conda activate eggnog

# Define input and output
IN="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/hap2_large_contigs.faa"
OUTDIR="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/eggnog_hap2"
DBDIR="/gpfs01/home/alyjh38/eggnog_db"

# Create output directory
mkdir -p $OUTDIR

# Run eggNOG-mapper
emapper.py -i $IN \
  -o hap2_danica_annotation \
  --output_dir $OUTDIR \
  --data_dir $DBDIR \
  --cpu 8 \
  --itype proteins
