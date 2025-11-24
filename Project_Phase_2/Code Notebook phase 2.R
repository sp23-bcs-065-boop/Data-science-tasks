merged_dataset <- read.csv("C:/Users/Sheheryar Malik/Desktop/df_merged.csv")
> 
  > str(merged_dataset)
'data.frame':	14851 obs. of  12 variables:
  $ Country                  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
$ Year                     : int  1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 ...
$ Emissions                : num  0.414 0.491 0.689 0.707 0.839 ...
$ Population               : int  1000000 1000000 1000000 1000000 1000000 1000000 1000000 1000000 1000000 1000000 ...
$ PerCapitaEmissions       : num  4.14e-07 4.91e-07 6.89e-07 7.07e-07 8.39e-07 ...
$ forest_loss_ha           : int  NA NA NA NA NA NA NA NA NA NA ...
$ threshold                : int  NA NA NA NA NA NA NA NA NA NA ...
$ area_ha                  : int  NA NA NA NA NA NA NA NA NA NA ...
$ extent_2000_ha           : int  NA NA NA NA NA NA NA NA NA NA ...
$ extent_2010_ha           : int  NA NA NA NA NA NA NA NA NA NA ...
$ gain_2000.2012_ha        : int  NA NA NA NA NA NA NA NA NA NA ...
$ forest_loss_cumulative_ha: int  NA NA NA NA NA NA NA NA NA NA ...
> 
  > head(merged_dataset)
Country Year Emissions Population PerCapitaEmissions forest_loss_ha threshold area_ha
1 Afghanistan 1960   0.41388    1000000         4.1388e-07             NA        NA      NA
2 Afghanistan 1961   0.49080    1000000         4.9080e-07             NA        NA      NA
3 Afghanistan 1962   0.68859    1000000         6.8859e-07             NA        NA      NA
4 Afghanistan 1963   0.70674    1000000         7.0674e-07             NA        NA      NA
5 Afghanistan 1964   0.83855    1000000         8.3855e-07             NA        NA      NA
6 Afghanistan 1965   1.00690    1000000         1.0069e-06             NA        NA      NA
extent_2000_ha extent_2010_ha gain_2000.2012_ha forest_loss_cumulative_ha
1             NA             NA                NA                        NA
2             NA             NA                NA                        NA
3             NA             NA                NA                        NA
4             NA             NA                NA                        NA
5             NA             NA                NA                        NA
6             NA             NA                NA                        NA
> 
  > summary(merged_dataset)
Country               Year        Emissions           Population    PerCapitaEmissions
Length:14851       Min.   :1960   Min.   :    0.000   Min.   :1e+06   Min.   :0.00000   
Class :character   1st Qu.:1976   1st Qu.:    0.613   1st Qu.:1e+06   1st Qu.:0.00000   
Mode  :character   Median :1993   Median :    5.706   Median :1e+06   Median :0.00001   
Mean   :1992   Mean   :  111.780   Mean   :1e+06   Mean   :0.00011   
3rd Qu.:2009   3rd Qu.:   43.279   3rd Qu.:1e+06   3rd Qu.:0.00004   
Max.   :2024   Max.   :11902.503   Max.   :1e+06   Max.   :0.01190   
NA's   :639    NA's   :1702        NA's   :580     NA's   :1702      
forest_loss_ha       threshold        area_ha          extent_2000_ha     
Min.   :-4194004   Min.   :0       Min.   :2.094e+03   Min.   :2.094e+03  
1st Qu.:   -1909   1st Qu.:0       1st Qu.:5.118e+06   1st Qu.:5.118e+06  
Median :       2   Median :0       Median :2.023e+07   Median :2.023e+07  
Mean   :    9618   Mean   :0       Mean   :7.815e+07   Mean   :7.815e+07  
3rd Qu.:    4593   3rd Qu.:0       3rd Qu.:6.202e+07   3rd Qu.:6.202e+07  
Max.   : 7672250   Max.   :0       Max.   :1.689e+09   Max.   :1.689e+09  
NA's   :10867      NA's   :10867   NA's   :10867       NA's   :10867      
extent_2010_ha      gain_2000.2012_ha  forest_loss_cumulative_ha
Min.   :2.094e+03   Min.   :       0   Min.   :       0         
1st Qu.:5.118e+06   1st Qu.:   13832   1st Qu.:     978         
Median :2.023e+07   Median :   94359   Median :   12658         
Mean   :7.815e+07   Mean   :  786731   Mean   :  153953         
3rd Qu.:6.202e+07   3rd Qu.:  388240   3rd Qu.:   70922         
Max.   :1.689e+09   Max.   :37220538   Max.   :10176019         
NA's   :10867       NA's   :10867      NA's   :10867            
> 
> colSums(is.na(merged_dataset))
                  Country                      Year                 Emissions 
                        0                       639                      1702 
               Population        PerCapitaEmissions            forest_loss_ha 
                      580                      1702                     10867 
                threshold                   area_ha            extent_2000_ha 
                    10867                     10867                     10867 
           extent_2010_ha         gain_2000.2012_ha forest_loss_cumulative_ha 
                    10867                     10867                     10867 
> 
> length(unique(merged_dataset$Country))
[1] 231
> 
> range(merged_dataset$Year, na.rm = TRUE)
[1] 1960 2024
> 
> emissions_ts <- merged_dataset %>%
+     group_by(Year) %>%
+     summarise(mean_emissions = mean(Emissions, na.rm = TRUE))
> 
> ggplot(emissions_ts, aes(x = Year, y = mean_emissions)) +
+     geom_line(color = "steelblue", linewidth = 1) +
+     labs(title = "Average CO₂ Emissions Over Time",
+          x = "Year", y = "CO₂ Emissions (Mt)") +
+     theme_minimal()
forest_ts <- merged_dataset %>%
+     group_by(Year) %>%
+     summarise(mean_forest_loss = mean(forest_loss_ha, na.rm = TRUE))
> 
> ggplot(forest_ts, aes(x = Year, y = mean_forest_loss)) +
+     geom_line(color = "darkgreen", linewidth = 1) +
+     labs(title = "Average Forest Loss Over Time",
+          x = "Year", y = "Forest Loss (ha)") +
+     theme_minimal()
 
> scatter_data <- merged_dataset %>%
+     filter(!is.na(Emissions), !is.na(forest_loss_ha))
> 
> ggplot(scatter_data, aes(x = Emissions, y = forest_loss_ha)) +
+     geom_point(color = "purple", alpha = 0.6) +
+     labs(title = "CO₂ Emissions vs Forest Loss",
+          x = "CO₂ Emissions (Mt)",
+          y = "Forest Loss (ha)") +
+     theme_minimal()
> 
> top_emitters <- merged_dataset %>%
+     group_by(Country) %>%
+     summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
+     arrange(desc(total_emissions)) %>%
+     slice(1:10)
> 
> ggplot(top_emitters, aes(x = reorder(Country, total_emissions), y = total_emissions)) +
+     geom_col(fill = "tomato") +
+     coord_flip() +
+     labs(title = "Top 10 CO₂ Emitting Countries",
+          x = "Country",
+          y = "Total Emissions (Mt)") +
+     theme_minimal()
> 
> top_forest_loss <- merged_dataset %>%
+     group_by(Country) %>%
+     summarise(total_forest_loss = sum(forest_loss_ha, na.rm = TRUE)) %>%
+     arrange(desc(total_forest_loss)) %>%
+     slice(1:10)
> 
> ggplot(top_forest_loss, aes(x = reorder(Country, total_forest_loss), y = total_forest_loss)) +
+     geom_col(fill = "seagreen") +
+     coord_flip() +
+     labs(title = "Top 10 Countries by Forest Loss",
+          x = "Country",
+          y = "Forest Loss (ha)") +
+     theme_minimal()
> 
> correlation_data <- merged_dataset %>%
+     select(Emissions, forest_loss_ha) %>%
+     na.omit()
> 
> cor(correlation_data)
                Emissions forest_loss_ha
Emissions      1.00000000     0.02654566
forest_loss_ha 0.02654566     1.00000000
> 
> install.packages("forecast")
 library(forecast)
 
> install.packages("lubridate")
library(lubridate)
> emissions_ts <- merged_dataset %>%
+     group_by(Year) %>%
+     summarise(mean_emissions = mean(Emissions, na.rm = TRUE))
> 
> ggplot(emissions_ts, aes(x = Year, y = mean_emissions)) +
+     geom_line(color = "blue", linewidth = 1.2) +
+     labs(title = "Average CO₂ Emissions Over Time",
+          x = "Year", y = "Mean Emissions (Mt)") +
+     theme_minimal()
reg_model <- lm(forest_loss_ha ~ Emissions, data = merged_dataset)
> summary(reg_model)

Call:
lm(formula = forest_loss_ha ~ Emissions, data = merged_dataset)

Residuals:
     Min       1Q   Median       3Q      Max 
-2946329   -11174    -7810    -3040  7660706 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)  
(Intercept) 7774.832   3436.445   2.262   0.0237 *
Emissions      6.861      4.432   1.548   0.1217  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 196100 on 3399 degrees of freedom
  (11450 observations deleted due to missingness)
Multiple R-squared:  0.0007047,	Adjusted R-squared:  0.0004107 
F-statistic: 2.397 on 1 and 3399 DF,  p-value: 0.1217

> 
> ggplot(scatter_data, aes(x = Emissions, y = forest_loss_ha)) +
+     geom_point(alpha = 0.5) +
+     geom_smooth(method = "lm", color = "red") +
+     labs(title = "Regression: CO₂ Emissions → Forest Loss",
+          x = "CO₂ Emissions", y = "Forest Loss") +
+     theme_minimal()
`geom_smooth()` using formula = 'y ~ x'
> 
> ts_data <- ts(emissions_ts$mean_emissions, start = min(merged_dataset$Year), frequency = 1)