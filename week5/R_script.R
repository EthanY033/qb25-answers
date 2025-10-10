library(tidyverse)
library(broom)

##### Exercise 1 #####
# Step 1.1
data_dnm <- read_csv(
  "/Users/cmdb/qb25-answers/week5/aau1043_dnm.csv")

# Step 1.2
data_dnm %>% 
  group_by(Proband_id, Phase_combined) %>% 
  summarise(count = n())

# Step 1.3
data_age <- read_csv(
  "/Users/cmdb/qb25-answers/week5/aau1043_parental_age.csv")

# Step 1.4
data_all <- right_join(data_dnm, data_age, by = "Proband_id")

