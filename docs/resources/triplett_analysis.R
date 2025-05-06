
# Setup -------------------------------------------------------------------

# install, then comment out this line
install.packages(c("tidyverse", "corrplot","effectsize", "lmerTest"))

# activate installed packages
library(tidyverse)
library(effectsize)
library(corrplot)
library(lmerTest)

# check your current 'working directory'
# it should be your project folder
getwd()


# Data import -------------------------------------------------------------

# read the data file, assigning it to a name
triplett_data <- read_csv("triplett_data.csv")


# Data cleaning -----------------------------------------------------------


## Selecting ----

triplett_data  |>
  select(subject, age, gender)

# you can also rename as you select

# dropping columns by name
triplett_data |>
  select(-classification, -gender)

# selecting when column name contains("a string")
triplett_data |>
  select(subject, contains("_1"))

# try selecting just the "competition" trial columns

## Filtering ----

triplett_data_subset <- triplett_data |>
  filter(group == "A") # subset the dataframe keeping only Group A

## Mutating ----

triplett_data <- triplett_data |>
  mutate(gender = factor(gender),
         group = factor(group))

triplett_data_recoded <- triplett_data |>
  mutate(alone_mean = rowMeans(across(contains("alone"))))

# produces NAs for some participants! oh no! why? can you fix it?

# can you add code to get the mean competition score, and a difference score?

triplett_data_recoded <- triplett_data_recoded |>
  mutate(effect = case_when(
    diff < -sd(diff) ~ "improved",
    diff > sd(diff) ~ "impaired",
    TRUE ~ "no difference"
  ))

## Reshaping ----

triplett_long <- triplett_data |>
  pivot_longer(contains(c("alone", "competition")),
               names_to = c("condition", "trial"),
               names_sep = "_",
               values_to = "performance")


# Saving files ------------------------------------------------------------

saveRDS(triplett_long, "triplett_long.RDS")

readr::write_csv(triplett_long, "triplett_long.csv")

# Data exploration ----

triplett_data_recoded |>
  select(age, gender, group, alone_mean, competition_mean, diff) |>
  summary()


triplett_data_recoded |>
  count(gender, classification) |>
  mutate(prop = n / sum(n), .by = gender)


## Summarize ----

triplett_data_recoded |>
  summarize(n = n(),
            mean_diff = mean(diff),
            sd_diff = sd(diff),
            min = min(diff),
            max = max(diff),
            range = max - min)

## Summarize by group ----

triplett_data_recoded |>
  summarize(n = n(),
            mean_diff = mean(diff),
            sd_diff = sd(diff),
            range = max(diff) - min(diff),
            .by = gender)

# can you summarize by one of the other categorical variables?

## Summarize by lots of groups ----

complex_summary <- triplett_long |>
  summarize(average = mean(performance),
            .by = c(classification, condition, trial, group))


# Data visualization ------------------------------------------------------


## Histogram ----

triplett_data_recoded |>
  ggplot(aes(x = diff)) + # only x aesthetic is required for histogram
  geom_histogram(bins = 10)

# Create a custom theme object

theme_apa <- theme(
  panel.background = element_blank(),
  axis.line = element_line(),
  axis.text = element_text(size = 20),
  axis.title = element_text(size = 22),
  legend.text = element_text(size = 20),
  legend.title = element_text(size = 22)
)

# remake the histogram with new theme added
triplett_data_recoded |>
  ggplot(aes(x = diff)) + # only x aesthetic is required for histogram
  geom_histogram(bins = 10, color = "white") +
  theme_apa

## Scatterplot ----

triplett_data_recoded |>
  ggplot(aes(x = age, y = alone_0)) +
  geom_point(position = "jitter") +
  theme_apa

## Scatterplot with grouping variable

triplett_data_recoded |>
  ggplot(aes(x = age, y = alone_0, color = gender)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_apa

## Plotting descriptives ----

triplett_data |>
  ggplot(aes(x = factor(age), y = alone_0, color = gender)) +
  geom_boxplot() +
  theme_apa

# adding summarize to the plotting pipeline
triplett_long |>
  summarize(performance = mean(performance, na.rm = TRUE),
            .by = c(trial, condition)) |>
  ggplot(aes(x = trial, y = performance, fill = condition)) +
  geom_col(position = "dodge") +
  theme_apa



## Analyses ----------------------------------------------------------------


## Correlations -----------------------------------------------------------

cor.test(x = triplett_data$age, y = triplett_data$alone_0)

### correlation matrix
triplett_data |>
  select(contains("alone"), contains("competition")) |>
  cor(use = "pairwise") |>
  corrplot::corrplot(method = 'shade')


## Chi-square -------------------------------------------------------------

chisq.test(x = triplett_data_recoded$classification,
           y = triplett_data_recoded$gender)


## t-tests ----------------------------------------------------------------

t.test(alone_0 ~ gender, data = triplett_data)

t.test(x = triplett_data_recoded$alone_mean,
       y = triplett_data_recoded$competition_mean,
       paired = TRUE)

# getting measures of effect size

effectsize::cohens_d(alone_0 ~ gender, data = triplett_data)


effectsize::cohens_d(x = triplett_data_recoded$alone_mean,
                     y = triplett_data_recoded$competition_mean,
                     paired = TRUE)


## ANOVA -----------------------------------------------------------------

# independent samples
aov(diff ~ classification, data = triplett_data_recoded)

anova <- aov(diff ~ classification, data = triplett_data_recoded)
summary(anova)

# related-samples
aov(performance ~ condition + Error(subject/condition), data = triplett_long) |>
  summary()


## Regression ------------------------------------------------------------

lm(diff ~ age + gender + group, data = triplett_data_recoded) |>
  summary(regression_model)


## Mixed-models ----------------------------------------------------------

# with lme4::lmer
mixed_model <- lme4::lmer(
  performance ~ condition * age + group + (1 | subject),
  data = triplett_long
)

summary(mixed_model)

# with lmerTest::lmer for p values
mixed_model <- lmerTest::lmer(
  performance ~ condition * age + group + (1 | subject),
  data = triplett_long
)

summary(mixed_model)
