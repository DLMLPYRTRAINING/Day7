# Example Problem
# For this analysis, we will use the cars dataset that comes with R by default. 
# cars is a standard built-in dataset, that makes it convenient to demonstrate 
# linear regression in a simple and easy to understand fashion. You can access 
# this dataset simply by typing in cars in your R console. You will find that 
# it consists of 50 observations(rows) and 2 variables (columns) – dist and speed. 
# Lets print out the first six observations here..


head(cars)  # display the first 6 observations
#>   speed dist
#> 1     4    2
#> 2     4   10
#> 3     7    4
#> 4     7   22
#> 5     8   16
#> 6     9   10

# Graphical Analysis
# 
# The aim of this exercise is to build a simple regression model 
# that we can use to predict Distance (dist) by establishing a statistically 
# significant linear relationship with Speed (speed). 
# But before jumping in to the syntax, lets try to understand these variables graphically. 
# Typically, for each of the independent variables (predictors), 
# the following plots are drawn to visualize the following behavior:
#   
#   Scatter plot: Visualize the linear relationship between the predictor and response
# Box plot: To spot any outlier observations in the variable. Having outliers in your 
# predictor can drastically affect the predictions as they can easily affect the direction/slope 
# of the line of best fit.
# Density plot: To see the distribution of the predictor variable. 
# Ideally, a close to normal distribution (a bell shaped curve), 
# without being skewed to the left or right is preferred. Let us see how to make each one of them.

# Scatter Plot

scatter.smooth(x=cars$speed, y=cars$dist, main="Dist ~ Speed")  # scatterplot

# BoxPlot – Check for outliers

# Generally, any datapoint that lies outside the 
# 1.5 * interquartile-range (1.5 * IQR) is 
# considered an outlier, where, IQR is calculated as the 
# distance between the 25th percentile and 75th percentile values for that variable.

par(mfrow=c(1, 2))  # divide graph area in 2 columns
boxplot(cars$speed, main="Speed", sub=paste("Outlier rows: ", boxplot.stats(cars$speed)$out))  # box plot for 'speed'
boxplot(cars$dist, main="Distance", sub=paste("Outlier rows: ", boxplot.stats(cars$dist)$out))  # box plot for 'distance'

# Density plot – Check if the response variable is close to normality
install.packages("e1071")
library(e1071)
par(mfrow=c(1, 2))  # divide graph area in 2 columns
plot(density(cars$speed), main="Density Plot: Speed", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(cars$speed), 2)))  # density plot for 'speed'
polygon(density(cars$speed), col="red")
plot(density(cars$dist), main="Density Plot: Distance", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(cars$dist), 2)))  # density plot for 'dist'
polygon(density(cars$dist), col="red")

# Correlation

# Correlation is a statistical measure that suggests the level of linear 
# dependence between two variables, that occur in pair – 
# just like what we have here in speed and dist. 
# Correlation can take values between -1 to +1.

# A value closer to 0 suggests a weak relationship between the variables. 
# A low correlation (-0.2 < x < 0.2) probably 
# suggests that much of variation of the response variable (Y) is 
# unexplained by the predictor (X), in which case, 
# we should probably look for better explanatory variables.

cor(cars$speed, cars$dist)  # calculate correlation between speed and distance 
#> [1] 0.8068949

# Build Linear Model

linearMod <- lm(dist ~ speed, data=cars)  # build linear regression model on full data
print(linearMod)
#> Call:
#> lm(formula = dist ~ speed, data = cars)
#> 
#> Coefficients:
#> (Intercept)        speed  
#>     -17.579        3.932

# Linear Regression Diagnostics

summary(linearMod)  # model summary
#> Call:
#> lm(formula = dist ~ speed, data = cars)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -29.069  -9.525  -2.272   9.215  43.201 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
#> speed         3.9324     0.4155   9.464 1.49e-12 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 15.38 on 48 degrees of freedom
#> Multiple R-squared:  0.6511, Adjusted R-squared:  0.6438 
#> F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

# How to know if the model is best fit for your data?
# The most common metrics to look at while selecting the model are:
  
# STATISTIC	CRITERION
# R-Squared ->	Higher the better (> 0.70)
# Adj R-Squared ->	Higher the better
# F-Statistic ->	Higher the better
# Std. Error ->	Closer to zero the better
# t-statistic ->	Should be greater 1.96 for p-value to be less than 0.05
# AIC ->	Lower the better
# BIC ->	Lower the better
# Mallows cp ->	Should be close to the number of predictors in model
# MAPE (Mean absolute percentage error) ->	Lower the better
# MSE (Mean squared error) ->	Lower the better
# Min_Max Accuracy  -> mean(min(actual, predicted)/max(actual, predicted))	Higher the better

# Predicting Linear Models

# Step 1: Create the training (development) and test (validation) data samples from original data.
# Create Training and Test data -
set.seed(100)  # setting seed to reproduce results of random sampling
trainingRowIndex <- sample(1:nrow(cars), 0.8*nrow(cars))  # row indices for training data
trainingData <- cars[trainingRowIndex, ]  # model training data
testData  <- cars[-trainingRowIndex, ]   # test data

# Step 2: Develop the model on the training data and use it to predict the distance on test data

# Build the model on training data -
lmMod <- lm(dist ~ speed, data=trainingData)  # build the model
distPred <- predict(lmMod, testData)  # predict distance

# Step 3: Review diagnostic measures.
summary (lmMod)  # model summary
#> 
#> Call:
#> lm(formula = dist ~ speed, data = trainingData)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -23.350 -10.771  -2.137   9.255  42.231 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  -22.657      7.999  -2.833  0.00735 ** 
#> speed          4.316      0.487   8.863 8.73e-11 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 15.84 on 38 degrees of freedom
#> Multiple R-squared:  0.674,  Adjusted R-squared:  0.6654 
#> F-statistic: 78.56 on 1 and 38 DF,  p-value: 8.734e-11
AIC (lmMod)  # Calculate akaike information criterion
#> [1] 338.4489

# Step 4: Calculate prediction accuracy and error rates

actuals_preds <- data.frame(cbind(actuals=testData$dist, predicteds=distPred))  # make actuals_predicteds dataframe.
correlation_accuracy <- cor(actuals_preds)  # 82.7%
head(actuals_preds)
#>    actuals predicteds
#> 1        2  -5.392776
#> 4       22   7.555787
#> 8       26  20.504349
#> 20      26  37.769100
#> 26      54  42.085287
#> 31      50  50.717663

min_max_accuracy <- mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))  
# => 58.42%, min_max accuracy
mape <- mean(abs((actuals_preds$predicteds - actuals_preds$actuals))/actuals_preds$actuals)  
# => 48.38%, mean absolute percentage deviation


# k- Fold Cross validation
install.packages("DAAG")
library(DAAG)
cvResults <- suppressWarnings(CVlm(data=cars, form.lm=dist ~ speed, m=5, dots=FALSE, seed=29, legend.pos="topleft",  printit=FALSE, main="Small symbols are predicted values while bigger ones are actuals."));  # performs the CV
attr(cvResults, 'ms')  # => 251.2783 mean squared error
