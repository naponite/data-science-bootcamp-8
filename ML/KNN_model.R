# KNN model

set.seed(24)
ctrl <- trainControl(
  method = "cv", # default CV is K-Fold
  number = 5, 
  verboseIter = TRUE # to print resampling data log
)



model <- train(medv ~ rm + b + crim + lstat + age,
               data = train_data,
               method = "knn",
               preProcess = c("range", "zv", "nzv"),
               tuneLength = 5,
               trControl = ctrl)


# 3. score/ predict new data (test/ unseen data)
p <- predict(model, newdata=test_data)

# 4. evaluate model => prefer absolute metrics
# mae, mse, rmse
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

cal_mae(test_data$medv, p)
cal_mse(test_data$medv, p)
cal_rmse(test_data$medv, p)



# train final model using k=5
model_k5 <- train(medv ~ rm + b + crim + lstat + age,
                  data = train_data,
                  method = "knn",
                  preProcess = c("range", "zv", "nzv"),
                  tuneGrid = data.frame(k=5),
                  trControl = trainControl(method = "none"))

# 3. score/ predict new data (test/ unseen data)
p_k5 <- predict(model_k5, newdata=test_data)

# 4. evaluate model => prefer absolute metrics
# mae, mse, rmse
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

cal_mae(test_data$medv, p_k5)
cal_mse(test_data$medv, p_k5)
cal_rmse(test_data$medv, p_k5)

