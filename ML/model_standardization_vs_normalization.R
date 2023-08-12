# model standardization vs model normalization 
# almost used in regression model

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
