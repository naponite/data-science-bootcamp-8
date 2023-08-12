
## train control
## change resampling technique
ctrl <- trainControl(
  method = "boot",
  number = 50,  # change resampling frequency
  verboseIter = TRUE # to print resampling data log
)



model <- train(medv ~ rm + b + crim,
               data = train_data,
               method = "lm",
               trControl = ctrl)

## use LOOCV technique

ctrl <- trainControl(
  method = "LOOCV",
  #number = 50,  # no need to set frequency
  verboseIter = TRUE # to print resampling data log
)



model <- train(medv ~ rm + b + crim,
               data = train_data,
               method = "lm",
               trControl = ctrl)

## use K-Fold CV technique
## Golden rule
set.seed(24)
ctrl <- trainControl(
  method = "cv", # default CV is K-Fold
  number = 5, 
  verboseIter = TRUE # to print resampling data log
)



model <- train(medv ~ rm + b + crim,
               data = train_data,
               method = "lm",
               preProcess = c("center", "scale"), # for standardization (z-score)
               # preProcess = c("range"), for normalization
               trControl = ctrl)

## variable importance
varImp(model)


## repeated K-Fold CV technique

set.seed(24)
ctrl <- trainControl(
  method = "repeatedcv", # repeated K-Fold
  number = 5, # k = 5
  repeats = 5, # repeats = 5
  verboseIter = TRUE # to print resampling data log
)



model <- train(medv ~ rm + b + crim,
               data = train_data,
               method = "lm",
               trControl = ctrl)

## variable importance
varImp(model)

