**Exercise 1**   
   
bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam   
samtools sort -o A01_01.bam A01_01.sam   
samtools index A01_01.bam   
samtools idxstats A01_01.bam > A01_01.idxstats   
   

**Exercise 2**   
Description: the aligment result is consistent with the results in BYxRM_GenoData.txt.   

For example, the aligment result shows that at position chrI:27915, A01_01-06 show C, T, C, C, T, T, respectively, with the reference sequence showing T. This is consistene with the result in the row 27915_chr01_27915_T_C in BYxRM_GenoData.txt, showing that at position chrI:27915, A01_01-06 show characteristic SNPs of R, B, R, R, B, B, respectively.    

**Exercise 4**
Minimap2 command:
minimap2 -ax map-ont /Users/cmdb/Data/References/sacCer3/sacCer3.fa.gz ERR8562478.fastq > longreads.sam

