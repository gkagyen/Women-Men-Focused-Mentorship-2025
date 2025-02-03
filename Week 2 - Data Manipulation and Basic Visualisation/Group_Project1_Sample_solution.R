library(dplyr)
library(ggplot2)

# IMPORT AND INSPECT THE DATA----------------------------------------------------------------------
# Import dataset
data <- read.csv("student_performance.csv")

# Inspect the dataset
glimpse(data)
summary(data)
head(data)

# CLEAN DATA --------------------------------------------------------------------------------------
# Replace missing test scores with the mean of the respective column
data <- data |> mutate(Math_Score = if_else(is.na(Math_Score), mean(Math_Score, na.rm = T), Math_Score),
                       Science_Score = if_else(is.na(Science_Score), mean(Science_Score, na.rm = T), Math_Score))

# Remove outlier values from maths score (scores greater than 100)
data <- data |> filter(Math_Score <= 100 )

# change all inconsistent capitalisation in gender (change everything to lower-case)
data <- data |> mutate(Gender = tolower(Gender))

# EDA ----------------------------------------------------------------------------------------------
# Summary STats for Scores
summary_stats <- data %>% summarise(
  Avg_Math = mean(Math_Score),
  Avg_English = mean(English_Score),
  Avg_Science = mean(Science_Score)
)
print(summary_stats)

gender_summary <- data %>% group_by(Gender) %>%
  summarise(
    Avg_Math = mean(Math_Score),
    Avg_English = mean(English_Score),
    Avg_Science = mean(Science_Score)
  )
print(gender_summary)

# VISUALISATION --------------------------------------------------------------------------------------
# Bar chart of average scores by gender
ggplot(gender_summary, aes(x = Gender, y = Avg_Math, fill = Gender)) +  
  geom_bar(stat = "identity", position = "dodge") +  
  labs(title = "Average Math Scores by Gender", x = "Gender", y = "Average Score") +  
  theme_minimal()

# Scatter plot of study hours vs maths score
ggplot(data, aes(x = Study_Hours, y = Math_Score, colour = Gender)) +  
  geom_point() +  
  labs(title = "Study Hours vs Math Score", x = "Study Hours", y = "Math Score") +  
  theme_bw()

# Histogram of Maths Score Distribution
ggplot(data, aes(x = Math_Score)) +  
  geom_histogram(binwidth = 3, fill = "blue", color = "black") +  
  labs(title = "Distribution of Math Scores", x = "Math Score", y = "Frequency") +  
  theme_classic()

