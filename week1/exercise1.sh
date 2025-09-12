#!/bin/bash

cd qb25-answers 
mkdir week1
cd week1  
conda activate qb25 
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes
less hg19.chrom.sizes
grep -v _ hg19.chrom.sizes | sed 's/M/MT/' > hg19-main.chrom.sizes
less hg19-main.chrom.sizes 
bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed
wc hg19-1mb.bed
#    3114    9342   74191 hg19-1mb.bed
mv ~/Downloads/hg19-kc.tsv ./
wc -l hg19-kc.tsv 
#    80270 hg19-kc.tsv
cut -f1-3,5 hg19-kc.tsv > hg19-kc.bed
head -4 hg19-kc.bed
# #chrom	chromStart	chromEnd	transcript
# chr1	169818771	169863037	ENST00000367771.11_11
# chr1	169764180	169823221	ENST00000359326.9_7
# chr1	27938574	27961696	ENST00000374005.8_7
wc -l hg19-1mb.bed 
#    3114 hg19-1mb.bed
bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed > hg19-kc-count.bed
wc -l hg19-kc-count.bed 
#    3114 hg19-kc-count.bed
touch exercise1.sh
open exercise1.sh -a "visual studio code"
git add hg19-main.chrom.sizes 
git add hg19-1mb.bed         
git add hg19-kc-count.bed 
git add exercise1.Rmd    
git add exercise1.png
git add exercise1.sh
git commit -m "exercise 1"
git push