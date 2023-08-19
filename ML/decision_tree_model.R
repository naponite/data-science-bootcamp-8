library(tidyverse)
library(caret)
library(mlbench)
library(rpart)
library(rpart.plot)

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes


## decission tree model

set.seed(24)
n <- nrow(df)
id <- sample(n, size = 0.8*n)
train_df <- df[id, ]
test_df <- df[-id, ]


ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)


tree_model <- train(diabetes ~. ,
                        data = train_df,
                        method = "rpart",
                    # complexity parameter
                    # high cp -> good generalization
                        tuneGrid = expand.grid(cp = c(0.02, 0.1, 0.25)),
                        trControl = ctrl)

rpart.plot(tree_model$finalModel)

## score new dataset

p <- predict(tree_model, newdata = test_df)


## evaluate model

confusionMatrix(p, test_df$diabetes,
                positive = "pos",
                mode = "prec_recall")


