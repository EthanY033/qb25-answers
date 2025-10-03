library(tidyverse)

data_dt <- read_delim(
  "/Users/cmdb/qb25-answers/week3/gt_long.txt", col_names = TRUE, delim = "\t")

data_dt <-  data_dt %>% 
  mutate(Genotype = case_when(
    Genotype == 0 ~ "Reference",
    Genotype == 1 ~ "Alternative"))

data_62 <- data_dt[data_dt$`Sample ID` == "A01_62", ]

data_62_chrII <- data_62[data_62$Chromosome == "chrII", ] %>% 
  ggplot(aes(x = Position, fill = Genotype)) +
    geom_histogram() +
    labs(
      x = "Position in the chromosome",
      y = "Counts",
      title = "Ancestry of A01_62 on chrII"
      )

ggsave("/Users/cmdb/qb25-answers/week3/Ancestry-A01_62-chrII.png")


ggplot(data_62, aes(x = Position, fill = Genotype)) +
  geom_histogram() +
  facet_grid(Chromosome ~ ., scales = "free_x", space = "free_x") +
  labs(
    x = "Position in the chromosome",
    y = "Counts",
    title = "Ancestry of A01_62 on Every Chromosome"
  )

ggsave("/Users/cmdb/qb25-answers/week3/Ancestry-A01_62.png")

ggplot(data_dt, aes(x = Position, fill = Genotype)) +
  geom_histogram() +
  facet_grid(Chromosome ~ `Sample ID`, scales = "free_x", space = "free_x") +
  labs(
    x = "Position in the chromosome",
    y = "Counts",
    title = "Ancestry of Every Sample on Every Chromosome"
  )

ggsave("/Users/cmdb/qb25-answers/week3/Ancestry-all.png")
