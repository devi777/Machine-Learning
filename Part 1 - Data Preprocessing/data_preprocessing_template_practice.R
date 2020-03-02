
datasets = read.csv('Data.csv')

datasets$Age = ifelse(is.na(datasets$Age),
                      ave(datasets$Age,FUN=function(x) mean(x,na.rm=TRUE) ),
                      datasets$Age)

datasets$Salary = ifelse(is.na(datasets$Salary),
                      ave(datasets$Salary,FUN=function(x) mean(x,na.rm=TRUE) ),
                      datasets$Salary)

datasets$Country = factor(datasets$Country,levels=c('France','Spain','Germany'),labels = c(1,2,3))
datasets$Purchased = factor(datasets$Purchased,levels=c('Yes','No'),labels = c(1,2))

#install.packages('caTools')
set.seed(123)
split = sample.split(datasets$Purchased,SplitRatio = 0.8)

training_set = subset(datasets,split==TRUE)
test_set = subset(datasets,split==FALSE)

training_set = scale(training_set)
test_set = scale(test_set)

#values not numeric.. the one we categorized with factors
#So not going to apply scaling to dummy variables and dependent variables 'yes' and 'no'

training_set[,2:3] = scale(training_set[,2:3])
test_set[,2:3] = scale(test_set[,2:3])
