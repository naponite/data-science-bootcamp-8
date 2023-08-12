# tuneLength vs tuneGrid (set K manually)

set.seed(24)
ctrl <- trainControl(
  method = "cv", # default CV is K-Fold
  number = 5, 
  verboseIter = TRUE # to print resampling data log
)



model <- train(medv ~ rm + b + crim + lstat + age,
               data = train_data,
               method = "knn",
               metric = "Rsquared",  #set metric
               preProcess = c("center", "scale"),
               tuneGrid = data.frame(k = c(5,7,13)),
               trControl = ctrl)
