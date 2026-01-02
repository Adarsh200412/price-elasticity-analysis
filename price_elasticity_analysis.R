# -------------------------------------------------
# Project: Multivariate Regression Analysis
# Topic: Price Elasticity Estimation
# Author: Adarsh Tiwari
# Date: 2nd January 2026
# -------------------------------------------------

# -------------------------------
# 1. Load Required Libraries
# -------------------------------
# tidyverse  : data manipulation
# ggplot2   : visualization
# broom     : tidy regression outputs
# car       : model diagnostics (VIF)


library(tidyverse)
library(ggplot2)
library(broom)
library(car)

# -------------------------------
# 2. Import Dataset
# -------------------------------
# The dataset contains transaction-level supermarket sales data
# including price, quantity sold, product categories, and customer attributes.


data <- read.csv("data/pricing_data.csv")

# Quick data inspection
head(data)
str(data)

# -------------------------------
# 3. Data Preparation & Feature Engineering
# -------------------------------
# - Convert categorical variables to factors
# - Create log-transformed variables for elasticity estimation
#   (log-log model allows direct elasticity interpretation)


data_clean <- data %>%
  mutate(
    product_category = as.factor(product_category),
    branch = as.factor(branch),
    customer_type = as.factor(customer_type),
    gender = as.factor(gender),
    
    log_quantity = log(quantity),
    log_unit_price = log(unit_price)
  )

# Verify transformed dataset structure
str(data_clean)

# -------------------------------
# 4. Multivariate Regression Model
# -------------------------------
# Log-log regression model where:
# - Dependent variable: log(quantity)
# - Key independent variable: log(unit_price)
# - Control variables: reward points, customer type, branch, product category

elasticity_model <- lm(
  log_quantity ~ log_unit_price + reward_points + customer_type + branch + product_category,
  data = data_clean
)

# View regression summary
summary(elasticity_model)


# -------------------------------
# 5. Model Validation
# -------------------------------

# 5.1 Multicollinearity Check using VIF
# VIF values close to 1 indicate no multicollinearity issues
vif(elasticity_model)


# 5.2 Residual Diagnostics
# Residuals vs Fitted plot to check heteroscedasticity

plot(
  elasticity_model$fitted.values,
  resid(elasticity_model),
  xlab = "Fitted Values",
  ylab = "Residuals"
)
abline(h = 0, col = "red")

# -------------------------------
# 6. Coefficient Visualization
# -------------------------------
# Visualize regression coefficients with 95% confidence intervals

coef_df <- broom::tidy(elasticity_model, conf.int = TRUE)
ggplot(coef_df, aes(x = reorder(term, estimate), y = estimate)) +
  geom_point() +
  geom_errorbar(
    aes(ymin = conf.low, ymax = conf.high),
    width = 0.2
  ) +
  coord_flip() +
  theme_minimal() +
  labs(
    title = "Regression Coefficients with 95% Confidence Intervals",
    x = "Model Terms",
    y = "Coefficient Estimate"
  )

# Save coefficient plot

ggsave(
  "outputs/elasticity_coefficients_plot.png",
  width = 8,
  height = 6
)

# -------------------------------
# 7. Export Regression Summary Table
# -------------------------------
# Export regression results as a CSV file for reproducibility and submission

model_summary <- broom::tidy(elasticity_model, conf.int = TRUE)

write.csv(
  model_summary,
  "outputs/elasticity_regression_summary.csv",
  row.names = FALSE
)

# -------------------------------
# End of Script
# -------------------------------

