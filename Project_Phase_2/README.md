1. Project Overview

This repository contains the Exploratory Data Analysis (EDA) for a merged dataset combining:

CO₂ emissions data (per country, per year)

Forest loss and tree cover data

The purpose of this EDA is to:

Understand dataset structure

Evaluate completeness and quality

Identify trends and outliers

Compare country-level behaviors

Analyze relationships between emissions and forest loss

Produce clear visualizations for reporting

 2. Dataset Description

The dataset used for EDA is:

df_merged.csv


It includes the following key variables:

Variable Name	Description
Country	Country name
Year	Year of observation
Emissions	CO₂ emissions (in Metric Tons)
Population	Population (assumed values)
PerCapitaEmissions	Emissions divided by population
forest_loss_ha	Forest loss in hectares
area_ha	Forested area in hectares
extent_2000_ha	Tree cover in year 2000
extent_2010_ha	Tree cover in year 2010
gain_2000.2012_ha	Tree cover gained between 2000–2012
forest_loss_cumulative_ha	Cumulative forest loss
3. Loading the Dataset
merged_dataset <- read.csv("C:/Users/Sheheryar Malik/Desktop/df_merged.csv")

 4. Initial Exploration
View structure:
str(merged_dataset)

Preview data:
head(merged_dataset)

Summary statistics:
summary(merged_dataset)

 5. Missing Value Analysis
colSums(is.na(merged_dataset))


This identifies incomplete variables and shapes cleaning decisions.

 6. Country & Year Overview
Number of unique countries:
length(unique(merged_dataset$Country))

Range of years:
range(merged_dataset$Year, na.rm = TRUE)

7. Time-Series Visualizations
7.1 Global CO₂ Emissions Over Time
emissions_ts <- merged_dataset %>%
  group_by(Year) %>%
  summarise(mean_emissions = mean(Emissions, na.rm = TRUE))

ggplot(emissions_ts, aes(Year, mean_emissions)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  labs(title = "Average CO₂ Emissions Over Time",
       x = "Year", y = "Mean CO₂ Emissions (Mt)") +
  theme_minimal()

7.2 Global Forest Loss Over Time
forest_ts <- merged_dataset %>%
  group_by(Year) %>%
  summarise(mean_forest_loss = mean(forest_loss_ha, na.rm = TRUE))

ggplot(forest_ts, aes(Year, mean_forest_loss)) +
  geom_line(color = "darkgreen", linewidth = 1.2) +
  labs(title = "Average Forest Loss Over Time",
       x = "Year", y = "Forest Loss (ha)") +
  theme_minimal()

8. Relationship Analysis
8.1 CO₂ Emissions vs Forest Loss Scatter Plot
scatter_data <- merged_dataset %>%
  filter(!is.na(Emissions), !is.na(forest_loss_ha))

ggplot(scatter_data, aes(Emissions, forest_loss_ha)) +
  geom_point(alpha = 0.5, color = "purple") +
  labs(title = "CO₂ Emissions vs Forest Loss",
       x = "CO₂ Emissions (Mt)", y = "Forest Loss (ha)") +
  theme_minimal()

 9. Country-Level Comparisons
9.1 Top 10 CO₂ Emitting Countries
top_emitters <- merged_dataset %>%
  group_by(Country) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  arrange(desc(total_emissions)) %>%
  slice(1:10)

ggplot(top_emitters, aes(reorder(Country, total_emissions), total_emissions)) +
  geom_col(fill = "tomato") +
  coord_flip() +
  labs(title = "Top 10 CO₂ Emitting Countries",
       x = "Country", y = "Total Emissions (Mt)") +
  theme_minimal()

9.2 Top 10 Countries by Forest Loss
top_forest_loss <- merged_dataset %>%
  group_by(Country) %>%
  summarise(total_loss = sum(forest_loss_ha, na.rm = TRUE)) %>%
  arrange(desc(total_loss)) %>%
  slice(1:10)

ggplot(top_forest_loss, aes(reorder(Country, total_loss), total_loss)) +
  geom_col(fill = "seagreen") +
  coord_flip() +
  labs(title = "Top 10 Countries by Forest Loss",
       x = "Country", y = "Forest Loss (ha)") +
  theme_minimal()

 10. Correlation Analysis
numeric_cols <- merged_dataset %>% select_if(is.numeric)
cor(numeric_cols, use = "complete.obs")


Observation:
Correlation between emissions and forest loss is weak, suggesting independent patterns.

 11. Saving EDA Plots

All plots can be saved using:

ggsave("plotname.png", width = 12, height = 8, dpi = 300)


Or using png() for multiple sequential plots.

12. Conclusions From EDA

CO₂ emissions show a long-term increasing trend globally

Forest loss is highly volatile and varies by region

No strong linear relationship between emissions and forest loss

A few countries dominate CO₂ emissions

Some countries dominate forest loss

Missing forest data appears for countries with minimal tree cover

Dataset is suitable for further modeling, forecasting, and regression

13. Requirements

Ensure you have the following R packages installed:

install.packages(c("dplyr", "ggplot2", "tidyr", "writexl", "corrplot"))