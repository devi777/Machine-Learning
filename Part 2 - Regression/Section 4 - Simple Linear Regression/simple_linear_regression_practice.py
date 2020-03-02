# -*- coding: utf-8 -*-
"""
Created on Mon Dec 16 22:34:30 2019

@author: devan
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#reading dataset and declaring independent and dependent variables
dataset = pd.read_csv('Salary_Data.csv')
X = dataset.iloc[:,:-1].values
Y = dataset.iloc[:,-1].values

#splitting test and train sets
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size = 1/3, random_state = 0) 

#scaling data so that one of them doesn't dominate, like Salary dominates on Age
#Feature Scaling
"""from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)"""

#machine learning correlations from training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train,Y_train)

#trained machine predicts values using X_test = independent 
#test dataset
y_pred = regressor.predict(X_test)

#plotting the graph and coloring observation points red
plt.scatter(X_train,Y_train, color='red' )

#plotting the blue regresssion line of the training set
plt.plot(X_train, regressor.predict(X_train), color='blue')
plt.title('Salary vs Experience(Training Set)')
plt.xlabel('Years Of Experience')
plt.ylabel('Salary')
plt.show()

#plotting the graph and coloring observation points red
plt.scatter(X_test,Y_test, color='red' )

#plotting the blue regresssion line of the training/testing set
#both sets have the same equation
plt.plot(X_train, regressor.predict(X_train), color='blue')
plt.title('Salary vs Experience(Test Set)')
plt.xlabel('Years Of Experience')
plt.ylabel('Salary')
plt.show()
