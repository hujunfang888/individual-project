#!/bin/bash

#SBATCH --job-name=eggnog_groen
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=04:00:00
#SBATCH --output=eggnog_groen_%j.out
#SBATCH --error=eggnog_groen_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate eggnog

# Input and output
IN="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_output/groenlandica_large_contigs.faa"
OUTDIR="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/eggnog_annotation"
DBDIR="/gpfs01/home/alyjh38/eggnog_db"

mkdir -p $OUTDIR

# Run eggNOG-mapper
emapper.py -i $IN \
  -o groen_annotation \
  --output_dir $OUTDIR \
  --data_dir $DBDIR \
  --cpu 8 \
  --itype proteins
