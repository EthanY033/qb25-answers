#!/bin/bash

mkdir week3
cd week3
touch call_variants.sh             
open call_variants.sh -a "visual studio code"
mv /Users/cmdb/Downloads/BYxRM_bam.tar ./
tar -xzvf BYxRM_bam.tar  
#x BYxRM_bam/
#x BYxRM_bam/A01_39.bam
#x BYxRM_bam/A01_11.bam
#x BYxRM_bam/A01_63.bam
#x BYxRM_bam/A01_62.bam
#x BYxRM_bam/A01_23.bam
#x BYxRM_bam/A01_35.bam
#x BYxRM_bam/A01_09.bam
#x BYxRM_bam/A01_24.bam
#x BYxRM_bam/A01_31.bam
#x BYxRM_bam/A01_27.bam
cd BYxRM_bam

samtools index A01_39.bam
samtools index A01_11.bam
samtools index A01_63.bam
samtools index A01_62.bam
samtools index A01_23.bam
samtools index A01_35.bam
samtools index A01_09.bam
samtools index A01_24.bam
samtools index A01_31.bam
samtools index A01_27.bam

touch read_counts.txt
open read_counts.txt
samtools view -c A01_39.bam
samtools view -c A01_11.bam
samtools view -c A01_63.bam
samtools view -c A01_62.bam
samtools view -c A01_23.bam
samtools view -c A01_35.bam
samtools view -c A01_09.bam
samtools view -c A01_24.bam
samtools view -c A01_31.bam
samtools view -c A01_27.bam
#713726
#656245
#620829
#816639
#708732
#803554
#669548
#797385
#610360
#602404

touch bamListFile.txt
open bamListFile.txt

# run FreeBayes to discover variants 
freebayes -f ../../week2/genomes/sacCer3.fa -L bamListFile.txt --genotype-qualities -p 2 > unfiltered.vcf
# the resulting VCF file is unfiltered, meaning that it contains low-confidence calls and also has some quirky formatting, so the following steps use a software suite called vcflib to clean up the VCF

# filter the variants based on their quality score and remove sites where any sample had missing data
vcffilter -f "QUAL > 20" -f "AN > 9" unfiltered.vcf > filtered.vcf

# FreeBayes has a quirk where it sometimes records haplotypes rather than individual variants; we want to override this behavior
vcfallelicprimitives -kg filtered.vcf > decomposed.vcf

# in very rare cases, a single site may have more than two alleles detected in your sample; while these cases may be interesting, they may also reflect technical errors and also pose a challenge for parsing the data, so we remove them
vcfbreakmulti decomposed.vcf > biallelic.vcf