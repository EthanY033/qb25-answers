library(tidyr)
library(dplyr)
library(matrixStats)
library(ggplot2)


####### Step 1.1 #######
data_rna <- as.matrix(read.table("/Users/cmdb/qb25-answers/week7/read_matrix.tsv"))

data_rna <- data_rna %>% 
  cbind(rowSds(data_rna))

colnames(data_rna)[22] <- "Sd"
data_rna <- data_rna[order(data_rna[, "Sd"], decreasing = TRUE), ]
data_rna_sd500 <- data_rna[1:500, ]

####### Step 1.2 #######
data_rna_sd500 <- t(data_rna_sd500[, -22])

pca_results = prcomp(data_rna_sd500)

####### Step 1.3 #######

PC_12 <- data.frame(pca_results$x[, 1:2])
PC_12$legend <- rownames(PC_12)
PC_12 <- PC_12 %>%
  separate(legend, into = c("Tissue", "Replicate"), sep = "_")

PC_12 %>% 
  ggplot(aes(PC1, PC2, color=Tissue, shape=Replicate)) +
  geom_point() +
  theme_classic()
ggsave("/Users/cmdb/qb25-answers/week7/PCA_plot.png")


data_rna_sd500_norm <- scale(data_rna_sd500)

pca_results_norm = prcomp(data_rna_sd500_norm)
PC_12_norm <- data.frame(pca_results_norm$x[, 1:2])
PC_12_norm$legend <- rownames(PC_12_norm)
PC_12_norm <- PC_12_norm %>%
  separate(legend, into = c("Tissue", "Replicate"), sep = "_")

PC_12_norm %>% 
  ggplot(aes(PC1, PC2, color=Tissue, shape=Replicate)) +
  geom_point() +
  theme_classic()
ggsave("/Users/cmdb/qb25-answers/week7/PCA_plot_normalized.png")

png("pca_heatmap_x.png")
heatmap(as.matrix(pca_results_norm$x), Rowv = NA, Colv = NA)
dev.off()

png("pca_heatmap_rotation.png", width = 800, height = 600)
heatmap(as.matrix(pca_results_norm$rotation), Rowv = NA, Colv = NA)
dev.off()

var <- pca_results_norm$sdev^2 / sum(pca_results_norm$sdev^2) * 100
var_data <- data.frame(
  PC = c(1: 21),
  var = var
)

ggplot(var_data, aes(x = PC, y = var)) +
  geom_bar(stat = "identity") +
  labs(title = "Variance Explained by Principal Components",
       x = "Number of Principal Components",
       y = "Variance Explained (%)") +
  theme_minimal()
ggsave("/Users/cmdb/qb25-answers/week7/variance_explained.png")

####### Step 2.1 #######

combined = data_rna[,seq(1, 21, 3)]
combined = combined + data_rna[,seq(2, 21, 3)]
combined = combined + data_rna[,seq(3, 21, 3)]
combined = combined / 3

combined <- combined  %>% 
  cbind(rowSds(combined))
colnames(combined)[8] <- "Sd"

combined <- combined[order(combined[, "Sd"], decreasing = TRUE), ]
combined_selected <- combined[combined[, "Sd"] > 1, ]

####### Step 2.2 #######

set.seed(42)
kmeans_results = kmeans(scale(as.matrix(combined_selected[, -8])), centers = 12, nstart = 100) 

cluster_sorted <- kmeans_results$cluster
cluster_sorted <- cluster_sorted[rownames(combined_selected)]
combined_cluster <- cbind(combined_selected, cluster_sorted)

combined_cluster <- combined_cluster[order(combined_cluster[, "cluster_sorted"]), ]

png("cluster_heatmap.png")
heatmap(combined_cluster, Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[combined_cluster[,9]], ylab="Gene")
dev.off()

####### Step 3 #######

names <- combined_cluster[combined_cluster[, "cluster_sorted"] == 2, ] %>% 
  rownames()

fs <- file("cluster2.txt", open = "w")

# With help from teacher
# Write each line individually
for (item in names) {
  writeLines(item, fs)
}

close(fs)


