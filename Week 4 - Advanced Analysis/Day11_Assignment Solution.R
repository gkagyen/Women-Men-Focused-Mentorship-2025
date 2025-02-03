library(dplyr)

# Load dataset and remove categorical variables 
mtcars_data <- mtcars |> select("mpg", "hp", "wt", "disp", "drat", "qsec")

# Standardize the data 
mtcars_scaled <- scale(mtcars_data)  

# Perform PCA 
pca_mtcars <- prcomp(mtcars_scaled) 
print(pca_mtcars)
summary(pca_mtcars)

variance_mtcars <- pca_mtcars$sdev^2 / sum(pca_mtcars$sdev^2)  

ggplot(data = data.frame(PC = 1:length(variance_mtcars), 
                         Variance = variance_mtcars),
       aes(x = PC, y = Variance)) +   
  geom_bar(stat = "identity", fill = "navy", colour = 'black') +   
  geom_line(aes(group = 1), colour = "brown", linewidth = 1.2) +   
  labs(title = "Scree Plot of PCA (mtcars)", 
       x = "Principal Components", 
       y = "Variance Explained") +   
  theme_bw()

# Convert PCA results to a data frame 
pca_mtcars_df <- as_tibble(pca_mtcars$x) |> 
  mutate(Cylinders = as.factor(mtcars$cyl))

# Scatter plot of first two PCs 
ggplot(pca_mtcars_df, aes(x = PC1, y = PC2, colour = Cylinders)) +   
  geom_point(size = 2.5) +   
  labs(title = "PCA of mtcars Dataset", 
       x = "Principal Component 1", 
       y = "Principal Component 2") +   
  facet_wrap(~Cylinders, scale = 'free_y',
             labeller = labeller(Cylinders = c('4' = 'Four Cylinder',
                                              '6' = 'Six Cylinder',
                                              '8' = 'Eight Cylinder'))) +
  scale_colour_viridis_d(option = 'turbo') +
  theme_bw() +
  theme(plot.title = element_text(colour = 'black', hjust = 0.5, size = 16, face = 'bold'),
        strip.background = element_rect(fill = 'lightgreen', colour = 'black', linewidth = 1),
        strip.text = element_text(size = 11, face = 'italic', colour = 'black'),
        legend.position = 'none'
  )
