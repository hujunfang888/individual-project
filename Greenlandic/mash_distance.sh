
#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=04:00:00
#SBATCH --job-name=mash_batch
#SBATCH --output=mash_batch_%j.out
#SBATCH --error=mash_batch_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alyjh38@nottingham.ac.uk

source $HOME/.bash_profile
conda activate mash_env

REF="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/danica/CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa"
GROEN="/gpfs01/home/alyjh38/junfang/Project_danica_Junfang/groenlandica/cochlearia_groenlandica_18Oct2019_dfYNf.fasta_large_contigs.fa"

mash sketch -o hap2.msh $REF
mash sketch -o groen.msh $GROEN

mash dist hap2.msh groen.msh > mash_hap2_groen.dist

echo "mash distance calculation for hap2 vs groen finished!
