datasets = read.csv('Position_Salaries.csv')
datasets = datasets[2:3]

#fitting linear regression to the dataset
lin_reg = lm(formula = Salary ~ .,
               data = datasets)
#y_pred = predict(regressor,newdata = test_set)

#fitting polynomial regression to the datatset
#adding another column .. x2
datasets$level2 =  datasets$Level^2
datasets$level3 =  datasets$Level^3
datasets$level4 =  datasets$Level^4

poly_reg = lm(formula = Salary ~ .,
               data = datasets)

#visualising linear regression results
ggplot() +
  geom_point(aes(x= datasets$Level,y= datasets$Salary),color='red') +
  geom_line(aes(x=datasets$Level,y=predict(lin_reg,newdata = datasets)),
            color='blue') + 
  ggtitle('Position Salaries(Linear Regression)') +
  xlab('Level') + 
  ylab('Salary')

#visualising polynomial regression results
ggplot() +
  geom_point(aes(x= datasets$Level,y= datasets$Salary),color='red') +
  geom_line(aes(x=datasets$Level,y=predict(poly_reg,newdata = datasets)),
            color='blue') + 
  ggtitle('Position Salaries(Linear Regression)') +
  xlab('Level') + 
  ylab('Salary')

#predicting a new result with linear regression
Y_pred = predict(lin_reg,data.frame(Level = 6.5))

#predicting a new result with polynomial regression
Y_pred = predict(poly_reg,data.frame(Level = 6.5,
                                     level2 = 6.5^2,
                                     level3 = 6.5^3,
                                     level4 = 6.5^4))