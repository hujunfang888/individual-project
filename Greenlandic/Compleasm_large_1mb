#!/bin/bash
#SBATCH --job-name=compleasm_large_contigs_1mb
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=06:00:00
#SBATCH --output=compleasm_large1mb_%j.out
#SBATCH --error=compleasm_large1mb_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate compleasm_env

INPUT_DIR="/gpfs01/home/alyjh38/Individual_project"
OUTPUT_DIR="/gpfs01/home/alyjh38/Individual_project/compleasm_large_output_1mb"
LINEAGE_PATH="/gpfs01/home/alyjh38/Individual_project/mb_downloads/brassicales"
THREADS=8

SAMPLES=("CDAN001_n3.hic.hap1.p_ctg.fa" \
         "CDAN001_n3.hic.hap2.p_ctg.fa" \
         "CDAN001_n3.hic.hap3.p_ctg.fa" \
         "CPYR002hifiasm24_hic_hap1_6.fa" \
         "cochlearia_groenlandica_18Oct2019_dfYNf.fasta")

mkdir -p $OUTPUT_DIR

for SAMPLE in "${SAMPLES[@]}"; do
    BASE=$(basename $SAMPLE .fa)
    echo "Processing $SAMPLE for large contigs (>1Mb)..."

    awk 'BEGIN{RS=">"; ORS=""} length($0)>1000000{print ">"$0}' \
        "${INPUT_DIR}/${SAMPLE}" > "${OUTPUT_DIR}/${BASE}_large_contigs.fa"

    if [[ -s ${OUTPUT_DIR}/${BASE}_large_contigs.fa ]]; then
        echo "Running Compleasm on large contigs for $BASE..."
        compleasm run \
            -a ${OUTPUT_DIR}/${BASE}_large_contigs.fa \
            -o ${OUTPUT_DIR}/${BASE}_compleasm_large \
            -t $THREADS \
            -l brassicales \
            -L $LINEAGE_PATH \
            --outs 0.85
    else
        echo "No large contigs (>1Mb) found for $BASE. Skipping."
    fi
done

echo "All large contig samples processed."
