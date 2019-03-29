# Setting working directory
setwd("/Users/nezihyalabik/Desktop/School book 2/Pazarlama analizi/R scripts/week5")

# Collecting missing packages
install.packages("randomForest")
library(randomForest)

# Read the Data
df<-read.csv("Churn_Modelling.csv",header=T)

# Checking basic stats of the data
summary(df)

str(df)

# Getting rid of unique attributes
df <- df[-c(1,2,3)]

# Convert from int to factor
df$Exited <- as.factor(df$Exited)

# Shuffling Splitting data into train and test sets
row_count <- nrow(df)
shuffled_rows <- sample(row_count)
train <- df[head(shuffled_rows,floor(row_count*0.75)),]
test <- df[tail(shuffled_rows,floor(row_count*0.25)),]


# Create a Random Forest model with default parameters
model1 <- randomForest(Exited ~ ., data = train, importance = TRUE)
model1

Call:
  randomForest(formula = Exited ~ ., data = train, importance = TRUE) 
Type of random forest: classification
Number of trees: 500
No. of variables tried at each split: 3

OOB estimate of  error rate: 13.43%
Confusion matrix:
  0   1 class.error
0 5776 202  0.03379057
1  805 717  0.52890933


# Predicting on train set
predTrain <- predict(model1, train, type = "class")
# Checking classification accuracy
table(predTrain, train$Exited)  

# Confussion matrix
predTrain    0     1
0           5978   2
1            0    1520

# Prediction on test set
predTest <- predict(model1, test, type = "class")
table(predTest, test$Exited) 

# Accuracy calc.
a <- test$Exited
acc = sum(predTest == a)/length(a)
acc
> acc
[1] 0.8588
