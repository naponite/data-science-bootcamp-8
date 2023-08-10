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


# 1. split data 80% train, 20% test

split_data <- function(df) {
  set.seed(24)
  n <- nrow(df)
  train_id <- sample(1:n, size = 0.8*n)
  train_df <- df[train_id, ]
  test_df <- df[-train_id, ]
  return(list(training = train_df,
              testing = test_df))
  
  }

prep_df <- split_data(clean_df)
train_df <- prep_df[[1]]
test_df <- prep_df[[2]]

# 2. train model
lm_model <- train(mpg ~.,
                  data = train_df,
                  # Model algorithm
                  model ="lm")

# 3. score model
p <- predict(lm_model, newdata = test_df)

# 4. evaluate model
# mean absolute error
(mea <- mean(abs(p - test_df$mpg)))

# root mean square error
(rmse <- sqrt(mean((p - test_df$mpg)**2)))









