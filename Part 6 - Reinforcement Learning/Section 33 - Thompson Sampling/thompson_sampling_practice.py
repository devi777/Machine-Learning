# -*- coding: utf-8 -*-
"""
Created on Tue Dec 31 10:37:40 2019

@author: devan
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#CTR - click through rate
dataset = pd.read_csv('Ads_CTR_Optimisation.csv')

#Implemeting UCB without any package
import random
N= 10000
d = 10
ads_selected = []
no_1 = [0] * d
no_0 = [0] * d
total_reward = 0
for n in range(0,N):
    ad = 0
    max_random = 0
    for i in range(0,d):
        random_beta = random.betavariate(no_1[i] + 1,no_0[i] + 1)
        if random_beta > max_random:
            max_random = random_beta
            ad = i
    ads_selected.append(ad)
    reward = dataset.values[n,ad]
    if reward ==1:
        no_1[ad] = no_1[ad] + 1
    else:
        no_0[ad] = no_0[ad] + 1
    total_reward = total_reward + reward
    
#Visualising the results
plt.hist(ads_selected)
plt.title('Histogram of Ads Selections')
plt.xlabel('Ad')
plt.ylabel('No. of times each ad was selected')
plt.show()