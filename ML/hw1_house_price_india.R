library(tidyverse)
library(caret)
library(dplyr)
library(readxl)
library(ggplot2)


df <- read_excel("/cloud/project/ML/House Price India.xlsx", sheet = 2) 

# pre train model to find significant parameter

pre_model <- train(Price ~ .,
               data = df,
               method = "lm")

varImp(pre_model)
summary(pre_model)



# pre process
# select significant parameter from summary()

prep_df <- df %>%
  select ( bdrm = `number of bedrooms`,
           bhrm = `number of bathrooms`,
           lvar = `living area`,
           flr = `number of floors`,
           w_frnt = `waterfront present`,
           n_view = `number of views`,
           cond = `condition of the house`,
           grad = `grade of the house`,
           year = `Built Year`,
           post = `Postal Code`,
           lat = Lattitude,
           long = Longitude,
           price = Price)

# check price distribution
ggplot(data = prep_df , aes(price))+
  geom_histogram()


# normalize skew distribution by take log
prep_df_log <- prep_df
prep_df_log$price <- prep_df$price %>%
  log() # 

ggplot(data = prep_df_log , aes(price))+
  geom_histogram()

# 1. train test split
split_data <- function(df, train_size=0.8) {
  set.seed(24)
  n <- nrow(df)
  id <- sample(1:n, size = n*train_size)
  train_df <- df[id , ]
  test_df <- df[-id , ]
  list (train = train_df,
        test = test_df)
}

prep_data <- split_data(prep_df)
train_data <- prep_data[[1]]
test_data <- prep_data[[2]]

# normalize price distribution before train model
train_data_log <- train_data
train_data_log$price <- train_data$price %>%
  log()

test_data_log <- test_data
test_data_log$price <- test_data$price %>%
  log()

# 2. train model
model <- train(price ~ .,
               data = train_data_log,
               method = "lm")

varImp(model)
summary(model)

# predict train price with out log (use exp() to convert back)
p_train_log <- predict(model, newdata=train_data_log) 
p_train <- p_train_log %>%
  exp()


# 3. score/ predict new data (test/ unseen data)

p_test_log <- predict(model, newdata=test_data_log) 
p_test <- p_test_log %>%
  exp()

# 4. evaluate model

cal_mae <- function(actual, pred) {
  error <- actual - pred
  mean(abs(error))
  
}

cal_mse <- function(actual, pred) {
  error <- actual - pred
  mean((error)**2)
  
}

cal_rmse <- function(actual, pred) {
  error <- actual - pred
  sqrt(mean((error)**2))
  
}

## Evaluate model with train data (normal price)
act1 <- train_data$price
pred1 <- p_train

cal_mae(act1, pred1)
cal_mse(act1, pred1)
cal_rmse(act1, pred1)

## Evaluate model with test data (normal price)
act2 <- test_data$price
pred2 <- p_test

cal_mae(act2, pred2)
cal_mse(act2, pred2)
cal_rmse(act2, pred2)

## Evaluate model with train data (log price)
act3 <- train_data_log$price
pred3 <- p_train_log

cal_mae(act3, pred3)
cal_mse(act3, pred3)
cal_rmse(act3, pred3)

## Evaluate model with test data (log price)
act4 <- test_data_log$price
pred4 <- p_test_log

cal_mae(act4, pred4)
cal_mse(act4, pred4)
cal_rmse(act4, pred4)




## train model with out log using

model_nolog <- train(price ~ .,
               data = train_data,
               method = "lm")

varImp(model_nolog)
summary(model_nolog)


p_train2 <- predict(model_nolog, newdata=train_data) 

p_test2 <- predict(model_nolog, newdata=test_data) 


## Evaluate model_nolog with train data (normal price)
act5 <- train_data$price
pred5 <- p_train2

cal_mae(act5, pred5)
cal_mse(act5, pred5)
cal_rmse(act5, pred5)

## Evaluate model_nolog with test data (normal price)
act6 <- test_data$price
pred6 <- p_test2

cal_mae(act6, pred6)
cal_mse(act6, pred6)
cal_rmse(act6, pred6)
