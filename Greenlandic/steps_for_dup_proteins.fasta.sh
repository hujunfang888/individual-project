# 已有：groen_dup_ids.txt，包含 4780 条 NCJMDBGG_… ID
wc -l groen_dup_ids.txt   # 应显示 4780
head -n 5 groen_dup_ids.txt

cd prokka_output

awk '
  NR==FNR { ids[$1]; next }      # 先读 groen_dup_ids.txt，将每个 ID 存到数组 ids
  /^>/ {
    # 提取 header 行的 ID：>NCJMDBGG_00001   hypothetical...
    # 用空白分割，取第一个字段，去掉 leading ">"
    split($0, fields, /[ \t]/);
    id = substr(fields[1], 2);
    keep = (id in ids);
  }
  keep                            # 如果 keep 为真，则打印该行及后续序列行
' ../groen_dup_ids.txt groenlandica_large_contigs.faa \
  > ../dup_proteins.fasta

cd ..
ls -lh dup_proteins.fasta          # 确认大小非 0
grep "^>" dup_proteins.fasta | head -n 10
grep "^>" dup_proteins.fasta | wc -l  # 应约等于 4780

