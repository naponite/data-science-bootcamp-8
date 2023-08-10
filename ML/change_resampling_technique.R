
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

