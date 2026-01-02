# Predictive Modeling of CO₂ Emissions Using Deforestation Data

## Overview

This project uses machine learning techniques to analyze and predict carbon dioxide (CO₂) emissions based on deforestation data and related variables. The goal is to model how factors such as forest loss and per capita emissions impact total CO₂ emissions, providing actionable insights for environmental decision-making.

## Dataset

- **Source:** Merged dataset containing country-level data for:
  - Country
  - Year
  - Emissions
  - Population
  - PerCapitaEmissions
  - forest_loss_ha
  - (and other possible features)
- **File Example:** `df_merged_clean.csv`

## Project Workflow

1. **Data Loading & Cleaning**
    - Import dataset
    - Remove missing values in key columns
    - Select relevant features

2. **Exploratory Data Analysis (EDA)**
    - Trends of emissions and forest loss over time
    - Correlation analysis
    - Scatterplots and summary statistics

3. **Machine Learning Modeling**
    - Split data into training and test sets
    - Build and compare the following models:
        - Linear Regression
        - Random Forest
        - Support Vector Machine (SVM)
    - Hyperparameter tuning and cross-validation (for Random Forest)

4. **Model Evaluation**
    - Predict emissions on test data
    - Compute and compare RMSE and R-squared for each model
    - Visualize model predictions and residuals

5. **Feature Importance & Insights**
    - Identify and visualize most important variables (Random Forest)
    - Analyze model fit and recommend future work

6. **Visualization & Reporting**
    - Save all plots as PNG images
    - Document workflow and results for clear communication

## Dependencies

- R version ≥ 4.5.1
- Libraries:
    - tidyverse
    - caret
    - randomForest
    - e1071
    - corrplot
    - ggplot2
    - pdp (optional, for advanced plots)

## Usage

1. Clone/download the repository and place the data file (`df_merged_clean.csv`) in the project directory.
2. Open the R scripts/notebook.
3. Ensure required libraries are installed.  
   ```r
   install.packages(c("tidyverse", "caret", "randomForest", "e1071", "corrplot", "ggplot2"))
   ```
4. Run the scripts in order (see script comments for sectioning).
5. Review the generated plots in the `/plots` folder and the output in your R session.

## Main Results

- Multiple models built; Random Forest typically shows the lowest RMSE.
- Both forest loss and per capita emissions are found to be strong predictors of total CO₂ emissions.
- Analysis demonstrates the usefulness of machine learning for environmental policy and forecasting.

## Directory Structure

```
.
├── data/                        # Data files (input)
│   └── df_merged_clean.csv
├── scripts/                     # R scripts for each project phase
│   └── phase3_modeling.R
├── plots/                       # Saved plots/images
│   ├── plot1.png
│   ├── plot2.png
│   └── ...
├── README.md
```
