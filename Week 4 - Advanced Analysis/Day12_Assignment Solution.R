library(dplyr)
library(gridExtra)

## KMEANS ---------------------------------------------------------------------------
# Standardize data 
mtcars_scaled <- mtcars |> select("mpg", "hp", "wt") |> scale()

# Find optimal k 
wss_mtcars <- sapply(1:10, function(k) {   
  kmeans(mtcars_scaled, centers = k, nstart = 10)$tot.withinss 
  }
)  

ggplot(data.frame(Clusters = 1:10, WSS = wss_mtcars), 
       aes(x = Clusters, y = WSS)) +   geom_point() +   
  geom_line(colour='navy', linewidth = 1) +  
  scale_x_continuous(breaks = c(1:10)) +
  labs(title = "Elbow Method for Optimal K", 
       x = "Number of Clusters", y = "Within-Cluster Sum of Squares") +   
  theme_bw()  

# Perform K-means with k = 5 
set.seed(123) 
kmeans_mtcars <- kmeans(mtcars_scaled, centers = 3, nstart = 25)  

# Add clusters 
mtcars_clustered <- mtcars 
mtcars_clustered <- mtcars |> mutate(Cluster = as.factor(kmeans_mtcars$cluster))  

# Visualize clusters 
km <- ggplot(mtcars_clustered, aes(x = mpg, y = wt, colour = Cluster)) +   
  geom_point(size = 3) +   
  labs(title = "K-Means Clustering on mtcars", x = "MPG", y = "Weight") +   
  theme_bw()

mt <- ggplot(mtcars_clustered, aes(x = mpg, y = wt, colour = factor(cyl))) +   
  geom_point(size = 3) +   
  labs(title = "Original Grouped data", 
       x = "MPG", y = "Weight", colour = 'Cylinders') +   
  theme_bw()

grid.arrange(km, mt)


## HIERARCHICAL CLUSTERING ----------------------------------------------------------
# Compute distance matrix 
dist_mtcars <- dist(mtcars_scaled, method = "euclidean")  

# Perform hierarchical clustering 
hc_mtcars <- hclust(dist_mtcars, method = "complete")  

# Plot dendrogram 
plot(hc_mtcars, main = "Hierarchical Clustering Dendrogram", cex = 0.7, sub = "", xlab = "")  

# Cut tree into 3 clusters 
clusters_mtcars <- cutree(hc_mtcars, k = 3)  

# Add clusters to dataset
mtcars_hc <- mtcars 
mtcars_hc <- mtcars |> mutate(Cluster = as.factor(kmeans_mtcars$cluster))

# Visualize clusters 
a <- ggplot(mtcars_hc, aes(x = mpg, y = wt, colour = Cluster)) +   
  geom_point(size = 3) +   
  labs(title = "Hierarchical Clustering on mtcars", x = "MPG", y = "Weight") +
  theme_bw() +
  theme(legend.position = 'inside',
        legend.position.inside = c(0.8, 0.7),
        legend.background = element_rect(colour='black'))

b <- ggplot(mtcars_hc, aes(x = mpg, y = wt, colour = factor(cyl))) +   
  geom_point(size = 3) +   
  labs(title = "Original Data Grouped by Cylinders", 
       x = "MPG", y = "Weight", colour = 'Cylinders') +
  theme_bw() +
  theme(legend.position = 'inside',
        legend.position.inside = c(0.8, 0.7),
        legend.background = element_rect(colour='black'))

cowplot::plot_grid(a, b, labels = 'AUTO')
