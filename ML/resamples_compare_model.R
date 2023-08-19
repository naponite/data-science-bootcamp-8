## resamples() => compare model performance
## predict diabetes

library(tidyverse)
library(caret)
library(mlbench)
library(rpart)

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes


## decision tree model

set.seed(24)
n <- nrow(df)
id <- sample(n, size = 0.8*n)
train_df <- df[id, ]
test_df <- df[-id, ]


model1 <- train(diabetes ~. ,
                    data = train_df,
                    method = "glm",
                    trControl = trainControl(method = "cv",
                                             number = 5))

model2 <- train(diabetes ~. ,
                    data = train_df,
                    method = "rpart",
                    trControl = trainControl(method = "cv",
                                             number = 5))


model3 <- train(diabetes ~. ,
                data = train_df,
                method = "rf",
                trControl = trainControl(method = "cv",
                                         number = 5))

model4 <- train(diabetes ~. ,
                data = train_df,
                method = "glmnet",
                trControl = trainControl(method = "cv",
                                         number = 5))

list_models <- list(
  logistic = model1,
  tree = model2,
  randomforest = model3,
  glmnet = model4
  
)

result <- resamples(list_models)

summary(result)
