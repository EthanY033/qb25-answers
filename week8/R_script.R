####### Step 1.1 #######

library(tidyverse)
library(DESeq2)
library(ggplot2)
library(broom)
library(dplyr)

data_gtex <- read_delim("/Users/cmdb/qb25-answers/week8/gtex_whole_blood_counts_downsample.txt")
data_gtex <- column_to_rownames(data_gtex, "GENE_NAME")

people_info <- read_delim("/Users/cmdb/qb25-answers/week8/gtex_metadata_downsample.txt")

chromo_info <- read_delim("/Users/cmdb/qb25-answers/week8/gene_locations.txt")

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
# ANSWER: 48% of variance is explained by PC1 and 7% by PC2. PC2 appears to be 
# associated with sex.

png("pca_dthhrdy.png")
plotPCA(vsd, intgroup = "DTHHRDY") + ggtitle("PCA Plot Grouped by DTHHRDY")
dev.off()
# ANSWER: 48% of variance is explained by PC1 and 7% by PC2. PC1 appears to be 
# associated with death reasons. 

png("pca_age.png")
plotPCA(vsd, intgroup = "AGE") + ggtitle("PCA Plot Grouped by AGE")
dev.off()
# ANSWER: 48% of variance is explained by PC1 and 7% by PC2. PC2 appears to be 
# more associated with age. 


####### Step 2.1 #######

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(people_info, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>% 
  tidy()
m1
# ANSWER: WASH7P do NOT show significant evidence of sex-differential expression,
# because the p value is larger than 0.05.

m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>% 
  tidy()
m2
# ANSWER: SLC25A47 DO show significant evidence of sex-differential expression,
# because the p value is smaller than 0.05.

####### Step 2.2 #######

dds <- DESeq(dds)

####### Step 2.3 #######

res_sex_original <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

res_sex <- res_sex_original %>% 
  filter(padj > 0) %>%
  filter(padj < 0.1)
nrow(res_sex)
# ANSWER: 259 genes exhibit significant differential expression between males 
# and females at a 10% FDR.

res_sex <- res_sex %>% 
  left_join(chromo_info, by = "GENE_NAME") %>% 
  arrange(padj)
head(res_sex)
# ANSWER: Top hits: DDX3Y, PRKY, EIF1AY, etc. 
# Y chromosome encodes most of strongly upregulated genes in males versus females, 
# because there is no Y chromosome in female. 
# There are more male-upregulated genes on the top of the list, because there 
# is no Y chromosome in female.

res_sex_original %>% 
  filter(GENE_NAME == "WASH7P")
# ANSWER: results on WASH7P by two methods are broadly consistent on it's insignificance.

res_sex_original %>% 
  filter(GENE_NAME == "SLC25A47")
# ANSWER: results on SLC25A47 by two methods are broadly consistent on it's significance.

# REFLECTION: 
# If you set the threshold lower, you will get less false positives, but will get more 
# false negatives. Using a very stringent FDR threshold will give less false positives 
# but more false negatives, while using a lenient one will give more false positives 
# but less false negatives. Using a very stringent FDR threshold will give less type I errors 
# but more type II errors , while using a lenient one will give more type I errors  
# but less type II errors. 
# Larger sample size means more replicates and less random variety between samples, 
# which will make the test more accurate. A larger effect size means greater differences 
# between affected samples and control samples, which will also make the differences easier
# to capture even with small sample size. 

####### Step 2.4 #######

res_death_original <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")

res_death <- res_death_original %>% 
  filter(padj > 0) %>%
  filter(padj < 0.1)
nrow(res_death)
# ANSWER: 16069 genes exhibit significant differential expression according to death classification 
# at a 10% FDR.

####### Step 2.5 #######

sex_shuffle <- people_info %>% 
  mutate(SEX = sample(SEX))

dds_shuffle <- DESeqDataSetFromMatrix(countData = data_gtex,
                                colData = sex_shuffle,
                                design = ~ SEX + DTHHRDY + AGE)

dds_shuffle <- DESeq(dds_shuffle)

res_sex_shuffle <- results(dds_shuffle, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

res_sex_shuffle <- res_sex_shuffle %>% 
  filter(padj > 0) %>%
  filter(padj < 0.1) 
nrow(res_sex_shuffle)
# ANSWER: 933 genes exhibit significant differential expression between males 
# and females at a 10% FDR.
# By FDR threshold controlling, the significant result number decreases from the
# false-positive-rich 933 to false-positive-controlled 259. The shows that FDR 
# threshold controlling filters out lots of false positive results. 


####### Step 3 #######

res_sex_original <- res_sex_original %>% 
  filter(padj > 0) %>% 
  left_join(chromo_info, by = "GENE_NAME") %>% 
  arrange(padj) %>% 
  mutate(flag = if_else(log2FoldChange > 1 | padj < 0.1, "highlighted", "common"))

ggplot(data = res_sex_original, aes(x = log2FoldChange, y = -log10(padj), color = flag)) +
  geom_point(size = 0.8) +
  scale_color_manual(values = c("highlighted" = "red", "common" = "black")) +
  labs(title = "Volcano plot for differential expression")
ggsave("volcano_plot.png")  
