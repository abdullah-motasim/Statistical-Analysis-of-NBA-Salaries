# Statistical-Analysis-of-NBA-Salaries

# Overview
This project investigates the factors that influence NBA player salaries using game statistics from the 2023-2024 NBA season. By applying Multiple Linear Regression (MLR), we predict player salaries based on various performance metrics.

# Dataset
The dataset used for this project was sourced from Basketball Reference and includes player statistics for the 2023-2024 NBA season. The variables analyzed include:


- Games Started (GS)
- Minutes Played (MP)
- Field Goals (FG)
- 3-Point Shots Made (X3P)
- Assists (AST)
- Turnovers (TOV)
- Points Scored (PTS)

# Methodology
1. Data Collection: NBA player statistics were gathered from the 2023-2024 season.
Exploratory Data Analysis: Correlation matrices and scatter plots were used to identify relationships between variables.

2. Model Building: Multiple Linear Regression was used with:
Stepwise selection techniques (forward and backward selection) based on the Akaike Information Criterion (AIC).

4. Model Validation: The dataset was split into training (75%) and testing (25%) subsets to evaluate model performance.

# Results
- Final model predictors: Games Started (GS), 3-Point Shots Made (X3P), Free Throws (FT), Assists (AST), and 2-Point Shots Made (X2P).
- Achieved an R-squared value of 0.5628, indicating that about 56% of the salary variation can be explained by the selected variables.

# Files
NBA_Salary_Prediction_MLR_Research.pdf: The full research paper detailing the methods, results, and discussions.
