# Deforestation & CO₂ Emissions Analysis

## 📄 Project Overview
This project focuses on analyzing global deforestation and CO₂ emissions data to understand environmental trends, loss of forest cover, and the impact on carbon emissions. The datasets used provide country-wise annual statistics for forest area, forest loss, and CO₂ emissions.  

The analysis includes:  
- Data cleaning and transformation  
- Handling duplicates and missing values  
- Preparing the data for visualization and further analysis  

---

## 🗂️ Datasets

### 1. Deforestation Dataset
- **Columns include**: `Country`, `Year`, `Forest Area (ha)`, `Forest Loss (ha)`, `Forest Gain (ha)`  
- **Source**: Global Forest Watch  
- **Purpose**: To track forest cover changes over the years  

### 2. CO₂ Emissions Dataset
- **Columns include**: `Country`, `Year`, `CO2 Emissions (metric tons)`  
- **Source**: Global Carbon Project  
- **Purpose**: To track annual CO₂ emissions by country  

---

## 🧹 Data Cleaning & Transformation

The following steps were applied to ensure high-quality data:

1. **Remove duplicate records**  
   - Ensured that each `Country-Year` pair is unique  

2. **Handle missing or small country data**  
   - Imputed missing values where necessary or removed insignificant rows to avoid analysis bias  

3. **Standardize column names**  
   - Ensured consistent naming for easier data manipulation  

4. **Type conversion**  
   - Converted numeric fields from text to numeric type for calculations  

5. **Output cleaned datasets**  
   - Saved as CSV for reproducibility  

**Libraries used**: `dplyr`, `tidyr`, `readxl` (R)  

---

## 🔍 Example Code Snippet (R)
```r
library(dplyr)
library(tidyr)
library(readxl)

# Load dataset
deforestation <- read_excel(file.choose())
co2 <- read_excel(file.choose())

# Remove duplicate country-year records
deforestation_clean <- deforestation %>%
    distinct(Country, Year, .keep_all = TRUE)

co2_clean <- co2 %>%
    distinct(Country, Year, .keep_all = TRUE)

# Handle missing values
deforestation_clean <- deforestation_clean %>%
    drop_na()

co2_clean <- co2_clean %>%
    drop_na()

# Save cleaned data
write.csv(deforestation_clean, "deforestation_clean.csv", row.names = FALSE)
write.csv(co2_clean, "co2_clean.csv", row.names = FALSE)
