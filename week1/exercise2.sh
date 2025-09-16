#!/bin/bash

# Getting hg16 files:
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg16/bigZips/hg16.chrom.sizes
less hg16.chrom.sizes
grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes
less hg16-main.chrom.sizes 
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed
mv ~/Downloads/hg16-kc.tsv ./
wc -l hg16-kc.tsv 
#   21365 hg16-kc.tsv
cut -f1-3,5 hg16-kc.tsv > hg16-kc.bed
head -4 hg16-kc.bed                  
#chrom	chromStart	chromEnd	transcript
#chr1	364535	368303	AK128780
#chr1	502134	503453	BC031359
#chr1	792613	795077	AK097327
wc -l hg16-1mb.bed 
#    3085 hg16-1mb.bed
bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed > hg16-kc-count.bed
wc -l hg16-kc-count.bed 
#    3085 hg16-kc-count.bed
touch exercise2.sh
open exercise2.sh -a "visual studio code"



# Calculate how many genes are unique to each assembly:

# How many genes are in hg19?
wc -l hg19-kc.tsv 
#   80270 hg19-kc.tsv

# How many genes are in hg19 but not in hg16?
bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | wc -l
#   42717

# Why are some genes in hg19 but not in hg16?
# hg19 was finished in 2009, but hg16 was finished in 2003. Sequencing of hg19 used
# new technologies, thus have fewer gaps than hg16 and get more DNA sequences and genes.


# How many genes are in hg16?
wc -l hg16-kc.tsv 
#   21365 hg16-kc.tsv

# How many genes are in hg16 but not in hg19?
bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed | wc -l
#    3460

# Why are some genes in hg16 but not in hg19?
# hg16 was sequenced with earlier thenniques, thus contain some misassemblies. These
# misassemblies may contain genes that don't actually exist, and such mistakes were 
# corrected in hg19. What's more, some DNA sequences that were considered genes in
# earlier years may no longer be considered genes upon the time of hg19 publication. 


git add exercise2.Rmd    
git add exercise2.png
git add exercise2.sh
git commit -m "exercise 2"
git push