library(tidyverse)
library(caret)
library(mlbench)

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes

## skip split data process
## focus at train model
set.seed(24)
n <- nrow(df)
id <- sample(n, size = 0.8*n)
train_df <- df[id, ]
test_df <- df[-id, ]

ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)

logistic_model <- train(diabetes ~. ,
                        data = train_df,
                        method = "glm",
                        trControl = ctrl)

## score new dataset

p <- predict(logistic_model, newdata = test_df)


## evaluate model

confusionMatrix(p, test_df$diabetes,
                positive = "pos",
                mode = "prec_recall")




### ridge/lasso regression 
### regularized regression
my_grid <- expand.grid(alpha = 0:1,
                       lambda = seq(0.0005, 0.05, length =20))

glmnet_model <- train(diabetes ~. ,
                        data = train_df,
                        method = "glmnet",
                        tuneGrid = my_grid,
                        trControl = ctrl)

## score new dataset

p <- predict(glmnet_model, newdata = test_df)


## evaluate model

confusionMatrix(p, test_df$diabetes,
                positive = "pos",
                mode = "prec_recall")
