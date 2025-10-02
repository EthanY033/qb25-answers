library(tidyverse)

AF_dt <- read_delim(
  "/Users/cmdb/qb25-answers/week3/AF.txt", col_names = TRUE, delim = "\n")

ggplot(AF_dt, aes(x = `Allele Frequencies (AF)`)) +
  geom_histogram(bins = 11) +
  labs(
    x = "Allele Frequencies",
    y = "Counts",
    title = "Distribution of Allele Frequencies"
  )
ggsave("/Users/cmdb/qb25-answers/week3/AF.png")

DP_dt <- read_delim(
  "/Users/cmdb/qb25-answers/week3/DP.txt", col_names = TRUE, delim = "\n")

ggplot(DP_dt, aes(x = `Read Depths (DP)`)) +
  geom_histogram(bins = 21) +
  xlim(0, 20) +
  labs(
    x = "Read Depths",
    y = "Counts",
    title = "Distribution of Read Depths"
  )
ggsave("/Users/cmdb/qb25-answers/week3/DP.png")

