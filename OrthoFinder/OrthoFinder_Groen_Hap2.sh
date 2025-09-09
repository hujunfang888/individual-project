cp /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/prokka_hap2_output/hap2_large_contigs.faa \
   /gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/

#!/bin/bash
#SBATCH --job-name=batch_orthofinder_groen_hap2
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=03:00:00
#SBATCH --output=batch_orthofinder_groen_hap2_%A.out
#SBATCH --error=batch_orthofinder_groen_hap2_%A.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source "$HOME/.bash_profile"
conda activate orthofinder_env

HAP2_FAA="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/prokka_hap2_output/hap2_large_contigs.faa"
GROEN_FAA="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/prokka_output/groenlandica_large_contigs.faa"

WORKDIR="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/orthofinder_groen_hap2"
OUTDIR="orthofinder_out_groen_hap2"

mkdir -p "${WORKDIR}/input"
cd "${WORKDIR}/input"

cp "${HAP2_FAA}" hap2.faa
cp "${GROEN_FAA}" groen.faa

if [ -d "${WORKDIR}/${OUTDIR}" ]; then
  rm -rf "${WORKDIR}/${OUTDIR}"
fi

orthofinder \
  -f . \
  -S diamond \
  -t $SLURM_CPUS_PER_TASK \
  -a $SLURM_CPUS_PER_TASK \
  -o "${WORKDIR}/${OUTDIR}"

echo "Done. Results in ${WORKDIR}/${OUTDIR}/OrthoFinder/"
