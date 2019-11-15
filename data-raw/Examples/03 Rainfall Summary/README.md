Example 3 - Summarising Rainfall Data
================

R tools such as **dplyr** and **tidyr** can be used to summarise data
(e.g. add rain observations to obtain monthly and annual cumulative
amounts). The three libraries are first loaded.

``` r
library(aimsir17)
library(dplyr)
library(tidyr)
```

Next, we show the overall data set (219,000 observations)

``` r
observations
```

    ## # A tibble: 219,000 x 12
    ##    station  year month   day  hour date                 rain  temp  rhum
    ##    <chr>   <dbl> <dbl> <int> <int> <dttm>              <dbl> <dbl> <dbl>
    ##  1 ATHENRY  2017     1     1     0 2017-01-01 00:00:00   0     5.2    89
    ##  2 ATHENRY  2017     1     1     1 2017-01-01 01:00:00   0     4.7    89
    ##  3 ATHENRY  2017     1     1     2 2017-01-01 02:00:00   0     4.2    90
    ##  4 ATHENRY  2017     1     1     3 2017-01-01 03:00:00   0.1   3.5    87
    ##  5 ATHENRY  2017     1     1     4 2017-01-01 04:00:00   0.1   3.2    89
    ##  6 ATHENRY  2017     1     1     5 2017-01-01 05:00:00   0     2.1    91
    ##  7 ATHENRY  2017     1     1     6 2017-01-01 06:00:00   0     2      89
    ##  8 ATHENRY  2017     1     1     7 2017-01-01 07:00:00   0     1.7    89
    ##  9 ATHENRY  2017     1     1     8 2017-01-01 08:00:00   0     1      91
    ## 10 ATHENRY  2017     1     1     9 2017-01-01 09:00:00   0     1.1    91
    ## # … with 218,990 more rows, and 3 more variables: msl <dbl>, wdsp <dbl>,
    ## #   wddir <dbl>

We can confirm the number of records gathered for each month, and show
these

``` r
observations %>% 
  group_by(station, month) %>%
  summarise(TotalObservations=n()) %>%
  pivot_wider(names_from = month,values_from = TotalObservations) %>%
  print(n=25)
```

    ## # A tibble: 25 x 13
    ## # Groups:   station [25]
    ##    station   `1`   `2`   `3`   `4`   `5`   `6`   `7`   `8`   `9`  `10`
    ##    <chr>   <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
    ##  1 ATHENRY   744   672   744   720   744   720   744   744   720   744
    ##  2 BALLYH…   744   672   744   720   744   720   744   744   720   744
    ##  3 BELMUL…   744   672   744   720   744   720   744   744   720   744
    ##  4 CASEME…   744   672   744   720   744   720   744   744   720   744
    ##  5 CLAREM…   744   672   744   720   744   720   744   744   720   744
    ##  6 CORK A…   744   672   744   720   744   720   744   744   720   744
    ##  7 DUBLIN…   744   672   744   720   744   720   744   744   720   744
    ##  8 DUNSANY   744   672   744   720   744   720   744   744   720   744
    ##  9 FINNER    744   672   744   720   744   720   744   744   720   744
    ## 10 GURTEEN   744   672   744   720   744   720   744   744   720   744
    ## 11 JOHNST…   744   672   744   720   744   720   744   744   720   744
    ## 12 KNOCK …   744   672   744   720   744   720   744   744   720   744
    ## 13 MACE H…   744   672   744   720   744   720   744   744   720   744
    ## 14 MALIN …   744   672   744   720   744   720   744   744   720   744
    ## 15 MARKREE   744   672   744   720   744   720   744   744   720   744
    ## 16 MOORE …   744   672   744   720   744   720   744   744   720   744
    ## 17 MT DIL…   744   672   744   720   744   720   744   744   720   744
    ## 18 MULLIN…   744   672   744   720   744   720   744   744   720   744
    ## 19 NEWPORT   744   672   744   720   744   720   744   744   720   744
    ## 20 OAK PA…   744   672   744   720   744   720   744   744   720   744
    ## 21 PHOENI…   744   672   744   720   744   720   744   744   720   744
    ## 22 ROCHES…   744   672   744   720   744   720   744   744   720   744
    ## 23 SHANNO…   744   672   744   720   744   720   744   744   720   744
    ## 24 Sherki…   744   672   744   720   744   720   744   744   720   744
    ## 25 VALENT…   744   672   744   720   744   720   744   744   720   744
    ## # … with 2 more variables: `11` <int>, `12` <int>

We can also confirm the number of missing rainfall values for each
month.

``` r
observations %>% 
  group_by(station, month) %>%
  summarise(TotalMissing=sum(is.na(rain))) %>%
  pivot_wider(names_from = month,values_from = TotalMissing) %>%
  print(n=25)
```

    ## # A tibble: 25 x 13
    ## # Groups:   station [25]
    ##    station   `1`   `2`   `3`   `4`   `5`   `6`   `7`   `8`   `9`  `10`
    ##    <chr>   <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
    ##  1 ATHENRY     0     0     0     0     0     0     0     0     0     0
    ##  2 BALLYH…     0     0     0     0     0     0     0     0     0     1
    ##  3 BELMUL…     0     0     0     0     0     0     0     0     0     0
    ##  4 CASEME…     0     0     0     0     0     0     0     0     0     0
    ##  5 CLAREM…     0     0     0     0     0     0    23     0     0     0
    ##  6 CORK A…     0     0     0     0     0     0     0     0     0     0
    ##  7 DUBLIN…     0     0     0     0     0     0     0     0     0     0
    ##  8 DUNSANY     0     0     0     0     0     0     0     0     0     0
    ##  9 FINNER      0     0     0     0     0     0     0     0     0     0
    ## 10 GURTEEN     0     0     0     0     0     0     0     1     0     0
    ## 11 JOHNST…     0     2     0     0     0     0     1     0     0     0
    ## 12 KNOCK …     0     0     0     0     0     0     0     0     0     0
    ## 13 MACE H…     0     0     0     0     0     0     0     0     0     0
    ## 14 MALIN …     0     0     0     0     0     0     0     0     0     0
    ## 15 MARKREE     0     0     0     0     2     0     9     0     1     0
    ## 16 MOORE …     0     0     0     0     0     0     0     0     0     0
    ## 17 MT DIL…     2     0     0     0     0     0     0     0     0     0
    ## 18 MULLIN…     0     0     0     0     0     0     0     3     0     0
    ## 19 NEWPORT     0     0     0     0     0     0     0    15     0     0
    ## 20 OAK PA…     0     0     0     0     0     0     0     0     2     0
    ## 21 PHOENI…     0     0     0     2     0     0     0     0     0     0
    ## 22 ROCHES…     0     0     0     0     0     0     0     0     0     0
    ## 23 SHANNO…     0     0     0     0     0     0     0     0     0     0
    ## 24 Sherki…     0     0     0     0     0     4     0     0     0     2
    ## 25 VALENT…     0     0     0     0     0     0     0     0     0     0
    ## # … with 2 more variables: `11` <int>, `12` <int>

We can sum all the rainfall values for each station by each month

``` r
observations %>% 
  group_by(station, month) %>%
  summarise(TotalRainfall=sum(rain,na.rm = T)) %>%
  pivot_wider(names_from = month,values_from = TotalRainfall) %>%
  print(n=25)
```

    ## # A tibble: 25 x 13
    ## # Groups:   station [25]
    ##    station   `1`   `2`   `3`   `4`   `5`   `6`   `7`   `8`   `9`  `10`
    ##    <chr>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ##  1 ATHENRY  47.4  87.5 143.   13.5  61.4 120.  137.  103.  118.  123. 
    ##  2 BALLYH…  32.8  72.6  80.3  16.2  54.5  84.2 109.   95.9 108.   95.8
    ##  3 BELMUL…  60   111.  109.   25.2  48.6  98.6  98.7 134.  139.  132. 
    ##  4 CASEME…  27.6  63.6  65.9   8.8  67.1  91.8  42.9  65.4  70.5  57.2
    ##  5 CLAREM…  50.6  82.9 136.   16.8  76.7  95.3  97.2 107.  144.  115. 
    ##  6 CORK A… 110.  113.  115.   24.7  60.6 109    60.2  72.2 169.  128  
    ##  7 DUBLIN…  22.8  41.6  67.2  10    43.5  86.4  42.2  73.2  82.3  47.8
    ##  8 DUNSANY  35.8  52.9  92.2  14.5  66.9  97.9  72.3  61.1 102.   73.9
    ##  9 FINNER   54.4  63.4 141.   25.7  69.9  63   105.  164.  148.  141. 
    ## 10 GURTEEN  41.5  62.9  98.7  16.9  81.5  92.5  58.7  96   104.  111  
    ## 11 JOHNST…  63.9  69.5  78.8  17.5  67.6 125.   60.1  75.2 161.   64.8
    ## 12 KNOCK …  55.5  87.5 135    23.6  65.4 113   134.  144.  170.  122. 
    ## 13 MACE H…  58.2  97.1 111.   19.4  44.3 100.   93   104.  111   122. 
    ## 14 MALIN …  56.7  85    97    41.1  50.9  77.7 115.  172.   88.2 110. 
    ## 15 MARKREE  51.4  87.7 102.   30.8  69.4  83.6  99.5 134.  174.  103. 
    ## 16 MOORE …  87   108.  116.   19.3  72.4  93.3  54.1  72.3 116.  102. 
    ## 17 MT DIL…  31.9  84.5 103.   15.9  63.8  72.9  94   103.  105.  108. 
    ## 18 MULLIN…  41.6  75    83.8  14.2  70.7  98.1  90.4  77   113.  104. 
    ## 19 NEWPORT  94.9 151   216.   31.2  64.2 108.  164   196   153.  191. 
    ## 20 OAK PA…  38.6  57.8  66.6  15.8  81.8  91    52.7  62.3  91.4  62.9
    ## 21 PHOENI…  25.2  62    75.3  11.4  47.7  95.6  52.8  80.5  87.2  51.3
    ## 22 ROCHES…  87.3  73.6 121.    9.2  53.8 104.   50.9  78.6 142.  126. 
    ## 23 SHANNO…  54.1  71.1 134.   17.9  45.2  86.5 134.   82.7  99.1  80.7
    ## 24 Sherki…  67.6  78.5 133.   14.6  39.2 109.   89.9  78.6 151.  112. 
    ## 25 VALENT… 169.  139.  135.   51.4  76.3 143   108.  103.  204.  162. 
    ## # … with 2 more variables: `11` <dbl>, `12` <dbl>

Order the months from driest to wettest

``` r
observations %>% 
  group_by(month) %>%
  summarise(TotalRainfall=sum(rain,na.rm = T)) %>%
  arrange(TotalRainfall) %>%
  print(n=12)
```

    ## # A tibble: 12 x 2
    ##    month TotalRainfall
    ##    <dbl>         <dbl>
    ##  1     4          506.
    ##  2     1         1466.
    ##  3     5         1543.
    ##  4     2         2079.
    ##  5     7         2216.
    ##  6    11         2409 
    ##  7     6         2440.
    ##  8     8         2536 
    ##  9    10         2648 
    ## 10     3         2754.
    ## 11    12         3098.
    ## 12     9         3151.

Finally, order the weather stations from driest to wettest, with an
index value where 100 is the wettest for 2017 (Newport\!)

``` r
observations %>% 
  group_by(station) %>%
  summarise(TotalRainfall=sum(rain,na.rm = T)) %>%
  arrange(TotalRainfall) %>%
  mutate(Index=100*TotalRainfall/max(TotalRainfall)) %>%
  print(n=25)
```

    ## # A tibble: 25 x 3
    ##    station              TotalRainfall Index
    ##    <chr>                        <dbl> <dbl>
    ##  1 DUBLIN AIRPORT                662.  37.8
    ##  2 CASEMENT                      705.  40.2
    ##  3 PHOENIX PARK                  732   41.8
    ##  4 OAK PARK                      759.  43.3
    ##  5 DUNSANY                       810.  46.2
    ##  6 BALLYHAISE                    952.  54.4
    ##  7 MULLINGAR                     952.  54.4
    ##  8 JOHNSTOWNII                   963   55.0
    ##  9 GURTEEN                       983.  56.1
    ## 10 MT DILLON                     992.  56.6
    ## 11 ROCHES POINT                 1013.  57.8
    ## 12 MOORE PARK                   1016.  58.0
    ## 13 SHANNON AIRPORT              1069.  61.0
    ## 14 SherkinIsland                1072.  61.2
    ## 15 MACE HEAD                    1114.  63.6
    ## 16 MALIN HEAD                   1147.  65.5
    ## 17 CORK AIRPORT                 1162.  66.3
    ## 18 MARKREE                      1182.  67.5
    ## 19 ATHENRY                      1199.  68.5
    ## 20 CLAREMORRIS                  1204   68.7
    ## 21 FINNER                       1222.  69.7
    ## 22 BELMULLET                    1243.  71.0
    ## 23 KNOCK AIRPORT                1343.  76.7
    ## 24 VALENTIA OBSERVATORY         1598.  91.2
    ## 25 NEWPORT                      1752. 100
