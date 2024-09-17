library(dplyr)
library(tidyr)
library(ggplot2)
library(car)

# Load data
predictors <- read.csv(file="STA302/stats.csv", header=T)
salaries <- read.csv(file="STA302/salaries.csv", header=T)

# Clean Salary column
salaries$Salary <- as.numeric(gsub("[\\$,]","",salaries$Salary))

# Merge datasets
data <- merge(predictors, salaries, by = "Player")

# Split the dataset
n <- nrow(data)
set.seed(123)
train_indices <- sample(seq_len(n), size = floor(0.75 * n))
train_data <- data[train_indices, ]
valid_data <- data[-train_indices, ]

# Select numeric columns
numeric_predictors <- train_data %>% select(Player, Salary, where(is.numeric))

# Summary of numeric predictors
summary(numeric_predictors)

# Calculate correlation matrix, handling NA values
cor_matrix <- cor(numeric_predictors %>% select(-Player), use = "pairwise.complete.obs")
#print(cor_matrix)

# Select predictors that have a correlation with Salary above a threshold (e.g., 0.5 or -0.5)
threshold <- 0.5
cor_with_salary <- cor_matrix["Salary", ]
significant_predictors <- names(cor_with_salary[abs(cor_with_salary) > threshold])
significant_predictors <- significant_predictors[significant_predictors != "Salary"]

# Create formula for the linear model
formula <- as.formula(paste("Salary ~", paste(significant_predictors, collapse = " + ")))

# function to print statistics
display_model <- function(model){
  print(summary(model))
  cat("AIC:", AIC(model))
  plot(model)
}

# Linear regression model using significant predictors
model <- lm(formula, data = numeric_predictors)
#display_model(model)
#print(vif(model))

# Model selection using stepwise
model_step <- step(model, direction = "both", trace = FALSE)
#display_model(model_step)
#print(vif(model_step))


# Finding the largest 4 correlation
best4_indices <- order(cor_with_salary, decreasing = TRUE)[2:5]
best4_predictors <- names(cor_with_salary[best4_indices])

# Create formula for the linear model
formula <- as.formula(paste("Salary ~", paste(best4_predictors, collapse = " + ")))

# Linear regression using the 4 best predictors
model4 <- lm(formula, data = numeric_predictors)
#display_model(model4)
print(vif(model4))

# Model selection using stepwise
model4_step <- step(model4, direction = "both", trace = FALSE)
#display_model(model4_step)
#print(vif(model4_step))


#Testing 
# Linear regression model using significant predictors
model <- lm(Salary ~ GS + X3P + X2P + FT + AST, data = numeric_predictors)
#display_model(model)

# Model selection using stepwise
model_step <- step(model, direction = "both", trace = FALSE)
#display_model(model_step)
#print(vif(model_step))

predicted <- predict(model_step, newdata = valid_data)

actual <- valid_data$Salary

# Calculate residuals
residuals <- actual - predicted

# Calculate total sum of squares
sst <- sum((actual - mean(actual))^2)

# Calculate residual sum of squares
ssr <- sum(residuals^2)

# Calculate R-squared
rsquared <- 1 - (ssr / sst)
#print(paste("R-squared:", rsquared))