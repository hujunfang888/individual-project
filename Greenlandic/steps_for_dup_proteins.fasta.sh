awk -F'\t' 'NR>1 {
  # 6 列是 Genes.1，7 列是 Genes.2
  n=split($6,a,","); for(i=1;i<=n;i++) print a[i]
  n=split($7,b,","); for(i=1;i<=n;i++) print b[i]
}' Duplications.tsv \
| sed -e 's/^ *//g' -e 's/ *$//g' \
      -e 's/^groen_//' -e 's/^hap2_//' \
| sort -u > dup_ids.txt

cat \
>   hap2_large_contigs.faa \
>   prokka_output/groenlandica_large_contigs.faa \
> > proteome.fasta

seqkit grep -f dup_ids.txt proteome.fasta -o dup_proteins.fasta
