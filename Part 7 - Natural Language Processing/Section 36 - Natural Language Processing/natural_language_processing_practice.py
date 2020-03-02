# -*- coding: utf-8 -*-
"""
Created on Wed Jan  1 10:12:50 2020

@author: devan
"""
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

dataset = pd.read_csv('Restaurant_Reviews.tsv', delimiter = '\t',quoting = 3)

#Cleaning the texts
#dataset['Review'][0]
import re
import nltk
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer          #Stemming
nltk.download('stopwords')

corpus = []                                         #Corpus is a collection of texts
for i in range(0,1000):
    review = re.sub('[^a-zA-Z]',' ', dataset['Review'][i])
    review = review.lower()
    review = review.split()
    ps = PorterStemmer()
    review = [ps.stem(word) for word in review if not word in set(stopwords.words('english'))] 
    #Using set function makes it go faster in case.. we have just a line here, but still we will use it
    review = ' '.join(review)
    corpus.append(review)
    
#Creating the bag of words model through the process of tokenization
from sklearn.feature_extraction.text import CountVectorizer
cv = CountVectorizer(max_features = 1500)     
#can use token_pattern,stopwords,lowercase instead of doing it before
#but we dont do it this way.. doing this manually like we did before gives us more control
X = cv.fit_transform(corpus).toarray()
y = dataset.iloc[:,1].values

#Copying naive bayes practice python file
# Splitting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

# Fitting classifier to the Training set
from sklearn.naive_bayes import GaussianNB
classifier = GaussianNB()
classifier.fit(X_train,y_train)

# Predicting the Test set results
y_pred = classifier.predict(X_test)

# Making the Confusion Matrix
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)

(55+91)/200 #accuracy