# -*- coding: utf-8 -*-
"""
Created on Fri Dec 27 23:05:31 2019

@author: devan
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#Importing the datatset
dataset = pd.read_csv('Mall_Customers.csv')
X = dataset.iloc[:,[3,4]].values

#Finding the optimal no of clusters using dendograms
import scipy.cluster.hierarchy as sch
dendrogram = sch.dendrogram(sch.linkage(X,method='ward'))
plt.title('Dendogram')
plt.xlabel('Custmoers')
plt.ylabel('Euclidean distances')
plt.show()

#ward method tries to minimize the variance between clusters
#fit the algorithm to our data 
from sklearn.cluster import AgglomerativeClustering
hc = AgglomerativeClustering(n_clusters=5,affinity="euclidean",linkage='ward')
y_hc = hc.fit_predict(X)

#Visualizing our results
plt.scatter(X[y_hc==0,0],X[y_hc==0,1],s = 100,c = 'red',label='Careful')
plt.scatter(X[y_hc==1,0],X[y_hc==1,1],s = 100,c = 'blue',label='Standard')
plt.scatter(X[y_hc==2,0],X[y_hc==2,1],s = 100,c = 'green',label='Target')
plt.scatter(X[y_hc==3,0],X[y_hc==3,1],s = 100,c = 'cyan',label='Careless')
plt.scatter(X[y_hc==4,0],X[y_hc==4,1],s = 100,c = 'magenta',label='Sensible')
plt.title('Clusters of clients')
plt.xlabel('Annuual Income(k$)')
plt.ylabel('Spending Score(1-100)')
plt.legend()
plt.show()

#false - hc perorms better than kmeans in large datasets