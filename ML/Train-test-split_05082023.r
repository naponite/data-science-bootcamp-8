library(tidyverse)
library(caret)

## Classification And Regression Tree => caret
## Created by Max Kuhn

# Simple ML pipeline
# 0. prep data/clean data
# 1. split data => train test split
# 2. train model
# 3. score model aka. prediction
# 4. evaluate model

full_df <- mtcars %>%
  select(mpg, hp, wt, am)

# check missing value
full_df %>%
  complete.cases() %>%
  mean()

# clean data - drop row with NA
clean_df <- full_df %>%
  drop_na()







