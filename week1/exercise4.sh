#!/bin/bash

touch exercise4.sh
open exercise4.sh -a "visual studio code"
mv ~/Downloads/snps-chr1.bed ./
wc -l snps-chr1.bed            
# 1091148 snps-chr1.bed

bedtools intersect -c -a hg19-kc.bed -b snps-chr1.bed | sort -n -r -k 5 | head
#chr1	245912648	246670581	ENST00000490107.6_7	5445
#chr1	6845513	7829766	ENST00000303635.12_8	5076
#chr1	237205483	237997288	ENST00000366574.7_7	4586
#chr1	193442353	194167841	ENST00000656143.2_4	4265
#chr1	48998525	50489626	ENST00000371839.6_9	4003
#chr1	215796232	216596790	ENST00000307340.8_12	3898
#chr1	245318286	245872734	ENST00000407071.7_12	3752
#chr1	71861625	72748222	ENST00000357731.10_7	3670
#chr1	82678096	83313888	ENST00000650063.1_5	3563
#chr1	240938813	241520505	ENST00000440928.6_9	3340

# The gene with most SNPs: 
# systematic name: ENST00000490107.6_7
# human readable name: SMYD3 (SET and MYND domain containing 3, transcript variant 3)
# position: hg19 chr1:245,912,649-246,670,581
# size: 757,933 bp
# exon number: 12
# Reason for so many SNPs: SMYD3 is a histone methyltransferase that participates in 
# epigenetic regulation. Given the population variation on epigenetic level, it makes 
# sense for SMYD3 to have lots of SNPs. Another possible reason is that SMYD3 gene is 
# long with a few exons, meaing that most of the gene are introns. As SNPs in introns are
# less likely to cause malfunction, this also allow SMYD3 gene to accumulate SNPs.

bedtools sample -i snps-chr1.bed -n 20 -seed 42 | bedtools sort -i > snps-chr1-sample.bed
bedtools sort -i hg19-kc.bed > hg19-kc-sample.bed
bedtools closest -d -t first -a snps-chr1-sample.bed -b hg19-kc-sample.bed | cut -f 11 | sort -n | uniq -c
#  15 0
#   1 1664
#   1 4407
#   1 6336
#   1 15658
#   1 22944
## 15 SNPs are inside of genes
## Range of distances for SNPs outside genes: 1664 - 22944

git add exercise4.sh
git commit -m "exercise 4"
git push