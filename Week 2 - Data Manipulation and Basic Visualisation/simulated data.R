set.seed(123) # For reproducibility

# Number of students
n <- 150

# Generate data
StudentID <- 1:n
Age <- sample(15:19, n, replace = TRUE)
Gender <- sample(c("Male", "Female"), n, replace = TRUE, prob = c(0.4, 0.6))
Math_Score <- sample(30:100, n, replace = TRUE)
English_Score <- sample(55:100, n, replace = TRUE)
Science_Score <- sample(40:100, n, replace = TRUE)
Study_Hours <- round(runif(n, min = 1, max = 15), 1)
Parental_Education <- sample(c("High School", "Bachelor's", "Master's", "PhD"), n, replace = TRUE)
Lunch <- sample(c("Standard", "Free/Reduced"), n, replace = TRUE, prob = c(0.7, 0.3))

# Introduce some issues
Math_Score[sample(1:n, 5)] <- NA  # Missing values
Science_Score[sample(1:n, 4)] <- NA  # Missing values
Gender[sample(1:n, 5)] <- tolower(Gender[sample(1:n, 5)])  # Inconsistent capitalization
Math_Score[sample(1:n, 3)] <- Math_Score[sample(1:n, 3)] + 30  # Outliers

# Create dataframe
student_performance <- data.frame(
  StudentID,
  Age,
  Gender,
  Math_Score,
  English_Score,
  Science_Score,
  Study_Hours,
  Parental_Education,
  Lunch
)

# Write to CSV
write.csv(student_performance, "student_performance.csv", row.names = FALSE)
