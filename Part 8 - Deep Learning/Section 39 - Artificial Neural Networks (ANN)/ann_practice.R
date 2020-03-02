# Importing the dataset
dataset = read.csv('Churn_Modelling.csv')
dataset = dataset[4:14]

dataset$Geography = as.numeric(factor(dataset$Geography,
                                      levels = c('France', 'Spain', 'Germany'),
                                      labels = c(1, 2, 3)))
dataset$Gender = as.numeric(factor(dataset$Gender,
                                      levels = c('Female', 'Male'),
                                      labels = c(1, 2)))


# Encoding the target feature as factor
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Exited, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[-11] = scale(training_set[-11])
test_set[-11] = scale(test_set[-11])

# Fitting ANN to the Training set
#install.packages('h2o')
library(h2o)
h2o.init(nthreads = -1 )
classifier = h20.deeplearning()

#Only Java 8, 9, 10, 11 and 12 are supported, for h2o 
#system version is 13.0.1 

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-3])

# Making the Confusion Matrix
cm = table(test_set[, 3], y_pred)
