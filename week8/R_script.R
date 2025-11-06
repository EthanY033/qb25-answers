####### Step 1.1 #######

library(tidyverse)
library(DESeq2)
library(ggplot2)
library(broom)

data_gtex <- read_delim("/Users/cmdb/qb25-answers/week8/gtex_whole_blood_counts_downsample.txt")
data_gtex <- column_to_rownames(data_gtex, "GENE_NAME")

people_info <- read_delim("/Users/cmdb/qb25-answers/week8/gtex_metadata_downsample.txt")

####### Step 1.2 #######

names_data_gtex <- colnames(data_gtex)[3:ncol(data_gtex)]
names_people_info <- people_info$SUBJECT_ID
identical(names_people_info, names_data_gtex)

# load DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = data_gtex,
                              colData = people_info,
                              design = ~ SEX + DTHHRDY + AGE)

####### Step 1.3 #######

vsd <- vst(dds)

# codes for adding title and saving to pngs are assisted by AI.
png("pca_sex.png")
plotPCA(vsd, intgroup = "SEX") + ggtitle("PCA Plot Grouped by SEX")
dev.off()
# Answers: 48% of variance is explained by PC1 and 7% by PC2. PC2 appears to be 
# associated with sex.

png("pca_dthhrdy.png")
plotPCA(vsd, intgroup = "DTHHRDY") + ggtitle("PCA Plot Grouped by DTHHRDY")
dev.off()
# Answers: 48% of variance is explained by PC1 and 7% by PC2. PC1 appears to be 
# associated with death reasons. 

png("pca_age.png")
plotPCA(vsd, intgroup = "AGE") + ggtitle("PCA Plot Grouped by AGE")
dev.off()
# Answers: 48% of variance is explained by PC1 and 7% by PC2. PC2 appears to be 
# more associated with age. 


####### Step 2.1 #######

