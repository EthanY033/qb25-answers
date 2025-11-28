library(ggplot2)
library(tidyr)

######--------------######
###### 3 x Coverage ######
######--------------######

## Read the txt file
genome_coverage_3 = scan("/Users/cmdb/qb25-answers/week11/genome_coverage_3.txt")

## get the range of coverages observed
maxcoverage_3 = as.integer(max(genome_coverage_3))
total_length_3 = length(genome_coverage_3)

## Count how many times each coverage appear
frequencies_3 <- as.data.frame(table(genome_coverage_3))

## Generate new columns to hold values
frequencies_3$normal = rep(0, dim(frequencies_3)[1])
frequencies_3$poisson = rep(0, dim(frequencies_3)[1])

## Normalize the normal distribution, to solve the issue of values below 0
ratio_3 = 1 / pnorm(0, mean = 3, sd = 1.73, lower.tail = FALSE)

## Fill the data frame with frequencies
## Frequency = CDF * total_length
for (i in 1:(dim(frequencies_3)[1])) {
  frequencies_3$normal[i] = total_length_3 * ratio_3 * (pnorm(i-0.5, mean = 3, sd = 1.73) - pnorm(i-1.5, mean = 3, sd = 1.73))
  frequencies_3$poisson[i] = total_length_3 * dpois(i-1, 3)
}

## Transform the dataframe into long form
frequencies_3_long <- pivot_longer(frequencies_3,
                        cols = c(Freq, normal, poisson),
                        names_to = "Subject",
                        values_to = "Freq")

## now plot the histogram and probability distributions
ggplot(data = frequencies_3_long, aes(x = genome_coverage_3, y = Freq, fill = Subject)) +
  geom_col(position = "dodge", alpha = 0.8) +
  labs(
    title = "Distribution of coverages with 3x coverage",
    x = "Coverages",
    y = "Counts"
  ) +
  theme_classic()
ggsave("/Users/cmdb/qb25-answers/week11/ex1_3x_cov.png")

## 0 coverage occurences:
cat("0 coverage occurence of 3x coverage:", 100 * frequencies_3$Freq[1] / 1000000, "%")





######--------------######
###### 10 x Coverage #####
######--------------######

## Read the txt file
genome_coverage_10 = scan("/Users/cmdb/qb25-answers/week11/genome_coverage_10.txt")

## get the range of coverages observed
maxcoverage_10 = as.integer(max(genome_coverage_10))
total_length_10 = length(genome_coverage_10)

## Count how many times each coverage appear
frequencies_10 <- as.data.frame(table(genome_coverage_10))

## Generate new columns to hold values
frequencies_10$normal = rep(0, dim(frequencies_10)[1])
frequencies_10$poisson = rep(0, dim(frequencies_10)[1])

## Normalize the normal distribution, to solve the issue of values below 0
ratio_10 = 1 / pnorm(0, mean = 3, sd = 1.73, lower.tail = FALSE)

## Fill the data frame with frequencies
## Frequency = CDF * total_length
for (i in 1:(dim(frequencies_10)[1])) {
  frequencies_10$normal[i] = total_length_10 * ratio_10 * (pnorm(i-0.5, mean = 10, sd = 3.16) - pnorm(i-1.5, mean = 10, sd = 3.16))
  frequencies_10$poisson[i] = total_length_10 * dpois(i-1, 10)
}

## Transform the dataframe into long form
frequencies_10_long <- pivot_longer(frequencies_10,
                                   cols = c(Freq, normal, poisson),
                                   names_to = "Subject",
                                   values_to = "Freq")

## now plot the histogram and probability distributions
ggplot(data = frequencies_10_long, aes(x = genome_coverage_10, y = Freq, fill = Subject)) +
  geom_col(position = "dodge", alpha = 0.8) +
  labs(
    title = "Distribution of coverages with 10x coverage",
    x = "Coverages",
    y = "Counts"
  ) +
  theme_classic()
ggsave("/Users/cmdb/qb25-answers/week11/ex1_10x_cov.png")

## 0 coverage occurences:
cat("0 coverage occurence of 10x coverage:", 100 * frequencies_10$Freq[1] / 1000000, "%")





######--------------######
###### 30 x Coverage ######
######--------------######

## Read the txt file
genome_coverage_30 = scan("/Users/cmdb/qb25-answers/week11/genome_coverage_30.txt")

## get the range of coverages observed
maxcoverage_30 = as.integer(max(genome_coverage_30))
total_length_30 = length(genome_coverage_30)

## Count how many times each coverage appear
frequencies_30 <- as.data.frame(table(genome_coverage_30))

## Generate new columns to hold values
frequencies_30$normal = rep(0, dim(frequencies_30)[1])
frequencies_30$poisson = rep(0, dim(frequencies_30)[1])

## Normalize the normal distribution, to solve the issue of values below 0
ratio_30 = 1 / pnorm(0, mean = 3, sd = 1.73, lower.tail = FALSE)

## Fill the data frame with frequencies
## Frequency = CDF * total_length
for (i in 1:(dim(frequencies_30)[1])) {
  frequencies_30$normal[i] = total_length_30 * ratio_30 * (pnorm(i-0.5, mean = 30, sd = 5.47) - pnorm(i-1.5, mean = 30, sd = 5.47))
  frequencies_30$poisson[i] = total_length_30 * dpois(i-1, 30)
}

## Transform the dataframe into long form
frequencies_30_long <- pivot_longer(frequencies_30,
                                   cols = c(Freq, normal, poisson),
                                   names_to = "Subject",
                                   values_to = "Freq")

## now plot the histogram and probability distributions
ggplot(data = frequencies_30_long, aes(x = genome_coverage_30, y = Freq, fill = Subject)) +
  geom_col(position = "dodge", alpha = 0.8) +
  labs(
    title = "Distribution of coverages with 30x coverage",
    x = "Coverages",
    y = "Counts"
  ) +
  theme_classic()
ggsave("/Users/cmdb/qb25-answers/week11/ex1_30x_cov.png")

## 0 coverage occurences:
cat("0 coverage occurence of 30x coverage:", 100 * frequencies_30$Freq[1] / 1000000, "%")
