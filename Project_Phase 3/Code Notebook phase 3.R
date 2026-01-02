library(readr)
> df_merged_clean <- read_csv("C:/Users/Sheheryar Malik/OneDrive/Desktop/Project_Phase_2/Merged_dataset/df_merged_clean.csv")
Rows: 12014 Columns: 12                                                                        
── Column specification ───────────────────────────────────────────────────────────────────────
Delimiter: ","
chr  (1): Country
dbl (11): Year, Emissions, Population, PerCapitaEmissions, forest_loss_ha, threshold, area_...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(df_merged_clean)

> # Load the libraries
  > library(tidyverse)
> 
  > # Data Clean/Select
  > df <- df_merged_clean %>%
  +     filter(!is.na(Emissions), !is.na(forest_loss_ha), !is.na(PerCapitaEmissions)) %>%
  +     select(Country, Year, Emissions, forest_loss_ha, Population, PerCapitaEmissions)
> library(ggplot2)
> 
  > # Top 5 most frequent countries
  > top_countries <- df %>% count(Country, sort=TRUE) %>% head(5) %>% pull(Country)
> 
  > ggplot(df %>% filter(Country %in% top_countries), 
           +        aes(x=Year, y=Emissions, color=Country)) +
  +     geom_line() +
  +     labs(title="CO₂ Emissions Over Time: Top 5 Countries")
> ggplot(df %>% filter(Country %in% top_countries), 
         +        aes(x=Year, y=forest_loss_ha, color=Country)) +
  +     geom_line() +
  +     labs(title="Forest Loss ha Over Time: Top 5 Countries")
> ggplot(df, aes(x=forest_loss_ha, y=Emissions)) +
  +     geom_point(alpha=0.4) +
  +     geom_smooth(method="lm", color="blue") +
  +     labs(title="Emissions vs Forest Loss", x="Forest Loss (ha)", y="Emissions")
`geom_smooth()` using formula = 'y ~ x'
> library(corrplot)
> num_df <- df %>% select(Emissions, forest_loss_ha, Population, PerCapitaEmissions)
> corrplot(cor(num_df, use="complete.obs"), method="number")
Warning message:
  In cor(num_df, use = "complete.obs") : the standard deviation is zero

> library(caret)
> 
  > set.seed(42)
> idx <- createDataPartition(df$Emissions, p=0.8, list=FALSE)
> train <- df[idx, ]
> test <- df[-idx, ]
> lm_model <- lm(Emissions ~ forest_loss_ha + Population + PerCapitaEmissions, data=train)
> summary(lm_model)

Call:
  lm(formula = Emissions ~ forest_loss_ha + Population + PerCapitaEmissions, 
     data = train)

Residuals:
  Min         1Q     Median         3Q        Max 
-3.612e-12 -6.100e-14 -5.200e-14 -4.000e-14  7.700e-11 

Coefficients: (1 not defined because of singularities)
Estimate Std. Error   t value Pr(>|t|)    
(Intercept)        4.036e-13  5.188e-14 7.780e+00 1.32e-14 ***
  forest_loss_ha     3.709e-19  2.145e-19 1.729e+00    0.084 .  
Population                NA         NA        NA       NA    
PerCapitaEmissions 1.000e+06  7.829e-11 1.277e+16  < 2e-16 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.969e-12 on 1537 degrees of freedom
Multiple R-squared:      1,	Adjusted R-squared:      1 
F-statistic: 8.189e+31 on 2 and 1537 DF,  p-value: < 2.2e-16

> library(randomForest)
> rf_model <- randomForest(Emissions ~ forest_loss_ha + Population + PerCapitaEmissions, data=train, importance=TRUE)
> varImpPlot(rf_model)
> library(e1071)
> svm_model <- svm(Emissions ~ forest_loss_ha + Population + PerCapitaEmissions, data=train)
Warning message:
  In svm.default(x, y, scale = scale, ..., na.action = na.action) :
  Variable(s) ‘Population’ constant. Cannot scale data.

> # Check for constant columns:
  > sapply(train, function(x) length(unique(x)))
Country               Year          Emissions     forest_loss_ha         Population 
148                 23               1509               1280                  1 
PerCapitaEmissions 
1509 
> 
  > # If Population is constant, exclude it:
  > train2 <- train %>% select(-Population)
> test2  <- test  %>% select(-Population)
> 
  > # Now rebuild models
  > svm_model2 <- svm(Emissions ~ forest_loss_ha + PerCapitaEmissions, data = train2)
> # Remove Population if constant
  > df_nopop <- df %>% select(-Population)
> 
  > # Resplit (recommended after change)
  > set.seed(42)
> idx <- createDataPartition(df_nopop$Emissions, p=0.8, list=FALSE)
> train <- df_nopop[idx, ]
> test  <- df_nopop[-idx, ]
> # Linear Regression
  > lm_model <- lm(Emissions ~ forest_loss_ha + PerCapitaEmissions, data=train)
> # Random Forest
  > rf_model <- randomForest(Emissions ~ forest_loss_ha + PerCapitaEmissions, data=train, importance=TRUE)
> # SVM
  > svm_model <- svm(Emissions ~ forest_loss_ha + PerCapitaEmissions, data=train)
> pred_lm <- predict(lm_model, test)
> pred_rf <- predict(rf_model, test)
> pred_svm <- predict(svm_model, test)
> lm_rmse <- sqrt(mean((pred_lm - test$Emissions)^2))
> rf_rmse <- sqrt(mean((pred_rf - test$Emissions)^2))
> svm_rmse <- sqrt(mean((pred_svm - test$Emissions)^2))
> print(c(Linear=lm_rmse, RandomForest=rf_rmse, SVM=svm_rmse))
Linear RandomForest          SVM 
3.263029e-12 2.058817e+02 8.065930e+02 
> results <- data.frame(
  +     Actual = test$Emissions,
  +     Linear = pred_lm,
  +     RandomForest = pred_rf,
  +     SVM = pred_svm
  + )
> results_long <- pivot_longer(results, -Actual, names_to = "Model", values_to = "Predicted")
> ggplot(results_long, aes(x=Actual, y=Predicted, color=Model)) +
  +     geom_point(alpha=0.6) +
  +     geom_abline(slope=1, intercept=0, linetype="dashed") +
  +     labs(title="Actual vs Predicted Emissions (All Models)")
> varImpPlot(rf_model)
> ggplot(data.frame(res=fitted(lm_model), resid=resid(lm_model)), aes(x=res, y=resid)) +
  +     geom_point(alpha=0.6) + 
  +     geom_hline(yintercept=0, color='red', lty=2) +
  +     labs(title="Linear Model Residuals", x="Fitted", y="Residual")
> library(caret)
> ctrl <- trainControl(method = "cv", number = 5)
> rf_cv <- train(
  +     Emissions ~ forest_loss_ha + PerCapitaEmissions,
  +     data = df,
  +     method = "rf",
  +     trControl = ctrl
  + )
note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .

> print(rf_cv)
Random Forest 

1924 samples
2 predictor

No pre-processing
Resampling: Cross-Validated (5 fold) 
Summary of sample sizes: 1538, 1540, 1540, 1540, 1538 
Resampling results:
  
  RMSE      Rsquared   MAE     
61.60353  0.9958928  6.785787

Tuning parameter 'mtry' was held constant at a value of 2
> tuneGrid <- expand.grid(mtry = c(1, 2))
> rf_tuned <- train(
  +     Emissions ~ forest_loss_ha + PerCapitaEmissions,
  +     data = train,
  +     method = "rf",
  +     trControl = ctrl,
  +     tuneGrid = tuneGrid
  + )
> print(rf_tuned$bestTune)
mtry
2    2
> df <- df %>%
  +     mutate(Emissions_per_loss = Emissions / (forest_loss_ha + 1))
> res <- resid(lm_model)
> outliers <- which(abs(res) > 2*sd(res))
> df_outlier <- test[outliers, ]
> imp <- importance(rf_model)
> imp_df <- data.frame(Variable=rownames(imp), Importance=imp[,1])
> ggplot(imp_df, aes(x=reorder(Variable, Importance), y=Importance)) +
  +     geom_col(fill="steelblue") +
  +     coord_flip() +
  +     labs(title="Random Forest Feature Importance")
> test$Pred_RF <- pred_rf
> test$Error_RF <- test$Emissions - test$Pred_RF
> ggplot(test, aes(x=Country, y=Error_RF)) + 
  +     geom_boxplot() +
  +     labs(title="Random Forest Prediction Error by Country")
> ggplot(test, aes(x=Year, y=Emissions, color="Actual")) +
  +     geom_line() +
  +     geom_line(aes(y=pred_rf, color="Predicted")) +
  +     labs(title="Actual vs Predicted Emissions by Year (Random Forest)")
library(pdp)
> pdp1 <- partial(rf_model, pred.var = "forest_loss_ha", plot = TRUE)
> library(ggplot2)
results <- data.frame(Actual=test$Emissions, Predicted=pred_lm)
> ggplot(results, aes(x=Actual, y=Predicted)) +
  +     geom_point(color="blue", alpha=0.6) +
  +     geom_abline(slope=1, intercept=0, linetype="dashed", color="black") +
  +     labs(title="Actual vs Predicted CO₂ Emissions (Linear Regression)", 
             +          x="Actual", y="Predicted")
> ggsave("plots/plot1.png", plot=p1, width=7, height=5, dpi=300)