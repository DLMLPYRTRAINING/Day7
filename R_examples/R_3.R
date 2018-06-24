# Data Source: https://archive.ics.uci.edu/ml/machine-learning-databases/car/

install.packages("randomForest")
library(randomForest)
# Load the dataset and explore
data1 <- read.csv(file.choose(), header = TRUE)

head(data1)

str(data1)

summary(data1)

# Split into Train and Validation sets
# Training Set : Validation Set = 70 : 30 (random)
set.seed(100)
train <- sample(nrow(data1), 0.7*nrow(data1), replace = FALSE)
TrainSet <- data1[train,]
ValidSet <- data1[-train,]
summary(TrainSet)
summary(ValidSet)


# Create a Random Forest model with default parameters
model1 <- randomForest(unacc ~ ., data = TrainSet, importance = TRUE)
model1


# Fine tuning parameters of Random Forest model
model2 <- randomForest(unacc ~ ., data = TrainSet, ntree = 500, mtry = 6, importance = TRUE)
model2

# Predicting on train set
predTrain <- predict(model2, TrainSet, type = "class")
# Checking classification accuracy
table(predTrain, TrainSet$unacc)  


# Predicting on Validation set
predValid <- predict(model2, ValidSet, type = "class")
# Checking classification accuracy
mean(predValid == ValidSet$unacc)                    
table(predValid,ValidSet$unacc)

# To check important variables
importance(model2)        
varImpPlot(model2)  


# Using For loop to identify the right mtry for model
a=c()
i=5
for (i in 3:8) {
  model3 <- randomForest(unacc ~ ., data = TrainSet, ntree = 500, mtry = i, importance = TRUE)
  predValid <- predict(model3, ValidSet, type = "class")
  a[i-2] = mean(predValid == ValidSet$unacc)
}

a

plot(3:8,a)


# Compare with Decision Tree

install.packages("rpart")
install.packages("caret")
install.packages("e1071")

library(rpart)
library(caret)
library(e1071)
# We will compare model 1 of Random Forest with Decision Tree model

model_dt = train(unacc ~ ., data = TrainSet, method = "rpart")
model_dt_1 = predict(model_dt, data = TrainSet)
table(model_dt_1, TrainSet$unacc)

mean(model_dt_1 == TrainSet$unacc)


# Running on Validation Set
model_dt_vs = predict(model_dt, newdata = ValidSet)
table(model_dt_vs, ValidSet$unacc)

mean(model_dt_vs == ValidSet$unacc)




