## random forest model

library(tidyverse)
library(caret)
library(mlbench)
library(rpart)
library(rpart.plot)

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes


set.seed(24)
n <- nrow(df)
id <- sample(n, size = 0.8*n)
train_df <- df[id, ]
test_df <- df[-id, ]


ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)


rf_model <- train(diabetes ~. ,
                    data = train_df,
                    method = "rf",
                    # complexity parameter
                    # high cp -> good generalization
                  
                    tuneLength = 5,
#alternative        tuneGrid = expand.grid(mtry = c(3,5)),
                    trControl = ctrl)


## score new dataset

p <- predict(rf_model, newdata = test_df)


## evaluate model

confusionMatrix(p, test_df$diabetes,
                positive = "pos",
                mode = "prec_recall")


