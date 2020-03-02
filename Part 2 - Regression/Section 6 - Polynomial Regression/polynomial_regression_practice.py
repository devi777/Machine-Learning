# -*- coding: utf-8 -*-
"""
Created on Sat Dec 21 16:58:16 2019

@author: devan
"""
# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('Position_Salaries.csv')
X = dataset.iloc[:, 1:2].values #to make it a matrix rather than a vector
y = dataset.iloc[:, -1].values

#no splitting here

#2 linear regressors

#Fitting Linear Regression to the dataset
from sklearn.linear_model import LinearRegression
lin_reg = LinearRegression()
lin_reg.fit(X,y)

#Fitting polynomial regression to the dataset
#converts Linear reg x to moultiple powers
from sklearn.preprocessing import PolynomialFeatures
poly_reg = PolynomialFeatures(degree= 4)
X_poly = poly_reg.fit_transform(X)

#0 is the column of x0 here
#include this to a multiple linear regression model
lin_reg2 = LinearRegression()
lin_reg2.fit(X_poly,y)

#Visualising the linear regression results
plt.scatter(X,y,color='red')
plt.plot(X,lin_reg.predict(X),color='blue')
plt.title('Position Salaries(Linear Regression)')
plt.xlabel('Position Level')
plt.ylabel('Salary')
plt.show()

#Visualising the polynomial regression results

#plt.plot(X_poly,lin_reg2.predict(X),color='blue')
#plt.plot(X,lin_reg2.predict(X_poly),color='blue')

#we dont want x_poly here because it is defined as an existent matrix of features x
#so we put the below line to generalize it for any x 
#(though the result is the same if we replace poly_reg.fit_transform(X) with X_poly)
X_grid = np.arange(min(X),max(X),0.1)
X_grid = X_grid.reshape((len(X_grid), 1))
plt.scatter(X,y,color='red')
#plt.plot(X,lin_reg2.predict(poly_reg.fit_transform(X)),color='blue')
plt.plot(X_grid,lin_reg2.predict(poly_reg.fit_transform(X_grid)),color='blue')
plt.title('Position Salaries(Polynomial Regression)')
plt.xlabel('Position Level')
plt.ylabel('Salary')

#making the plot machine better by adding a degree = 3
#making the plot machine better by adding a degree = 4
#making the plot machine better by making the plot look like a curve rather
#than a combination of straight lines.. adding x_grid
plt.show()


#predcting the result with Linear regression
a = np.array(6.5)
lin_reg.predict(a.reshape(-1,1))

#predcting the result with polynomial regression
lin_reg2.predict(poly_reg.fit_transform(a.reshape(-1,1)))