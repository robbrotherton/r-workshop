## Setup ----

# install, then comment out this line
install.packages(c("corrplot","effectsize", "lme4"))

# activate installed packages
library(tidyverse)
library(effectsize)
library(corrplot)
library(lme4)

# check your current 'working directory'
# it should be your project folder
getwd()

### Data import ----

# read the data file, assigning it to a name
triplett_data <- read_csv("triplett_data.csv")

### Data cleaning ----

#### Selecting ----

triplett_data  |>
  select(subject, age, gender)

# you can also rename as you select

#### Mutating ----

#### Filtering ----

#### Reshaping ----

### Data exploration ----

### Data visualization ----

#### built-in plot() function ----

#### ggplot ----

