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


##### Exercise 2 #####
# Step 2.1
data_summary <- data_dnm %>% 
  group_by(Proband_id, Phase_combined) %>% 
  summarise(count = n()) %>% 
  right_join(data_age, by = "Proband_id") %>% 
  pivot_wider(
    names_from = Phase_combined,
    values_from = count
  )

data_summary %>%
  ggplot(aes(x = Mother_age, y = mother)) +
  geom_point() +
  labs(
    x = "Maternal age",
    y = "Maternal DNMs",
    title = "Maternal DNM Counts vs. Maternal Age"
  )
ggsave("/Users/cmdb/qb25-answers/week5/ex2_a.png")

data_summary %>%
  ggplot(aes(x = Father_age, y = father)) +
  geom_point() +
  labs(
    x = "Paternal age",
    y = "Paternal DNMs",
    title = "Paternal DNM Counts vs. Paternal Age"
  )
ggsave("/Users/cmdb/qb25-answers/week5/ex2_b.png")

# Step 2.2
model_maternal <- lm(data = data_summary, formula = mother ~ 1 + Mother_age)
summary(model_maternal)

# Step 2.3
model_paternal <- lm(data = data_summary, formula = father ~ 1 + Father_age)
summary(model_paternal)

# Step 2.4
predict(model_paternal, newdata = data.frame(Father_age = 50.5))

# Step 2.5
data_summary %>%
  select(father, mother) %>% 
  pivot_longer(
    cols = c(father, mother),
    names_to = "source",
    values_to = "DNM"
  ) %>% 
  ggplot(aes(x = DNM, fill = source)) +
    geom_histogram(alpha = 0.5, position = "identity") +
    labs(
      x = "Number of DNMs",
      y = "Count",
      title = "Distributions of Maternal and Paternal DNMs"
    )
ggsave("/Users/cmdb/qb25-answers/week5/ex2_c.png")

# Step 2.6
t.test(data_summary$mother, data_summary$father, paired = TRUE)

data_summary %>%
  select(father, mother) %>% 
  pivot_longer(
    cols = c(father, mother),
    names_to = "source",
    values_to = "DNM"
    ) %>% 
  mutate(source = case_when(
    source == "mother" ~ 0,
    source == "father" ~ 1)
    ) %>% 
  lm(formula = DNM ~ 1 + source) %>% 
  summary()

