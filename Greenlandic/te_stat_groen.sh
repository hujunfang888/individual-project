 
#!/bin/bash

#SBATCH --job-name=te_stat_groen
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=03:00:00
#SBATCH --output=te_stat_groen_%j.out
#SBATCH --error=te_stat_groen_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

# ------------------- Analysis Section -------------------

# File paths (use absolute paths)
TE_GFF="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/repeatmasker_groen_output/cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa.out.gff"
GENOME_FA="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa"
PROKKA_GFF="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_output/groenlandica_large_contigs.gff"

# 0. Check bedtools availability
if ! command -v bedtools &> /dev/null; then
    echo "bedtools could not be found. Please load module or install with conda."
    exit 1
fi

# 1. Total length of annotated TEs
TE_TOTAL=$(awk '!/^#/ {sum += $5-$4+1} END {print sum}' $TE_GFF)
echo "Total TE length (bp): $TE_TOTAL"

# 2. Total genome length (sum all contigs)
GENOME_TOTAL=$(awk '/^>/ {if(N) {sum+=N}; N=0; next} {N += length($0)} END {sum+=N; print sum}' $GENOME_FA)
echo "Total genome length (bp): $GENOME_TOTAL"

# 3. Proportion of genome covered by TEs
TE_RATIO=$(echo "scale=4; $TE_TOTAL/$GENOME_TOTAL*100" | bc)
echo "TE proportion in genome: $TE_RATIO %"

# 4. Statistics for TE types (if any)
for TYPE in "LTR" "Gypsy" "Copia" "LINE" "SINE"
do
    LEN=$(awk -v t=$TYPE '!/^#/ && $9~t {sum+=$5-$4+1} END{print sum}' $TE_GFF)
    [ -z "$LEN" ] && LEN=0
    RATIO=$(echo "scale=4; $LEN/$GENOME_TOTAL*100" | bc)
    echo "$TYPE total length (bp): $LEN, proportion: $RATIO %"
done

# 5. Extract CDS features as BED
awk '$3=="CDS" {OFS="\t"; split($1,a,";"); print a[1], $4-1, $5, $9}' $PROKKA_GFF > cds.bed

# 6. Extract TE features as BED
awk '!/^#/ {OFS="\t"; split($1,a,";"); print a[1], $4-1, $5, $9}' $TE_GFF > TE.bed

# 7. Calculate overlap between TE and CDS
bedtools intersect -a TE.bed -b cds.bed -wo > TE_CDS_overlap.bed
OVERLAP=$(awk '{sum+=$NF} END{print sum}' TE_CDS_overlap.bed)
echo "Total overlapping bases between TE and CDS: $OVERLAP"
CDS_NUM=$(bedtools intersect -a cds.bed -b TE.bed -u | wc -l)
echo "Number of CDS overlapped by TE: $CDS_NUM"

echo "Analysis complete!"
