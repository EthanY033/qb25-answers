#!/bin/bash

mv ~/Downloads/nhek.bed ./              
mv ~/Downloads/nhlf.bed ./
grep 1_Active nhek.bed > nhek-active.bed
grep 1_Active nhlf.bed > nhlf-active.bed
grep 12_Repressed nhlf.bed > nhlf-repressed.bed
grep 12_Repressed nhek.bed > nhek-repressed.bed
wc -l nhek-active.bed 
#   14013 nhek-active.bed
wc -l nhek-repressed.bed 
#   32314 nhek-repressed.bed
wc -l nhlf-active.bed 
#   14888 nhlf-active.bed
wc -l nhlf-repressed.bed 
#   34469 nhlf-repressed.bed

bedtools intersect -a nhek-active.bed -b nhlf-active.bed
# ...
#chr22	50945334	50946134	1_Active_Promoter	0	.	50945334	50946134
#chr22	50946534	50947134	1_Active_Promoter	0	.	50946534	50947134
#chr22	50963534	50965334	1_Active_Promoter	0	.	50963534	50965334
#chr22	51020534	51021334	1_Active_Promoter	0	.	51020334	51021334
#chr22	51021534	51022134	1_Active_Promoter	0	.	51021534	51022134
#chr22	51066134	51066534	1_Active_Promoter	0	.	51065934	51066534
#chr22	51221534	51222734	1_Active_Promoter	0	.	51221334	51222734

bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed
# ...
#chr22	46929336	46929536	1_Active_Promoter	0	.	46929336	46929536
#chr22	46933136	46933336	1_Active_Promoter	0	.	46933136	46933336
#chr22	46933736	46934536	1_Active_Promoter	0	.	46933736	46934536
#chr22	48027136	48028736	1_Active_Promoter	0	.	48027136	48028736
#chr22	50623673	50624273	1_Active_Promoter	0	.	50623673	50624273
#chr22	50968534	50970934	1_Active_Promoter	0	.	50968534	50970934
#chr22	51001134	51001734	1_Active_Promoter	0	.	51001134	51001734
#chr22	51066734	51067334	1_Active_Promoter	0	.	51066734	51067334

bedtools intersect -a nhek-active.bed -b nhlf-active.bed | wc -l
#   12174

bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed | wc -l
#    2405

wc -l nhek-active.bed 
#   14013 nhek-active.bed
# 12174 + 2405 = 14579 > 14013

bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed | wc -l
#   11608
# 11608 + 2405 = 14013 = 14013

bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed | head -1
#chr1	25558413	25559413	1_Active_Promoter	0	.	25558413	25559413
# Pattern -f 1 requires that 100% of each active sequence from nhek-active.bed is 
# overlapped by sequence from nhlf-active.bed. So, the active sequences from 
# nhlf-active.bed includes the active ones from nhek-active.bed. The lengths of the 
# active sequences from nhlf-active.bed are longer than or equal to the active ones 
# from nhek-active.bed

bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed | head -1
#chr1	19923013	19924213	1_Active_Promoter	0	.	19922613	19924613
# Pattern -F 1 requires that 100% of each active sequence from nhlf-active.bed is 
# overlapped by sequence from nhek-active.bed. So, the active sequences from 
# nhek-active.bed includes the active ones from nhlf-active.bed. The lengths of the 
# active sequences from nhek-active.bed are longer than or equal to the active ones 
# from nhlf-active.bed

bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed | head -1
#chr1	1051137	1051537	1_Active_Promoter	0	.	1051137	1051537
# Pattern -f 1 and -F 1 require that both sequences from nhek-active.bed and
# nhlf-active.bed are 100% overlapped by sequence from the other file. Thus, the active
# sequences from nhek-active.bed and nhlf-active.bed are identical, with exactly the 
# same length

# Active in NHEK, Active in NHLF:
bedtools intersect -a nhek-active.bed -b nhlf-active.bed | head -1
#chr1	19923013	19924213	1_Active_Promoter	0	.	19922613	19924613
# The active sequence from nhek-active.bed includes the active one from 
# nhlf-active.bed. The length of the active sequences from nhek-active.bed is 
# longer than the active ones from nhlf-active.bed

# Active in NHEK, Repressed in NHLF:
bedtools intersect -a nhek-active.bed -b nhlf-repressed.bed | head -1
#chr1	1981140	1981540	1_Active_Promoter	0	.	1981140	1981540
# The repressive sequences from nhlf-repressed.bed includes the active one from 
# nhek-active.bed. The length of the repressed sequence from nhlf-repressed.bed is
# longer than the active one from nhek-active.bed

# Repressed in NHEK, Repressed in NHLF: 
bedtools intersect -a nhek-repressed.bed -b nhlf-repressed.bed | head -1
#chr1	11537413	11538213	12_Repressed	0	.	11534013	11538613
# The repressive sequence from nhek-repressed.bed includes the repressed one from 
# nhlf-repressed.bed. The length of the repressed sequence from nhek-repressed.bed is
# longer than the repressed one from nhlf-repressed.bed

mv ~/Downloads/active-active.pdf ./ 
mv ~/Downloads/active-repressed.pdf ./
mv ~/Downloads/repressed-repressed.pdf ./

git add shh.pdf
git add tp53.pdf
git add active-active.pdf
git add active-repressed.pdf
git add repressed-repressed.pdf
git add exercise3.sh
git commit -m "exercise 3"
git push