#!/bin/bash
#SBATCH --job-name=gfastats_danica
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=05:00:00
#SBATCH --output=gfastats_danica_%A.out
#SBATCH --error=gfastats_danica_%A.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate gfastats_env

INPUT_DIR="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica"
OUTPUT_DIR="${INPUT_DIR}/gfastats_output"

for FILE in CDAN001_n3.hic.hap1.p_ctg.fa CDAN001_n3.hic.hap2.p_ctg.fa CDAN001_n3.hic.hap3.p_ctg.fa
do
    BASENAME=$(basename "$FILE" .fa)
    echo "==> Running gfastats on $FILE ..."
    gfastats -f "${INPUT_DIR}/${FILE}" > "${OUTPUT_DIR}/${BASENAME}.tsv"
done
