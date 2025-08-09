#  Already have: groen_dup_ids.txt, containing 4780 NCJMDBGG_… ID
wc -l groen_dup_ids.txt   # dispaly 4780
head -n 5 groen_dup_ids.txt

cd prokka_output

awk '
  NR==FNR { ids[$1]; next }      # read groen_dup_ids.txt first, save each ID to the array ids
  /^>/ {
    # extract the header row ID：>NCJMDBGG_00001   hypothetical...
    # use blank to split, take the first field, and remove itleading ">"
    split($0, fields, /[ \t]/);
    id = substr(fields[1], 2);
    keep = (id in ids);
  }
  keep                            # if keep is true, print the line and subsequent sequence lines
' ../groen_dup_ids.txt groenlandica_large_contigs.faa \
  > ../dup_proteins.fasta

cd ..
ls -lh dup_proteins.fasta          # confirm size non-0
grep "^>" dup_proteins.fasta | head -n 10
grep "^>" dup_proteins.fasta | wc -l  # equals 4780

