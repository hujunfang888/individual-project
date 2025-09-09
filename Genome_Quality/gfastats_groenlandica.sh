#!/bin/bash
#SBATCH --job-name=gfastats_cochlearia
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=10:00:00
#SBATCH --output=gfastats_cochlearia_%j.out
#SBATCH --error=gfastats_cochlearia_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate genome_analysis

# Ensure gfastats is installed
if ! command -v gfastats &> /dev/null; then
    echo "Error: gfastats is not installed or not in PATH."
    exit 1
fi

INPUT_DIR="/gpfs01/home/alyjh38/Individual_project"
OUTPUT_DIR="/gpfs01/home/alyjh38/Individual_project/gfastats_output"

mkdir -p $OUTPUT_DIR

# Run gfastats on Cochlearia
echo "Running gfastats on Cochlearia..."
GFA_FILE="$INPUT_DIR/cochlearia_groenlandica_18Oct2019_dfYNf.fasta"
BASENAME=$(basename $GFA_FILE .fasta)
gfastats $GFA_FILE > $OUTPUT_DIR/${BASENAME}_gfastats.txt

echo "Generating updated summary report..."
cat $OUTPUT_DIR/*_gfastats.txt > $OUTPUT_DIR/gfastats_summary.txt

echo "Gfastats analysis for Cochlearia completed!"
