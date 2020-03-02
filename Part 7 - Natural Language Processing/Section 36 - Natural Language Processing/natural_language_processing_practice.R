#Importing the dataset
dataset_original = read.delim('Restaurant_Reviews.tsv',quote = '',stringsAsFactors = FALSE) 
#this means that it is ignoring any kind of quotes
#and not identify the reviews as factors

#Cleaning the texts and creating a corpus
#install.packages('tm')
library(tm)
library(SnowballC)
corpus = VCorpus(VectorSource(dataset$Review))
corpus = tm_map(corpus, content_transformer(tolower))
#as.character(corpus[[1]]),841
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords())
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)

#Creating the Bag of Words Model a.k.a
#creating the sparse matrix of features
dtm = DocumentTermMatrix(corpus)
dtm = removeSparseTerms(dtm, 0.999)

#We need to make a sure we have a dataframe like
#we had in classification models
dataset = as.data.frame(as.matrix(dtm))

#add the depndent variable column in the dataframe 
dataset$Liked = dataset_original$Liked

# Encoding the target feature as factor
dataset$Liked = factor(dataset$Liked, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting Random Forest Classification to the Training set
# install.packages('randomForest')
library(randomForest)
set.seed(123)
classifier = randomForest(x = training_set[-692],
                          y = training_set$Liked,
                          ntree = 10)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-692])

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)