# hap2
cat CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa.mod.LTR.intact.raw.gff3 \
>     CDAN001_n3.hic.hap2.p_ctg_large_contigs.fa.mod.TIR.intact.raw.gff3 > hap2_TE_merged.gff3

 awk '$3 == "repeat_region"' hap2_TE_merged.gff3 | \
> awk -F'\t' '{
>   len = $5 - $4 + 1;
>   match($9, /classification=([^;]+)/, a);
>   class = a[1];
>   te[class] += len;
> } END {
>   for (i in te) print i "\t" te[i]
> }' | sort -k2 -nr > TE_lengths_hap2.tsv

for file in *.raw.fa; do
  type=$(echo "$file" | grep -oE 'LINE|LTR|SINE|TIR|Helitron')
  len=$(grep -v ">" "$file" | tr -d '\n' | wc -c)
  echo -e "$type\t$len"
done | awk '{te[$1] += $2} END {for (i in te) print i "\t" te[i]}' > TE_lengths_from_rawfa.tsv

# for Groen 
awk '$3 == "repeat_region"' cochlearia_TE_annotation.gff3 | \
awk -F'\t' '{
  match($9, /classification=([^;]+)/, a);
  class = a[1];
  count[class] += 1;
} END {
  for (i in count) print i "\t" count[i]
}' | sort -k2 -nr > TE_counts_groenlandica.tsv

for file in *.raw.fa; do
  type=$(echo $file | cut -d'.' -f5)
  len=$(grep -v ">" $file | tr -d '\n' | wc -c)
  echo -e "$type\t$len"
done > TE_lengths_from_rawfa.tsv

# for Pyr
cat CPYR002hifiasm24_hic_hap1_6_large_contigs.fa.mod.LTR.intact.raw.gff3 \
    CPYR002hifiasm24_hic_hap1_6_large_contigs.fa.mod.TIR.intact.raw.gff3 \
    > pyrenica_TE_merged.gff3

awk '$3 == "repeat_region"' pyrenica_TE_merged.gff3 | \
awk -F'\t' '{
  len = $5 - $4 + 1;
  match($9, /classification=([^;]+)/, a);
  class = a[1];
  te[class] += len;
} END {
  for (i in te) print i "\t" te[i]
}' | sort -k2 -nr > TE_lengths_pyrenica.tsv

for file in *.raw.fa; do
  type=$(echo "$file" | grep -oE 'LINE|LTR|SINE|TIR|Helitron')
  len=$(grep -v ">" "$file" | tr -d '\n' | wc -c)
  echo -e "$type\t$len"
done | awk '{te[$1] += $2} END {for (i in te) print i "\t" te[i]}' > TE_lengths_from_rawfa.tsv
