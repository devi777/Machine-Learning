#Importing the dataset
dataset = read.csv('Market_Basket_Optimisation.csv',header = FALSE)

#Apriori takes the input dataset as a sparse matrix..not a csv file
#(the matrix that has a lotta zeroes)

library(arules)
dataset = read.transactions('Market_Basket_Optimisation.csv',sep = ',',rm.duplicates = TRUE)
summary(dataset)
#distribution of transactions with duplicates:
#1 
#5 
#means that we have 5 transactions containing one duplicates

#frequency plot of the top products bought by the customers
itemFrequencyPlot(dataset,topN = 100)
itemFrequencyPlot(dataset,topN = 10)

#Training apriori on the dataset
#minimum support = products that are bought atleast 3/4 times a day
#min support = 7*3 / 7500 = 0.0028 (21 times atleast in a week)
rules = apriori(data  = dataset,parameter = list(support = 0.003 , confidence = 0.4))

#0 rules found.. that means that we have kept the confidence way too high.. 80%
rules = apriori(data  = dataset,parameter = list(support = 0.003 , confidence = 0.4))

#Visualizing the results and sort the rules
inspect(sort(rules,by='lift')[1:10])

rules = apriori(data  = dataset,parameter = list(support = 0.003 , confidence = 0.2))
inspect(sort(rules,by='lift')[1:10])

#min support = 4*7/7500
rules = apriori(data  = dataset,parameter = list(support = 0.004 , confidence = 0.2))
inspect(sort(rules,by='lift')[1:10])
