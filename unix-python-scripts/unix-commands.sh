#!/bin/bash

# Question 1
touch unix-commands.sh

open unix-commands.sh -a "visual studio code"

wc -l ce11_genes.bed 
# 53935 ce11_genes.bed

cut -f 1 ce11_genes.bed > ce11-chr.txt

uniq -c ce11-chr.txt
# 5460 chrI
#   12 chrM
# 9057 chrV
# 6840 chrX
# 6299 chrII
# 21418 chrIV
# 4849 chrIII

grep + ce11_genes.bed | wc -l
# 27309

grep - ce11_genes.bed | wc -l
# 26626

# Question 2
touch recalculate-score.py

open recalculate-score.py

chmod +x recalculate-score.py

./recalculate-score.py
# ...
# chrIII	13759439	13762069	NM_067439.6	-2630.0	-
# chrIII	13764029	13767080	NM_067441.4	-3051.0	-
# chrIII	13764029	13768092	NM_067440.7	-4063.0	-
# chrIII	13764061	13767318	NM_001027500.7	-26056.0	-
# chrIII	13764061	13768091	NM_001379990.2	-1362140.0	-
# chrIII	13764063	13768094	NM_001372677.2	-2184802.0	-
# chrIII	13764288	13767013	NM_067442.6	-1547800.0	-
# chrIII	13768540	13771741	NM_067444.8	-1648515.0	-
# chrIII	13769876	13769953	NR_003432.1	-693.0	-
# chrIII	13769891	13770045	NR_052851.1	616.0	+
# chrIII	13771507	13778908	NM_067446.7	4026144.0	+
# chrIII	13771512	13773345	NM_001372678.3	1050309.0	+
# chrIII	13771518	13773348	NM_001383028.1	977220.0	+
# chrIII	13771761	13773250	NM_001306674.3	658138.0	+
# chrIII	13773448	13781126	NM_001379991.1	46068.0	+
# chrIII	13778168	13782927	NR_166922.1	2013057.0	+
# chrIII	13780214	13781133	NM_067447.4	573456.0	+

# Question 3
cd 
cd Data/GTEx
cut -f 6 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort
#    1 SMTS
#    9 Fallopian Tube
#   19 Cervix Uteri
#   21 Bladder
#  104 Kidney
#  166 Uterus
#  173 Vagina
#  181 Salivary Gland
#  193 Small Intestine
#  195 Ovary
#  217 Bone Marrow
#  251 Liver
#  260 Spleen
#  262 Prostate
#  275 Adrenal Gland
#  301 Pituitary
#  360 Pancreas
#  381 Stomach
#  406 Testis
#  480 Breast
#  722 Nerve
#  812 Thyroid
#  821 Colon
#  867 Lung
# 1132 Muscle
# 1141 Heart
# 1327 Adipose Tissue
# 1473 Blood Vessel
# 1582 Esophagus
# 2014 Skin
# 3326 Brain
# 3480 Blood

cut -f 12 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | grep RNA | wc -l   
#    20016

cut -f 12 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | grep -v RNA | wc -l
#    2936

# Question 4
cd
cd /Users/cmdb/qb25-answers/unix-python-scripts
touch sample-by-gene.py 
open sample-by-gene.py 
cp /Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt /Users/cmdb/qb25-answers/unix-python-scripts
./sample-by-gene.py
# ...
# GTEX-ZZPU-1826-SM-5E43L 0 Esophagus - Muscularis
# GTEX-ZZPU-2126-SM-5EGIU 0 Ovary
# GTEX-ZZPU-2226-SM-5EGIV 0 Vagina
# GTEX-ZZPU-2426-SM-5E44I 0 Artery - Tibial
# GTEX-ZZPU-2626-SM-5E45Y 0.01965 Muscle - Skeletal
# The first three tissues that have >0 expression:
# GTEX-1117F-3226-SM-5N9CT 0.01776 Brain - Cortex
# GTEX-111CU-0126-SM-5GZWZ 0.03757 Adrenal Gland
# GTEX-111CU-0226-SM-5GZXC 0.04667 Thyroid

# Question 5
cp ~/Data/References/hg38/gencode.v46.basic.annotation.gtf.gz /Users/cmdb/qb25-answers/unix-python-scripts
gunzip gencode.v46.basic.annotation.gtf.gz 
wc -l gencode.v46.basic.annotation.gtf 
#  2024891 gencode.v46.basic.annotation.gtf

grep -v ## gencode.v46.basic.annotation.gtf | cut -f 3
# UTR
# UTR
# UTR
# transcript
# exon
# CDS
# start_codon
# exon
# CDS
# exon
# CDS
# exon
# CDS
# exon
# CDS
# exon
# CDS
# exon
# CDS
# exon
# CDS
# exon
# CDS

