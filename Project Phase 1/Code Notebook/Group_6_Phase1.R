> library(readxl)
> library(dplyr)
> 
  > # 1️⃣ Set your file path
  > file_path <- "C:/Users/Sheheryar Malik/Desktop/dataset.xlsx"
  > 
    > # 2️⃣ Load the sheet but DON'T use skip — we'll detect header properly
    > raw_df <- read_excel(file_path, sheet = "Country tree cover loss", col_names = FALSE)
    New names:
      • `` -> `...1`
    • `` -> `...2`
    • `` -> `...3`
    • `` -> `...4`
    • `` -> `...5`
    • `` -> `...6`
    • `` -> `...7`
    • `` -> `...8`
    • `` -> `...9`
    • `` -> `...10`
    • `` -> `...11`
    • `` -> `...12`
    • `` -> `...13`
    • `` -> `...14`
    • `` -> `...15`
    • `` -> `...16`
    • `` -> `...17`
    • `` -> `...18`
    • `` -> `...19`
    • `` -> `...20`
    • `` -> `...21`
    • `` -> `...22`
    • `` -> `...23`
    • `` -> `...24`
    • `` -> `...25`
    • `` -> `...26`
    • `` -> `...27`
    • `` -> `...28`
    • `` -> `...29`
    • `` -> `...30`
    > 
      > # 3️⃣ Check the first few rows to see where the actual headers start
      > head(raw_df, 15)
    # A tibble: 15 × 30
    ...1     ...2  ...3  ...4  ...5  ...6  ...7  ...8  ...9  ...10 ...11 ...12 ...13 ...14 ...15
    <chr>    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
      1 country  thre… area… exte… exte… gain… tc_l… tc_l… tc_l… tc_l… tc_l… tc_l… tc_l… tc_l… tc_l…
    2 Afghani… 0     6438… 6438… 6438… 10738 103   214   267   226   268   172   274   123   92   
    3 Afghani… 10    6438… 4320… 1262… 10738 92    190   254   207   246   159   259   112   74   
    4 Afghani… 15    6438… 3026… 1068… 10738 91    186   248   205   241   156   255   110   72   
    5 Afghani… 20    6438… 2843… 1057… 10738 89    181   245   203   238   153   254   108   71   
    6 Afghani… 25    6438… 2548… 72384 10738 89    180   244   202   237   153   254   108   71   
    7 Afghani… 30    6438… 2057… 71786 10738 88    179   244   201   236   152   253   108   70   
    8 Afghani… 50    6438… 1484… 46235 10738 78    135   200   159   170   112   201   83    49   
    9 Afghani… 75    6438… 75480 18268 10738 46    61    96    61    64    43    83    28    21   
    10 Albania  0     2872… 2872… 2872… 16468 3907  940   675   3455  759   1033  5512  5803  1463 
    11 Albania  10    2872… 8386… 7125… 16468 3815  909   636   3327  717   987   5346  5607  1379 
    12 Albania  15    2872… 7766… 6531… 16468 3783  898   630   3299  712   982   5324  5577  1365 
    13 Albania  20    2872… 7528… 6416… 16468 3760  893   625   3272  706   977   5294  5541  1355 
    14 Albania  25    2872… 7064… 6209… 16468 3737  890   618   3245  697   966   5237  5489  1341 
    15 Albania  30    2872… 6484… 5888… 16468 3729  890   614   3235  694   962   5222  5470  1338 
    # ℹ 15 more variables: ...16 <chr>, ...17 <chr>, ...18 <chr>, ...19 <chr>, ...20 <chr>,
    #   ...21 <chr>, ...22 <chr>, ...23 <chr>, ...24 <chr>, ...25 <chr>, ...26 <chr>, ...27 <chr>,
    #   ...28 <chr>, ...29 <chr>, ...30 <chr>
    > 
      > # =============================
    > # 🌿 Country Tree Cover Loss Cleaning Script
      > # =============================
    > 
      > # 1️⃣ Load libraries
      > library(readxl)
    > library(dplyr)
    > 
      > # 2️⃣ Define file path (change only if file is moved)
      > file_path <- "C:/Users/Sheheryar Malik/Desktop/dataset.xlsx"
    > 
      > # 3️⃣ Check sheet names (optional)
      > excel_sheets(file_path)
    [1] "Read_Me"                       "Country tree cover loss"      
    [3] "Country primary loss"          "Country drivers"              
    [5] "Country carbon data"           "Subnational 1 tree cover loss"
    [7] "Subnational 1 primary loss"    "Subnational 1 drivers"        
    [9] "Subnational 1 carbon data"    
    > 
      > # 4️⃣ Import the correct sheet
      > #    You might need to adjust skip = 1, 2, or 3 depending on where headers start.
      > #    Try skip = 1 first — if column names look wrong, increase to skip = 2.
      > df <- read_excel(file_path, sheet = "Country tree cover loss", skip = 1, col_names = TRUE)
    New names:
      • `0` -> `0...2`
    • `64383655` -> `64383655...3`
    • `64383655` -> `64383655...4`
    • `64383655` -> `64383655...5`
    • `0` -> `0...21`
    • `0` -> `0...22`
    • `0` -> `0...23`
    > 
      > # 5️⃣ Check data structure
      > colnames(df)
    [1] "Afghanistan"  "0...2"        "64383655...3" "64383655...4" "64383655...5" "10738"       
    [7] "103"          "214"          "267"          "226"          "268"          "172"         
    [13] "274"          "123"          "92"           "109"          "134"          "60"          
    [19] "15"           "10"           "0...21"       "0...22"       "0...23"       "31"          
    [25] "25"           "46"           "47"           "16"           "133"          "223"         
    > head(df)
    # A tibble: 6 × 30
    Afghanistan `0...2` `64383655...3` `64383655...4` `64383655...5` `10738` `103` `214` `267`
    <chr>         <dbl>          <dbl>          <dbl>          <dbl>   <dbl> <dbl> <dbl> <dbl>
      1 Afghanistan      10       64383655         432070         126231   10738    92   190   254
    2 Afghanistan      15       64383655         302629         106852   10738    91   186   248
    3 Afghanistan      20       64383655         284330         105718   10738    89   181   245
    4 Afghanistan      25       64383655         254843          72384   10738    89   180   244
    5 Afghanistan      30       64383655         205771          71786   10738    88   179   244
    6 Afghanistan      50       64383655         148417          46235   10738    78   135   200
    # ℹ 21 more variables: `226` <dbl>, `268` <dbl>, `172` <dbl>, `274` <dbl>, `123` <dbl>,
    #   `92` <dbl>, `109` <dbl>, `134` <dbl>, `60` <dbl>, `15` <dbl>, `10` <dbl>, `0...21` <dbl>,
    #   `0...22` <dbl>, `0...23` <dbl>, `31` <dbl>, `25` <dbl>, `46` <dbl>, `47` <dbl>,
    #   `16` <dbl>, `133` <dbl>, `223` <dbl>
    > 
      > # 6️⃣ Clean Data
      > # Remove duplicates and handle missing values
      > df_clean <- df %>%
      +     # rename 'Country' column if it’s not exactly lowercase
      +     rename_with(~tolower(.x)) %>%
      +     distinct(country, .keep_all = TRUE) %>%   # Remove duplicate country records
      +     filter(!is.na(country) & country != "")   # Remove missing/blank countries
    Error in `distinct()`:
      ! Must use existing variables.
    ✖ `country` not found in `.data`.
    Run `rlang::last_trace()` to see where the error occurred.
    
    > df <- read_excel(file_path, sheet = "Country tree cover loss", skip = 0, col_names = TRUE)
    > 
      > colnames(df)
    [1] "country"           "threshold"         "area_ha"           "extent_2000_ha"   
    [5] "extent_2010_ha"    "gain_2000-2012_ha" "tc_loss_ha_2001"   "tc_loss_ha_2002"  
    [9] "tc_loss_ha_2003"   "tc_loss_ha_2004"   "tc_loss_ha_2005"   "tc_loss_ha_2006"  
    [13] "tc_loss_ha_2007"   "tc_loss_ha_2008"   "tc_loss_ha_2009"   "tc_loss_ha_2010"  
    [17] "tc_loss_ha_2011"   "tc_loss_ha_2012"   "tc_loss_ha_2013"   "tc_loss_ha_2014"  
    [21] "tc_loss_ha_2015"   "tc_loss_ha_2016"   "tc_loss_ha_2017"   "tc_loss_ha_2018"  
    [25] "tc_loss_ha_2019"   "tc_loss_ha_2020"   "tc_loss_ha_2021"   "tc_loss_ha_2022"  
    [29] "tc_loss_ha_2023"   "tc_loss_ha_2024"  
    > head(df)
    # A tibble: 6 × 30
    country   threshold area_ha extent_2000_ha extent_2010_ha `gain_2000-2012_ha` tc_loss_ha_2001
    <chr>         <dbl>   <dbl>          <dbl>          <dbl>               <dbl>           <dbl>
      1 Afghanis…         0  6.44e7       64383655       64383655               10738             103
    2 Afghanis…        10  6.44e7         432070         126231               10738              92
    3 Afghanis…        15  6.44e7         302629         106852               10738              91
    4 Afghanis…        20  6.44e7         284330         105718               10738              89
    5 Afghanis…        25  6.44e7         254843          72384               10738              89
    6 Afghanis…        30  6.44e7         205771          71786               10738              88
    # ℹ 23 more variables: tc_loss_ha_2002 <dbl>, tc_loss_ha_2003 <dbl>, tc_loss_ha_2004 <dbl>,
    #   tc_loss_ha_2005 <dbl>, tc_loss_ha_2006 <dbl>, tc_loss_ha_2007 <dbl>,
    #   tc_loss_ha_2008 <dbl>, tc_loss_ha_2009 <dbl>, tc_loss_ha_2010 <dbl>,
    #   tc_loss_ha_2011 <dbl>, tc_loss_ha_2012 <dbl>, tc_loss_ha_2013 <dbl>,
    #   tc_loss_ha_2014 <dbl>, tc_loss_ha_2015 <dbl>, tc_loss_ha_2016 <dbl>,
    #   tc_loss_ha_2017 <dbl>, tc_loss_ha_2018 <dbl>, tc_loss_ha_2019 <dbl>,
    #   tc_loss_ha_2020 <dbl>, tc_loss_ha_2021 <dbl>, tc_loss_ha_2022 <dbl>, …
    > 
      > # 🌿 Clean Country Tree Cover Loss Data
      > df_clean <- df %>%
      +     mutate(across(everything(), ~na_if(.x, ""))) %>%   # convert empty strings to NA
      +     filter(!is.na(country) & country != "") %>%        # remove missing country names
      +     distinct(country, threshold, .keep_all = TRUE) %>% # remove duplicates
      +     arrange(country, threshold)                        # sort neatly
    Error in `mutate()`:
      ℹ In argument: `across(everything(), ~na_if(.x, ""))`.
    Caused by error in `across()`:
      ! Can't compute column `threshold`.
Caused by error in `na_if()`:
! Can't convert `y` <character> to match type of `x` <double>.
    Run `rlang::last_trace()` to see where the error occurred.
    
    > # 🌿 Clean Country Tree Cover Loss Data (Safe Version)
      > df_clean <- df %>%
      +     mutate(across(where(is.character), ~na_if(.x, ""))) %>%  # only character columns
      +     filter(!is.na(country) & country != "") %>%              # remove missing country names
      +     distinct(country, threshold, .keep_all = TRUE) %>%      # remove duplicates
      +     arrange(country, threshold)                              # sort neatly
    > 
      > 
      > head(df_clean)
    # A tibble: 6 × 30
    country   threshold area_ha extent_2000_ha extent_2010_ha `gain_2000-2012_ha` tc_loss_ha_2001
    <chr>         <dbl>   <dbl>          <dbl>          <dbl>               <dbl>           <dbl>
      1 Afghanis…         0  6.44e7       64383655       64383655               10738             103
    2 Afghanis…        10  6.44e7         432070         126231               10738              92
    3 Afghanis…        15  6.44e7         302629         106852               10738              91
    4 Afghanis…        20  6.44e7         284330         105718               10738              89
    5 Afghanis…        25  6.44e7         254843          72384               10738              89
    6 Afghanis…        30  6.44e7         205771          71786               10738              88
    # ℹ 23 more variables: tc_loss_ha_2002 <dbl>, tc_loss_ha_2003 <dbl>, tc_loss_ha_2004 <dbl>,
    #   tc_loss_ha_2005 <dbl>, tc_loss_ha_2006 <dbl>, tc_loss_ha_2007 <dbl>,
    #   tc_loss_ha_2008 <dbl>, tc_loss_ha_2009 <dbl>, tc_loss_ha_2010 <dbl>,
    #   tc_loss_ha_2011 <dbl>, tc_loss_ha_2012 <dbl>, tc_loss_ha_2013 <dbl>,
    #   tc_loss_ha_2014 <dbl>, tc_loss_ha_2015 <dbl>, tc_loss_ha_2016 <dbl>,
    #   tc_loss_ha_2017 <dbl>, tc_loss_ha_2018 <dbl>, tc_loss_ha_2019 <dbl>,
    #   tc_loss_ha_2020 <dbl>, tc_loss_ha_2021 <dbl>, tc_loss_ha_2022 <dbl>, …
    > glimpse(df_clean)
    Rows: 1,328
    Columns: 30
    $ country             <chr> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", "Afgh…
$ threshold           <dbl> 0, 10, 15, 20, 25, 30, 50, 75, 0, 10, 15, 20, 25, 30, 50, 75, 0, …
$ area_ha             <dbl> 64383655, 64383655, 64383655, 64383655, 64383655, 64383655, 64383…
$ extent_2000_ha      <dbl> 64383655, 432070, 302629, 284330, 254843, 205771, 148417, 75480, …
$ extent_2010_ha      <dbl> 64383655, 126231, 106852, 105718, 72384, 71786, 46235, 18268, 287…
$ `gain_2000-2012_ha` <dbl> 10738, 10738, 10738, 10738, 10738, 10738, 10738, 10738, 16468, 16…
$ tc_loss_ha_2001     <dbl> 103, 92, 91, 89, 89, 88, 78, 46, 3907, 3815, 3783, 3760, 3737, 37…
$ tc_loss_ha_2002     <dbl> 214, 190, 186, 181, 180, 179, 135, 61, 940, 909, 898, 893, 890, 8…
$ tc_loss_ha_2003     <dbl> 267, 254, 248, 245, 244, 244, 200, 96, 675, 636, 630, 625, 618, 6…
$ tc_loss_ha_2004     <dbl> 226, 207, 205, 203, 202, 201, 159, 61, 3455, 3327, 3299, 3272, 32…
$ tc_loss_ha_2005     <dbl> 268, 246, 241, 238, 237, 236, 170, 64, 759, 717, 712, 706, 697, 6…
$ tc_loss_ha_2006     <dbl> 172, 159, 156, 153, 153, 152, 112, 43, 1033, 987, 982, 977, 966, …
$ tc_loss_ha_2007     <dbl> 274, 259, 255, 254, 254, 253, 201, 83, 5512, 5346, 5324, 5294, 52…
$ tc_loss_ha_2008     <dbl> 123, 112, 110, 108, 108, 108, 83, 28, 5803, 5607, 5577, 5541, 548…
$ tc_loss_ha_2009     <dbl> 92, 74, 72, 71, 71, 70, 49, 21, 1463, 1379, 1365, 1355, 1341, 133…
$ tc_loss_ha_2010     <dbl> 109, 94, 92, 89, 88, 87, 61, 25, 751, 678, 671, 664, 657, 653, 60…
$ tc_loss_ha_2011     <dbl> 134, 116, 115, 114, 113, 113, 94, 41, 1376, 1255, 1240, 1228, 120…
$ tc_loss_ha_2012     <dbl> 60, 41, 40, 40, 40, 40, 30, 14, 6101, 5699, 5626, 5579, 5481, 539…
$ tc_loss_ha_2013     <dbl> 15, 2, 2, 1, 1, 1, 1, 0, 3273, 2842, 2761, 2725, 2654, 2570, 2222…
$ tc_loss_ha_2014     <dbl> 10, 4, 4, 4, 4, 3, 1, 0, 1419, 1182, 1154, 1133, 1098, 1051, 940,…
$ tc_loss_ha_2015     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 427, 334, 325, 323, 308, 284, 254, 197, 9…
$ tc_loss_ha_2016     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 1394, 1108, 1075, 1052, 1004, 928, 758, 5…
$ tc_loss_ha_2017     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 2870, 2109, 2023, 1967, 1852, 1687, 1371,…
$ tc_loss_ha_2018     <dbl> 31, 28, 28, 28, 27, 26, 20, 9, 2926, 2345, 2272, 2233, 2158, 2049…
$ tc_loss_ha_2019     <dbl> 25, 19, 19, 18, 18, 18, 15, 8, 1626, 1246, 1212, 1188, 1143, 1073…
$ tc_loss_ha_2020     <dbl> 46, 40, 39, 39, 38, 36, 33, 20, 1829, 1310, 1271, 1241, 1185, 111…
$ tc_loss_ha_2021     <dbl> 47, 37, 32, 32, 27, 26, 23, 9, 3267, 2058, 1972, 1926, 1824, 1685…
$ tc_loss_ha_2022     <dbl> 16, 9, 7, 7, 6, 6, 5, 2, 3516, 2441, 2359, 2318, 2236, 2096, 1779…
$ tc_loss_ha_2023     <dbl> 133, 32, 23, 22, 21, 15, 8, 3, 3419, 2769, 2710, 2668, 2598, 2502…
$ tc_loss_ha_2024     <dbl> 223, 32, 17, 16, 14, 10, 6, 3, 1631, 1093, 1041, 1012, 957, 889, …
> 
> # =============================
> # 🌿 Country Tree Cover Loss: Clean & Deduplicate by Country
> # =============================
> 
> library(readxl)
> library(dplyr)
> 
> # 1️⃣ Set your Excel file path
> file_path <- "C:/Users/Sheheryar Malik/Desktop/dataset.xlsx"
> 
> # 2️⃣ Load the sheet with proper headers
> df <- read_excel(file_path, sheet = "Country tree cover loss", col_names = TRUE)
> 
> # 3️⃣ Clean the data
> df_clean_country <- df %>%
+     # Convert empty strings in character columns to NA
+     mutate(across(where(is.character), ~na_if(.x, ""))) %>%
+     # Remove rows where country is missing
+     filter(!is.na(country) & country != "") %>%
+     # Keep only the first record per country
+     distinct(country, .keep_all = TRUE) %>%
+     # Sort by country
+     arrange(country)
> 
> # 4️⃣ View cleaned data
> head(df_clean_country)
# A tibble: 6 × 30
  country   threshold area_ha extent_2000_ha extent_2010_ha `gain_2000-2012_ha` tc_loss_ha_2001
  <chr>         <dbl>   <dbl>          <dbl>          <dbl>               <dbl>           <dbl>
1 Afghanis…         0  6.44e7       64383655       64383655               10738             103
2 Albania           0  2.87e6        2872761        2872761               16468            3907
3 Algeria           0  2.31e8      230802067      230802067               89147            3824
4 Angola            0  1.25e8      124691420      124691420             1224131          120511
5 Argentina         0  2.78e8      277905834      277905834             1107407          193755
6 Australia         0  7.69e8      768777179      768777179             1600599          961028
# ℹ 23 more variables: tc_loss_ha_2002 <dbl>, tc_loss_ha_2003 <dbl>, tc_loss_ha_2004 <dbl>,
#   tc_loss_ha_2005 <dbl>, tc_loss_ha_2006 <dbl>, tc_loss_ha_2007 <dbl>,
#   tc_loss_ha_2008 <dbl>, tc_loss_ha_2009 <dbl>, tc_loss_ha_2010 <dbl>,
#   tc_loss_ha_2011 <dbl>, tc_loss_ha_2012 <dbl>, tc_loss_ha_2013 <dbl>,
#   tc_loss_ha_2014 <dbl>, tc_loss_ha_2015 <dbl>, tc_loss_ha_2016 <dbl>,
#   tc_loss_ha_2017 <dbl>, tc_loss_ha_2018 <dbl>, tc_loss_ha_2019 <dbl>,
#   tc_loss_ha_2020 <dbl>, tc_loss_ha_2021 <dbl>, tc_loss_ha_2022 <dbl>, …
> glimpse(df_clean_country)
Rows: 166
Columns: 30
$ country             <chr> "Afghanistan", "Albania", "Algeria", "Angola", "Argentina", "Aust…
    $ threshold           <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    $ area_ha             <dbl> 64383655, 2872761, 230802067, 124691420, 277905834, 768777179, 83…
    $ extent_2000_ha      <dbl> 64383655, 2872761, 230802067, 124691420, 277905834, 768777179, 83…
    $ extent_2010_ha      <dbl> 64383655, 2872761, 230802067, 124691420, 277905834, 768777179, 83…
    $ `gain_2000-2012_ha` <dbl> 10738, 16468, 89147, 1224131, 1107407, 1600599, 36348, 30269, 317…
    $ tc_loss_ha_2001     <dbl> 103, 3907, 3824, 120511, 193755, 961028, 7001, 608, 4654, 18549, …
    $ tc_loss_ha_2002     <dbl> 214, 940, 3291, 73036, 125216, 556660, 10983, 1268, 4090, 25629, …
    $ tc_loss_ha_2003     <dbl> 267, 675, 4124, 69101, 318701, 997500, 14567, 1113, 2215, 32319, …
    $ tc_loss_ha_2004     <dbl> 226, 3455, 4989, 98592, 522345, 255809, 14709, 670, 4414, 38868, …
    $ tc_loss_ha_2005     <dbl> 268, 759, 4976, 134547, 428199, 736689, 21809, 294, 3362, 36420, …
    $ tc_loss_ha_2006     <dbl> 172, 1033, 6124, 108318, 360852, 399784, 12657, 610, 7064, 42550,…
    $ tc_loss_ha_2007     <dbl> 274, 5512, 5912, 219100, 481900, 594794, 31859, 570, 4168, 32868,…
    $ tc_loss_ha_2008     <dbl> 123, 5803, 9227, 158953, 652189, 354623, 27026, 551, 4662, 36123,…
    $ tc_loss_ha_2009     <dbl> 92, 1463, 11499, 273492, 332684, 289052, 15986, 453, 5817, 35827,…
    $ tc_loss_ha_2010     <dbl> 109, 751, 3044, 198278, 444187, 479887, 16826, 681, 4858, 35984, …
    $ tc_loss_ha_2011     <dbl> 134, 1376, 8994, 289249, 538815, 168504, 18174, 216, 4391, 45714,…
    $ tc_loss_ha_2012     <dbl> 60, 6101, 13637, 255397, 520588, 193125, 11312, 702, 5959, 40213,…
    $ tc_loss_ha_2013     <dbl> 15, 3273, 12285, 269297, 443955, 356587, 7990, 262, 7892, 29019, …
    $ tc_loss_ha_2014     <dbl> 10, 1419, 16308, 300058, 298707, 565957, 10211, 453, 15558, 34659…
    $ tc_loss_ha_2015     <dbl> 0, 427, 9684, 228811, 211067, 490293, 8099, 29, 16504, 35208, 360…
    $ tc_loss_ha_2016     <dbl> 0, 1394, 13017, 333994, 276756, 680108, 17605, 30, 28071, 94630, …
    $ tc_loss_ha_2017     <dbl> 0, 2870, 63446, 443270, 290584, 451953, 18930, 84, 36459, 81900, …
    $ tc_loss_ha_2018     <dbl> 31, 2926, 8836, 372663, 206846, 532378, 26822, 76, 25624, 90474, …
    $ tc_loss_ha_2019     <dbl> 25, 1626, 11271, 273109, 179782, 2214080, 34322, 14, 27686, 77429…
    $ tc_loss_ha_2020     <dbl> 46, 1829, 21525, 394726, 246213, 3335014, 26418, 27, 27044, 70953…
    $ tc_loss_ha_2021     <dbl> 47, 3267, 32225, 445310, 261628, 399129, 17018, 130, 22098, 65190…
    $ tc_loss_ha_2022     <dbl> 16, 3516, 19552, 391072, 302062, 203793, 20474, 154, 17669, 67456…
    $ tc_loss_ha_2023     <dbl> 133, 3419, 37381, 408150, 284973, 386479, 27289, 701, 24299, 6222…
    $ tc_loss_ha_2024     <dbl> 223, 1631, 8328, 432655, 267155, 362685, 28242, 288, 20833
    # =============================
    > # 🌿 Data Transformation: Country Tree Cover Loss
      > # =============================
    > 
      > library(dplyr)
    > library(tidyr)
    > 
      > # 1️⃣ Start with cleaned dataset
      > df <- df_clean_country  # already cleaned
    > 
      > # 2️⃣ Pivot yearly tree cover loss columns to long format
      > df_long <- df %>%
      +     pivot_longer(
        +         cols = starts_with("tc_loss_ha_"),   # all yearly forest loss columns
        +         names_to = "year",
        +         names_prefix = "tc_loss_ha_",
        +         values_to = "forest_loss_cumulative_ha"
        +     ) %>%
      +     mutate(year = as.integer(year))  # convert year to numeric
    > 
      > # 3️⃣ Calculate annual forest loss (if cumulative)
      > df_long <- df_long %>%
      +     group_by(country) %>%
      +     arrange(year, .by_group = TRUE) %>%
      +     mutate(forest_loss_ha = forest_loss_cumulative_ha - lag(forest_loss_cumulative_ha, default = 0)) %>%
      +     ungroup()
    > 
      > # 4️⃣ Handle per capita emissions if column exists
      > # Replace 'per_capita_emissions' with your actual column name if available
      > if("per_capita_emissions" %in% colnames(df)) {
        +     df_long <- df_long %>%
          +         mutate(per_capita_emissions = per_capita_emissions)  # keep or calculate if needed
        + } else {
          +     message("No per capita emissions column found — skipping this step")
          + }
    No per capita emissions column found — skipping this step
    > 
      > # 5️⃣ Select final columns and arrange
      > df_final <- df_long %>%
      +     select(country, year, forest_loss_ha, everything()) %>%
      +     arrange(country, year)
    > 
      > # 6️⃣ View final dataset
      > head(df_final)
    # A tibble: 6 × 9
    country      year forest_loss_ha threshold  area_ha extent_2000_ha extent_2010_ha
    <chr>       <int>          <dbl>     <dbl>    <dbl>          <dbl>          <dbl>
      1 Afghanistan  2001            103         0 64383655       64383655       64383655
    2 Afghanistan  2002            111         0 64383655       64383655       64383655
    3 Afghanistan  2003             53         0 64383655       64383655       64383655
    4 Afghanistan  2004            -41         0 64383655       64383655       64383655
    5 Afghanistan  2005             42         0 64383655       64383655       64383655
    6 Afghanistan  2006            -96         0 64383655       64383655       64383655
    # ℹ 2 more variables: `gain_2000-2012_ha` <dbl>, forest_loss_cumulative_ha <dbl>
    > glimpse(df_final)
    Rows: 3,984
    Columns: 9
    $ country                   <chr> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan",…
    $ year                      <int> 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,…
    $ forest_loss_ha            <dbl> 103, 111, 53, -41, 42, -96, 102, -151, -31, 17, 25, -74, -4…
    $ threshold                 <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    $ area_ha                   <dbl> 64383655, 64383655, 64383655, 64383655, 64383655, 64383655,…
    $ extent_2000_ha            <dbl> 64383655, 64383655, 64383655, 64383655, 64383655, 64383655,…
    $ extent_2010_ha            <dbl> 64383655, 64383655, 64383655, 64383655, 64383655, 64383655,…
    $ `gain_2000-2012_ha`       <dbl> 10738, 10738, 10738, 10738, 10738, 10738, 10738, 10738, 107…
    $ forest_loss_cumulative_ha <dbl> 103, 214, 267, 226, 268, 172, 274, 123, 92, 109, 134, 60, 1…
    > 
      > # 7️⃣ Optional: Save transformed dataset
      > write.csv(df_final, "C:/Users/Sheheryar Malik/Desktop/df_final_country_year.csv", row.names = FALSE)
    > 
      > df_final <- df_final %>%
      +     mutate(forest_loss_ha = ifelse(forest_loss_ha < 0, NA, forest_loss_ha))