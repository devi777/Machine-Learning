#

datasets = read.csv('50_Startups.csv')

datasets$State = factor(datasets$State,
                          levels=c('New York','California','Florida'),
                          labels = c(1,2,3))

#install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(datasets$Profit,SplitRatio = 0.8)
training_set = subset(datasets,split==TRUE)
test_set = subset(datasets,split==FALSE)

#regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State)
regressor = lm(formula = Profit ~ .,
               data = training_set)

y_pred = predict(regressor,newdata = test_set)

#applying backward eliination
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = datasets)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = datasets)
summary(regressor)
regressor = lm(formula = Profit ~ R.D.Spend,
               data = datasets)
summary(regressor)

