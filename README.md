# price-elasticity-analysis
Multivariate regression analysis to estimate price elasticity using supermarket sales data in R.
# Multivariate Regression Analysis for Price Elasticity

## 📌 Project Overview
This project estimates **price elasticity of demand** using a multivariate log-log regression model on supermarket sales data. The analysis controls for customer behavior, product categories, and store-level factors.

## 🛠 Tools & Technologies
- R
- tidyverse
- ggplot2
- broom
- car

## 📂 Project Structure
Price_Elasticity_Analysis/
├── data/        # Dataset (pricing_data.csv)
├── scripts/     # R analysis script
├── outputs/     # Regression tables & plots
├── report/      # Interpretation report


## 📊 Methodology
- Data cleaning and feature engineering
- Log-log multivariate regression modeling
- Price elasticity estimation
- Model validation (VIF, residual diagnostics)
- Coefficient visualization with confidence intervals

## 📈 Key Result
- Estimated price elasticity: **-0.31**
- Indicates **price-inelastic demand**

## 📁 Deliverables
- R script for analysis
- Regression summary table (CSV)
- Coefficient plot (PNG)
- Interpretation report (DOC/PDF)

## 🚀 How to Run
1. Open RStudio
2. Set working directory to project root
3. Run `scripts/price_elasticity_analysis.R`

## 👤 Author
Adarsh Tiwari
