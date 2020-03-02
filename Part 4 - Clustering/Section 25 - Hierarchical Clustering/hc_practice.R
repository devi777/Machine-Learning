#Importing the dataset
dataset = read.csv('Mall_Customers.csv')
X = dataset[4:5]

#Finding the optimal no of clusters using dendrograms
#dist = euclidean distance matrix for data x
dendrogram = hclust(dist(X,method = "euclidean"),method="ward.D")
plot(dendrogram,
     main=paste('Dendrogram'),
     xlab = 'Customers',
     ylab = 'Euclidean distances')

#Fitting hierarchical clustering algorithm to the dataset
hc = hclust(dist(X,method = "euclidean"),method="ward.D")
y_hc = cutree(hc,k=5)

#Plotting the clusters
library(cluster)
clusplot(X,
         y_hc,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Clusters of clients'),
         xlab= "Annual Income",
         ylab = "Spending Score")

#false - hc perorms better than kmeans in large datasets