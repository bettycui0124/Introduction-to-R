---
title: "hw02-summary-table-Betty-Cui"
author: "Betty Cui"
date: "3/5/2018"
output: github_document
---


```r
knitr::opts_chunk$set(echo = TRUE, fig.path =   '/Users/cj/Desktop/stats133/hw-stats133/hw02/images')
```


```r
## 5.1 Total Shots by Player
## table1 is the overall effective shooting percentage by player
Shot <-sort(c(length(curry$shot_made_flag), length(thompson$shot_made_flag), length(durant$shot_made_flag), length(green$shot_made_flag), length(iguodala$shot_made_flag)), decreasing = TRUE)
Name <- c("curry", "thompson", "durant", "green", "iguodala")
table <- data.frame(Name, Shot)
table <- table[order(-table$Shot), , drop = FALSE]
table
```

```
##       Name Shot
## 1    curry 1250
## 2 thompson 1220
## 3   durant  915
## 4    green  578
## 5 iguodala  371
```

```r
## 5.2 Effective Shooting Percentage
Name <- c("curry", "thompson", "durant", "green", "iguodala")
Total <- sort(c(length(curry$shot_made_flag), length(thompson$shot_made_flag), length(durant$shot_made_flag), length(green$shot_made_flag), length(iguodala$shot_made_flag)), decreasing = TRUE)

Made <- c(table(curry$shot_made_flag)[1], table(thompson$shot_made_flag)[1], table(green$shot_made_flag)[1], table(iguodala$shot_made_flag)[1], table(durant$shot_made_flag)[1])

perc_made <- Made/Total
table1 <- data.frame(Name, Total, Made, perc_made)
table1 <- table1[order(-table1$perc_made), , drop = FALSE]
table1
```

```
##       Name Total Made perc_made
## 5 iguodala   371  495 1.3342318
## 2 thompson  1220  575 0.4713115
## 1    curry  1250  584 0.4672000
## 4    green   578  192 0.3321799
## 3   durant   915  245 0.2677596
```

```r
## table2 is 2pt eefective shooting by player
Name <- c("curry", "thompson", "durant", "green", "iguodala")
Total <- sort(c(length(curry$shot_made_flag), length(thompson$shot_made_flag), length(durant$shot_made_flag), length(green$shot_made_flag), length(iguodala$shot_made_flag)), decreasing = TRUE)

library(dplyr)
Made2pt = c(nrow(filter(curry, shot_type == "2PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(thompson, shot_type == "2PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(green, shot_type == "2PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(durant, shot_type == "2PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(iguodala, shot_type == "2PT Field Goal" & shot_made_flag == "made shot")))
perc_made <- Made2pt/Total
table2 <- data.frame(Name, Total, Made2pt, perc_made)
table2 <- table2[order(-table1$perc_made), , drop = FALSE]
table2
```

```
##       Name Total Made2pt perc_made
## 1    curry  1250     304 0.2432000
## 2 thompson  1220     329 0.2696721
## 3   durant   915     171 0.1868852
## 4    green   578     390 0.6747405
## 5 iguodala   371     134 0.3611860
```

```r
## table2 is 3pt eefective shooting by player
Name <- c("curry", "thompson", "durant", "green", "iguodala")
Total <- sort(c(length(curry$shot_made_flag), length(thompson$shot_made_flag), length(durant$shot_made_flag), length(green$shot_made_flag), length(iguodala$shot_made_flag)), decreasing = TRUE)

library(dplyr)
Made3pt = c(nrow(filter(curry, shot_type == "3PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(thompson, shot_type == "3PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(green, shot_type == "3PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(durant, shot_type == "3PT Field Goal" & shot_made_flag == "made shot")), nrow(filter(iguodala, shot_type == "3PT Field Goal" & shot_made_flag == "made shot")))
perc_made <- Made3pt/Total
table3 <- data.frame(Name, Total, Made3pt, perc_made)
table3 <- table3[order(-table1$perc_made), , drop = FALSE]
table3
```

```
##       Name Total Made3pt  perc_made
## 1    curry  1250     280 0.22400000
## 2 thompson  1220     246 0.20163934
## 3   durant   915      74 0.08087432
## 4    green   578     105 0.18166090
## 5 iguodala   371      58 0.15633423
```


```r
### Shooting Distance
## 6.1) dplyr table
library(ggplot2)
library(dplyr)
dis_total = total %>%
  group_by(shot_distance) %>%
  count(shot_type) %>%
  summarise(made = sum(n))

dis_made = total %>%
  filter(shot_made_flag == 'made shot') %>%
  group_by(shot_distance) %>%
  count(shot_type) %>%
  summarise(made = sum(n))

dis_made
```

```
## # A tibble: 35 x 2
##    shot_distance  made
##            <int> <int>
##  1             0   344
##  2             1   262
##  3             2   151
##  4             3    31
##  5             4    23
##  6             5    12
##  7             6    19
##  8             7    17
##  9             8    19
## 10             9    17
## # ... with 25 more rows
```

```r
dis_total = total %>%
  filter(shot_made_flag == 'made shot') %>%
  group_by(shot_distance) %>%
  summarise(made = n())

dis_total
```

```
## # A tibble: 35 x 2
##    shot_distance  made
##            <int> <int>
##  1             0   344
##  2             1   262
##  3             2   151
##  4             3    31
##  5             4    23
##  6             5    12
##  7             6    19
##  8             7    17
##  9             8    19
## 10             9    17
## # ... with 25 more rows
```

```r
dis_total_made <- merge(dis_total, dis_made, all = TRUE, by = "shot_distance")
dis_total_made[is.na(dis_total_made)] <- 0
dis_total_made
```

```
##    shot_distance made.x made.y
## 1              0    344    344
## 2              1    262    262
## 3              2    151    151
## 4              3     31     31
## 5              4     23     23
## 6              5     12     12
## 7              6     19     19
## 8              7     17     17
## 9              8     19     19
## 10             9     17     17
## 11            10     26     26
## 12            11     20     20
## 13            12     32     32
## 14            13     24     24
## 15            14     30     30
## 16            15     36     36
## 17            16     57     57
## 18            17     37     37
## 19            18     57     57
## 20            19     42     42
## 21            20     31     31
## 22            21     24     24
## 23            22     50     50
## 24            23    115    115
## 25            24    142    142
## 26            25    211    211
## 27            26    151    151
## 28            27     60     60
## 29            28     21     21
## 30            29     15     15
## 31            30      6      6
## 32            31      4      4
## 33            32      2      2
## 34            33      2      2
## 35            51      1      1
```

```r
shot_distance_prop = select(shot_distance, shot_distance, made_shot_prop)
shot_distance_prop
```

```
## # A tibble: 35 x 2
##    shot_distance made_shot_prop
##            <int>          <dbl>
##  1             0        0.275  
##  2             1        0.215  
##  3             2        0.165  
##  4             3        0.0536 
##  5             4        0.0620 
##  6             5        0.00960
##  7             6        0.0156 
##  8             7        0.0186 
##  9             8        0.0329 
## 10             9        0.0458 
## # ... with 25 more rows
```

```r
## 6.2
ggplot(data = shot_distance_prop, aes(x = shot_distance, y = made_shot_prop)) + geom_point()
```

![plot of chunk unnamed-chunk-2](/Users/cj/Desktop/stats133/hw-stats133/hw02/imagesunnamed-chunk-2-1.png)

```r
## What do you observe?
# In general, distance and made shot probability and in inverse ratio relationship, i.e. Longer shot distance, made shot probability is smaller.
## Can you confirm that the shoter the distance, the more effective the shots?
#No, because there are still some data shows that made shot probability and can shot in shorter distance.
## Can you guesstimate a distance threshold beyond which the chance of making a successful shot is basically null?
# 52
## What distances tend to have a percentage of 50% or more?
# 20
```


```r
## What do you observe?
# In general, distance and made shot probability and in inverse ratio relationship, i.e. Longer shot distance, made shot probability is smaller.
## Can you confirm that the shoter the distance, the more effective the shots?
#No, because there are still some data shows that made shot probability and can shot in shorter distance.
## Can you guesstimate a distance threshold beyond which the chance of making a successful shot is basically null?
# 52
## What distances tend to have a percentage of 50% or more?
# 20
```


```r
## Total number of shots by minutes of occurrence
library(ggplot2)
library(dplyr)

total
```

```
##                  team_name game_date season period minutes_remaining
## 1    Golden State Warriors  12/15/16   2016      3                 3
## 2    Golden State Warriors  10/28/16   2016      3                 9
## 3    Golden State Warriors   11/1/16   2016      2                 5
## 4    Golden State Warriors   12/1/16   2016      3                 5
## 5    Golden State Warriors    4/4/17   2016      3                 2
## 6    Golden State Warriors  11/19/16   2016      4                 5
## 7    Golden State Warriors  11/21/16   2016      3                 9
## 8    Golden State Warriors   3/29/17   2016      2                 1
## 9    Golden State Warriors  11/25/16   2016      3                10
## 10   Golden State Warriors  12/28/16   2016      3                 3
## 11   Golden State Warriors   3/28/17   2016      4                 9
## 12   Golden State Warriors  12/11/16   2016      4                 3
## 13   Golden State Warriors  12/10/16   2016      3                 4
## 14   Golden State Warriors   2/27/17   2016      1                 9
## 15   Golden State Warriors    3/6/17   2016      1                 1
## 16   Golden State Warriors   3/21/17   2016      1                 8
## 17   Golden State Warriors   12/3/16   2016      3                 9
## 18   Golden State Warriors   2/27/17   2016      4                 5
## 19   Golden State Warriors   12/7/16   2016      1                 3
## 20   Golden State Warriors   3/16/17   2016      3                 5
## 21   Golden State Warriors    1/6/17   2016      1                 8
## 22   Golden State Warriors  10/28/16   2016      3                 3
## 23   Golden State Warriors  11/23/16   2016      3                 2
## 24   Golden State Warriors    2/2/17   2016      4                 6
## 25   Golden State Warriors  12/17/16   2016      1                 3
## 26   Golden State Warriors  12/20/16   2016      2                 1
## 27   Golden State Warriors  11/25/16   2016      4                 2
## 28   Golden State Warriors   3/26/17   2016      3                 8
## 29   Golden State Warriors   2/10/17   2016      1                 2
## 30   Golden State Warriors   1/28/17   2016      1                11
## 31   Golden State Warriors  12/25/16   2016      4                 4
## 32   Golden State Warriors  11/19/16   2016      3                 8
## 33   Golden State Warriors  11/23/16   2016      2                 2
## 34   Golden State Warriors   2/15/17   2016      1                 9
## 35   Golden State Warriors   12/7/16   2016      1                 7
## 36   Golden State Warriors   12/7/16   2016      2                 4
## 37   Golden State Warriors  11/21/16   2016      3                 6
## 38   Golden State Warriors    1/6/17   2016      4                 1
## 39   Golden State Warriors  11/26/16   2016      1                 2
## 40   Golden State Warriors    2/2/17   2016      1                 4
## 41   Golden State Warriors  11/13/16   2016      2                 5
## 42   Golden State Warriors   11/9/16   2016      2                 8
## 43   Golden State Warriors    1/4/17   2016      1                 5
## 44   Golden State Warriors  11/18/16   2016      2                 1
## 45   Golden State Warriors  11/18/16   2016      4                 0
## 46   Golden State Warriors  11/13/16   2016      3                 1
## 47   Golden State Warriors   3/29/17   2016      3                 5
## 48   Golden State Warriors    1/2/17   2016      1                 2
## 49   Golden State Warriors   2/25/17   2016      4                 2
## 50   Golden State Warriors  11/16/16   2016      1                 7
## 51   Golden State Warriors    4/4/17   2016      1                10
## 52   Golden State Warriors   2/23/17   2016      3                 1
## 53   Golden State Warriors   3/29/17   2016      1                 1
## 54   Golden State Warriors  12/28/16   2016      4                 0
## 55   Golden State Warriors  12/20/16   2016      1                 1
## 56   Golden State Warriors  11/26/16   2016      3                 2
## 57   Golden State Warriors  11/26/16   2016      4                 5
## 58   Golden State Warriors  12/30/16   2016      1                 7
## 59   Golden State Warriors  12/20/16   2016      1                 1
## 60   Golden State Warriors   3/29/17   2016      2                 0
## 61   Golden State Warriors  11/19/16   2016      4                 2
## 62   Golden State Warriors  11/18/16   2016      3                 7
##      seconds_remaining shot_made_flag                     action_type
## 1                   51      made shot  Cutting Finger Roll Layup Shot
## 2                   14      made shot  Cutting Finger Roll Layup Shot
## 3                    8      made shot  Cutting Finger Roll Layup Shot
## 4                   27      made shot  Cutting Finger Roll Layup Shot
## 5                    4      made shot  Cutting Finger Roll Layup Shot
## 6                   36      made shot  Cutting Finger Roll Layup Shot
## 7                   51      made shot  Cutting Finger Roll Layup Shot
## 8                   40      made shot  Cutting Finger Roll Layup Shot
## 9                   59      made shot              Cutting Layup Shot
## 10                  54      made shot              Cutting Layup Shot
## 11                  36      made shot              Cutting Layup Shot
## 12                  34      made shot              Cutting Layup Shot
## 13                  12    missed shot              Cutting Layup Shot
## 14                  29      made shot              Cutting Layup Shot
## 15                  40      made shot              Cutting Layup Shot
## 16                  40      made shot              Cutting Layup Shot
## 17                  14      made shot              Cutting Layup Shot
## 18                  51      made shot              Cutting Layup Shot
## 19                   8      made shot              Cutting Layup Shot
## 20                  51    missed shot              Cutting Layup Shot
## 21                  39      made shot              Cutting Layup Shot
## 22                  12      made shot              Cutting Layup Shot
## 23                  55      made shot              Cutting Layup Shot
## 24                  16      made shot              Cutting Layup Shot
## 25                  20      made shot              Cutting Layup Shot
## 26                  36      made shot              Cutting Layup Shot
## 27                  31      made shot              Cutting Layup Shot
## 28                   9    missed shot              Cutting Layup Shot
## 29                  41      made shot              Cutting Layup Shot
## 30                  22      made shot              Cutting Layup Shot
## 31                  28      made shot              Cutting Layup Shot
## 32                   3      made shot              Cutting Layup Shot
## 33                  41      made shot              Cutting Layup Shot
## 34                  28      made shot              Cutting Layup Shot
## 35                   6      made shot              Cutting Layup Shot
## 36                  38      made shot              Cutting Layup Shot
## 37                  46      made shot               Driving Bank shot
## 38                  20      made shot               Driving Bank shot
## 39                  41      made shot               Driving Bank shot
## 40                   7      made shot               Driving Bank shot
## 41                  30      made shot               Driving Bank shot
## 42                  42      made shot  Driving Finger Roll Layup Shot
## 43                  53      made shot  Driving Finger Roll Layup Shot
## 44                  52      made shot  Driving Finger Roll Layup Shot
## 45                  48      made shot  Driving Finger Roll Layup Shot
## 46                   6      made shot  Driving Finger Roll Layup Shot
## 47                  22      made shot  Driving Finger Roll Layup Shot
## 48                  24    missed shot  Driving Finger Roll Layup Shot
## 49                  59      made shot  Driving Finger Roll Layup Shot
## 50                  22      made shot  Driving Finger Roll Layup Shot
## 51                  16    missed shot  Driving Finger Roll Layup Shot
## 52                  52      made shot  Driving Finger Roll Layup Shot
## 53                  49    missed shot  Driving Finger Roll Layup Shot
## 54                  13      made shot  Driving Finger Roll Layup Shot
## 55                   0    missed shot  Driving Finger Roll Layup Shot
## 56                   9      made shot  Driving Finger Roll Layup Shot
## 57                   3      made shot  Driving Finger Roll Layup Shot
## 58                  31      made shot  Driving Finger Roll Layup Shot
## 59                  49      made shot  Driving Finger Roll Layup Shot
## 60                  49      made shot  Driving Finger Roll Layup Shot
## 61                  47      made shot  Driving Finger Roll Layup Shot
## 62                  18      made shot  Driving Finger Roll Layup Shot
##           shot_type shot_distance               opponent    x   y
## 1    2PT Field Goal             3        New York Knicks   25  21
## 2    2PT Field Goal             2   New Orleans Pelicans    9  26
## 3    2PT Field Goal             2 Portland Trail Blazers  -22   2
## 4    2PT Field Goal             0        Houston Rockets    2   7
## 5    2PT Field Goal             2 Minnesota Timberwolves    1  26
## 6    2PT Field Goal             0        Milwaukee Bucks    2   7
## 7    2PT Field Goal             0         Indiana Pacers   -1   2
## 8    2PT Field Goal             2      San Antonio Spurs   28   0
## 9    2PT Field Goal             1     Los Angeles Lakers   13   6
## 10   2PT Field Goal             1        Toronto Raptors   -9   8
## 11   2PT Field Goal             0        Houston Rockets   -4  -5
## 12   2PT Field Goal             1 Minnesota Timberwolves   14   7
## 13   2PT Field Goal             2      Memphis Grizzlies  -24  -6
## 14   2PT Field Goal             0     Philadelphia 76ers   -7  -6
## 15   2PT Field Goal             2          Atlanta Hawks   20   7
## 16   2PT Field Goal             1       Dallas Mavericks   12  -1
## 17   2PT Field Goal             1           Phoenix Suns    0  11
## 18   2PT Field Goal             1     Philadelphia 76ers   12   7
## 19   2PT Field Goal             2   Los Angeles Clippers   -7  21
## 20   2PT Field Goal             2          Orlando Magic   22  18
## 21   2PT Field Goal             1      Memphis Grizzlies    4  11
## 22   2PT Field Goal             1   New Orleans Pelicans   17   7
## 23   2PT Field Goal             1     Los Angeles Lakers    1  11
## 24   2PT Field Goal             2   Los Angeles Clippers   22  16
## 25   2PT Field Goal             2 Portland Trail Blazers   -1  23
## 26   2PT Field Goal             1              Utah Jazz   -1  16
## 27   2PT Field Goal             0     Los Angeles Lakers    8  -2
## 28   2PT Field Goal             2      Memphis Grizzlies    9  21
## 29   2PT Field Goal             2      Memphis Grizzlies   24   7
## 30   2PT Field Goal             1   Los Angeles Clippers   -7  16
## 31   2PT Field Goal             0    Cleveland Cavaliers    1  -5
## 32   2PT Field Goal             0        Milwaukee Bucks    0   7
## 33   2PT Field Goal             1     Los Angeles Lakers   10  16
## 34   2PT Field Goal             1       Sacramento Kings    6  16
## 35   2PT Field Goal             2   Los Angeles Clippers   25   2
## 36   2PT Field Goal             2   Los Angeles Clippers    6  21
## 37   2PT Field Goal            11         Indiana Pacers -110  36
## 38   2PT Field Goal             6      Memphis Grizzlies  -43  46
## 39   2PT Field Goal             3 Minnesota Timberwolves   12  31
## 40   2PT Field Goal             5   Los Angeles Clippers  -52  18
## 41   2PT Field Goal            11           Phoenix Suns  -70  85
## 42   2PT Field Goal             1       Dallas Mavericks   10  16
## 43   2PT Field Goal             2 Portland Trail Blazers   -7  26
## 44   2PT Field Goal             2         Boston Celtics  -25   7
## 45   2PT Field Goal             1         Boston Celtics   -9  16
## 46   2PT Field Goal             2           Phoenix Suns   -1  21
## 47   2PT Field Goal             1      San Antonio Spurs    9  -5
## 48   2PT Field Goal             2         Denver Nuggets   17  11
## 49   2PT Field Goal             3          Brooklyn Nets   20  23
## 50   2PT Field Goal             3        Toronto Raptors  -29  11
## 51   2PT Field Goal             3 Minnesota Timberwolves   22  26
## 52   2PT Field Goal             2   Los Angeles Clippers  -12  16
## 53   2PT Field Goal             0      San Antonio Spurs   -2   8
## 54   2PT Field Goal             1        Toronto Raptors    0  16
## 55   2PT Field Goal             2              Utah Jazz   -9  28
## 56   2PT Field Goal             2 Minnesota Timberwolves    0  26
## 57   2PT Field Goal             1 Minnesota Timberwolves    6  16
## 58   2PT Field Goal             0       Dallas Mavericks    2   7
## 59   2PT Field Goal             2              Utah Jazz    2  21
## 60   2PT Field Goal             1      San Antonio Spurs  -19   2
## 61   2PT Field Goal             1        Milwaukee Bucks   15   7
## 62   2PT Field Goal             1         Boston Celtics    9  -5
##                name minute new
## 1     Stephen-Curry     33   1
## 2     Stephen-Curry     27   1
## 3     Stephen-Curry     19   1
## 4     Stephen-Curry     31   1
## 5     Stephen-Curry     34   1
## 6     Stephen-Curry     43   1
## 7     Stephen-Curry     27   1
## 8     Stephen-Curry     23   1
## 9     Stephen-Curry     26   1
## 10    Stephen-Curry     33   1
## 11    Stephen-Curry     39   1
## 12    Stephen-Curry     45   1
## 13    Stephen-Curry     32   1
## 14    Stephen-Curry      3   1
## 15    Stephen-Curry     11   1
## 16    Stephen-Curry      4   1
## 17    Stephen-Curry     27   1
## 18    Stephen-Curry     43   1
## 19    Stephen-Curry      9   1
## 20    Stephen-Curry     31   1
## 21    Stephen-Curry      4   1
## 22    Stephen-Curry     33   1
## 23    Stephen-Curry     34   1
## 24    Stephen-Curry     42   1
## 25    Stephen-Curry      9   1
## 26    Stephen-Curry     23   1
## 27    Stephen-Curry     46   1
## 28    Stephen-Curry     28   1
## 29    Stephen-Curry     10   1
## 30    Stephen-Curry      1   1
## 31    Stephen-Curry     44   1
## 32    Stephen-Curry     28   1
## 33    Stephen-Curry     22   1
## 34    Stephen-Curry      3   1
## 35    Stephen-Curry      5   1
## 36    Stephen-Curry     20   1
## 37    Stephen-Curry     30   1
## 38    Stephen-Curry     47   1
## 39    Stephen-Curry     10   1
## 40    Stephen-Curry      8   1
## 41    Stephen-Curry     19   1
## 42    Stephen-Curry     16   1
## 43    Stephen-Curry      7   1
## 44    Stephen-Curry     23   1
## 45    Stephen-Curry     48   1
## 46    Stephen-Curry     35   1
## 47    Stephen-Curry     31   1
## 48    Stephen-Curry     10   1
## 49    Stephen-Curry     46   1
## 50    Stephen-Curry      5   1
## 51    Stephen-Curry      2   1
## 52    Stephen-Curry     35   1
## 53    Stephen-Curry     11   1
## 54    Stephen-Curry     48   1
## 55    Stephen-Curry     11   1
## 56    Stephen-Curry     34   1
## 57    Stephen-Curry     43   1
## 58    Stephen-Curry      5   1
## 59    Stephen-Curry     11   1
## 60    Stephen-Curry     24   1
## 61    Stephen-Curry     46   1
## 62    Stephen-Curry     29   1
##  [ reached getOption("max.print") -- omitted 4272 rows ]
```

```r
total["new"] <- "1"
total
```

```
##                  team_name game_date season period minutes_remaining
## 1    Golden State Warriors  12/15/16   2016      3                 3
## 2    Golden State Warriors  10/28/16   2016      3                 9
## 3    Golden State Warriors   11/1/16   2016      2                 5
## 4    Golden State Warriors   12/1/16   2016      3                 5
## 5    Golden State Warriors    4/4/17   2016      3                 2
## 6    Golden State Warriors  11/19/16   2016      4                 5
## 7    Golden State Warriors  11/21/16   2016      3                 9
## 8    Golden State Warriors   3/29/17   2016      2                 1
## 9    Golden State Warriors  11/25/16   2016      3                10
## 10   Golden State Warriors  12/28/16   2016      3                 3
## 11   Golden State Warriors   3/28/17   2016      4                 9
## 12   Golden State Warriors  12/11/16   2016      4                 3
## 13   Golden State Warriors  12/10/16   2016      3                 4
## 14   Golden State Warriors   2/27/17   2016      1                 9
## 15   Golden State Warriors    3/6/17   2016      1                 1
## 16   Golden State Warriors   3/21/17   2016      1                 8
## 17   Golden State Warriors   12/3/16   2016      3                 9
## 18   Golden State Warriors   2/27/17   2016      4                 5
## 19   Golden State Warriors   12/7/16   2016      1                 3
## 20   Golden State Warriors   3/16/17   2016      3                 5
## 21   Golden State Warriors    1/6/17   2016      1                 8
## 22   Golden State Warriors  10/28/16   2016      3                 3
## 23   Golden State Warriors  11/23/16   2016      3                 2
## 24   Golden State Warriors    2/2/17   2016      4                 6
## 25   Golden State Warriors  12/17/16   2016      1                 3
## 26   Golden State Warriors  12/20/16   2016      2                 1
## 27   Golden State Warriors  11/25/16   2016      4                 2
## 28   Golden State Warriors   3/26/17   2016      3                 8
## 29   Golden State Warriors   2/10/17   2016      1                 2
## 30   Golden State Warriors   1/28/17   2016      1                11
## 31   Golden State Warriors  12/25/16   2016      4                 4
## 32   Golden State Warriors  11/19/16   2016      3                 8
## 33   Golden State Warriors  11/23/16   2016      2                 2
## 34   Golden State Warriors   2/15/17   2016      1                 9
## 35   Golden State Warriors   12/7/16   2016      1                 7
## 36   Golden State Warriors   12/7/16   2016      2                 4
## 37   Golden State Warriors  11/21/16   2016      3                 6
## 38   Golden State Warriors    1/6/17   2016      4                 1
## 39   Golden State Warriors  11/26/16   2016      1                 2
## 40   Golden State Warriors    2/2/17   2016      1                 4
## 41   Golden State Warriors  11/13/16   2016      2                 5
## 42   Golden State Warriors   11/9/16   2016      2                 8
## 43   Golden State Warriors    1/4/17   2016      1                 5
## 44   Golden State Warriors  11/18/16   2016      2                 1
## 45   Golden State Warriors  11/18/16   2016      4                 0
## 46   Golden State Warriors  11/13/16   2016      3                 1
## 47   Golden State Warriors   3/29/17   2016      3                 5
## 48   Golden State Warriors    1/2/17   2016      1                 2
## 49   Golden State Warriors   2/25/17   2016      4                 2
## 50   Golden State Warriors  11/16/16   2016      1                 7
## 51   Golden State Warriors    4/4/17   2016      1                10
## 52   Golden State Warriors   2/23/17   2016      3                 1
## 53   Golden State Warriors   3/29/17   2016      1                 1
## 54   Golden State Warriors  12/28/16   2016      4                 0
## 55   Golden State Warriors  12/20/16   2016      1                 1
## 56   Golden State Warriors  11/26/16   2016      3                 2
## 57   Golden State Warriors  11/26/16   2016      4                 5
## 58   Golden State Warriors  12/30/16   2016      1                 7
## 59   Golden State Warriors  12/20/16   2016      1                 1
## 60   Golden State Warriors   3/29/17   2016      2                 0
## 61   Golden State Warriors  11/19/16   2016      4                 2
## 62   Golden State Warriors  11/18/16   2016      3                 7
##      seconds_remaining shot_made_flag                     action_type
## 1                   51      made shot  Cutting Finger Roll Layup Shot
## 2                   14      made shot  Cutting Finger Roll Layup Shot
## 3                    8      made shot  Cutting Finger Roll Layup Shot
## 4                   27      made shot  Cutting Finger Roll Layup Shot
## 5                    4      made shot  Cutting Finger Roll Layup Shot
## 6                   36      made shot  Cutting Finger Roll Layup Shot
## 7                   51      made shot  Cutting Finger Roll Layup Shot
## 8                   40      made shot  Cutting Finger Roll Layup Shot
## 9                   59      made shot              Cutting Layup Shot
## 10                  54      made shot              Cutting Layup Shot
## 11                  36      made shot              Cutting Layup Shot
## 12                  34      made shot              Cutting Layup Shot
## 13                  12    missed shot              Cutting Layup Shot
## 14                  29      made shot              Cutting Layup Shot
## 15                  40      made shot              Cutting Layup Shot
## 16                  40      made shot              Cutting Layup Shot
## 17                  14      made shot              Cutting Layup Shot
## 18                  51      made shot              Cutting Layup Shot
## 19                   8      made shot              Cutting Layup Shot
## 20                  51    missed shot              Cutting Layup Shot
## 21                  39      made shot              Cutting Layup Shot
## 22                  12      made shot              Cutting Layup Shot
## 23                  55      made shot              Cutting Layup Shot
## 24                  16      made shot              Cutting Layup Shot
## 25                  20      made shot              Cutting Layup Shot
## 26                  36      made shot              Cutting Layup Shot
## 27                  31      made shot              Cutting Layup Shot
## 28                   9    missed shot              Cutting Layup Shot
## 29                  41      made shot              Cutting Layup Shot
## 30                  22      made shot              Cutting Layup Shot
## 31                  28      made shot              Cutting Layup Shot
## 32                   3      made shot              Cutting Layup Shot
## 33                  41      made shot              Cutting Layup Shot
## 34                  28      made shot              Cutting Layup Shot
## 35                   6      made shot              Cutting Layup Shot
## 36                  38      made shot              Cutting Layup Shot
## 37                  46      made shot               Driving Bank shot
## 38                  20      made shot               Driving Bank shot
## 39                  41      made shot               Driving Bank shot
## 40                   7      made shot               Driving Bank shot
## 41                  30      made shot               Driving Bank shot
## 42                  42      made shot  Driving Finger Roll Layup Shot
## 43                  53      made shot  Driving Finger Roll Layup Shot
## 44                  52      made shot  Driving Finger Roll Layup Shot
## 45                  48      made shot  Driving Finger Roll Layup Shot
## 46                   6      made shot  Driving Finger Roll Layup Shot
## 47                  22      made shot  Driving Finger Roll Layup Shot
## 48                  24    missed shot  Driving Finger Roll Layup Shot
## 49                  59      made shot  Driving Finger Roll Layup Shot
## 50                  22      made shot  Driving Finger Roll Layup Shot
## 51                  16    missed shot  Driving Finger Roll Layup Shot
## 52                  52      made shot  Driving Finger Roll Layup Shot
## 53                  49    missed shot  Driving Finger Roll Layup Shot
## 54                  13      made shot  Driving Finger Roll Layup Shot
## 55                   0    missed shot  Driving Finger Roll Layup Shot
## 56                   9      made shot  Driving Finger Roll Layup Shot
## 57                   3      made shot  Driving Finger Roll Layup Shot
## 58                  31      made shot  Driving Finger Roll Layup Shot
## 59                  49      made shot  Driving Finger Roll Layup Shot
## 60                  49      made shot  Driving Finger Roll Layup Shot
## 61                  47      made shot  Driving Finger Roll Layup Shot
## 62                  18      made shot  Driving Finger Roll Layup Shot
##           shot_type shot_distance               opponent    x   y
## 1    2PT Field Goal             3        New York Knicks   25  21
## 2    2PT Field Goal             2   New Orleans Pelicans    9  26
## 3    2PT Field Goal             2 Portland Trail Blazers  -22   2
## 4    2PT Field Goal             0        Houston Rockets    2   7
## 5    2PT Field Goal             2 Minnesota Timberwolves    1  26
## 6    2PT Field Goal             0        Milwaukee Bucks    2   7
## 7    2PT Field Goal             0         Indiana Pacers   -1   2
## 8    2PT Field Goal             2      San Antonio Spurs   28   0
## 9    2PT Field Goal             1     Los Angeles Lakers   13   6
## 10   2PT Field Goal             1        Toronto Raptors   -9   8
## 11   2PT Field Goal             0        Houston Rockets   -4  -5
## 12   2PT Field Goal             1 Minnesota Timberwolves   14   7
## 13   2PT Field Goal             2      Memphis Grizzlies  -24  -6
## 14   2PT Field Goal             0     Philadelphia 76ers   -7  -6
## 15   2PT Field Goal             2          Atlanta Hawks   20   7
## 16   2PT Field Goal             1       Dallas Mavericks   12  -1
## 17   2PT Field Goal             1           Phoenix Suns    0  11
## 18   2PT Field Goal             1     Philadelphia 76ers   12   7
## 19   2PT Field Goal             2   Los Angeles Clippers   -7  21
## 20   2PT Field Goal             2          Orlando Magic   22  18
## 21   2PT Field Goal             1      Memphis Grizzlies    4  11
## 22   2PT Field Goal             1   New Orleans Pelicans   17   7
## 23   2PT Field Goal             1     Los Angeles Lakers    1  11
## 24   2PT Field Goal             2   Los Angeles Clippers   22  16
## 25   2PT Field Goal             2 Portland Trail Blazers   -1  23
## 26   2PT Field Goal             1              Utah Jazz   -1  16
## 27   2PT Field Goal             0     Los Angeles Lakers    8  -2
## 28   2PT Field Goal             2      Memphis Grizzlies    9  21
## 29   2PT Field Goal             2      Memphis Grizzlies   24   7
## 30   2PT Field Goal             1   Los Angeles Clippers   -7  16
## 31   2PT Field Goal             0    Cleveland Cavaliers    1  -5
## 32   2PT Field Goal             0        Milwaukee Bucks    0   7
## 33   2PT Field Goal             1     Los Angeles Lakers   10  16
## 34   2PT Field Goal             1       Sacramento Kings    6  16
## 35   2PT Field Goal             2   Los Angeles Clippers   25   2
## 36   2PT Field Goal             2   Los Angeles Clippers    6  21
## 37   2PT Field Goal            11         Indiana Pacers -110  36
## 38   2PT Field Goal             6      Memphis Grizzlies  -43  46
## 39   2PT Field Goal             3 Minnesota Timberwolves   12  31
## 40   2PT Field Goal             5   Los Angeles Clippers  -52  18
## 41   2PT Field Goal            11           Phoenix Suns  -70  85
## 42   2PT Field Goal             1       Dallas Mavericks   10  16
## 43   2PT Field Goal             2 Portland Trail Blazers   -7  26
## 44   2PT Field Goal             2         Boston Celtics  -25   7
## 45   2PT Field Goal             1         Boston Celtics   -9  16
## 46   2PT Field Goal             2           Phoenix Suns   -1  21
## 47   2PT Field Goal             1      San Antonio Spurs    9  -5
## 48   2PT Field Goal             2         Denver Nuggets   17  11
## 49   2PT Field Goal             3          Brooklyn Nets   20  23
## 50   2PT Field Goal             3        Toronto Raptors  -29  11
## 51   2PT Field Goal             3 Minnesota Timberwolves   22  26
## 52   2PT Field Goal             2   Los Angeles Clippers  -12  16
## 53   2PT Field Goal             0      San Antonio Spurs   -2   8
## 54   2PT Field Goal             1        Toronto Raptors    0  16
## 55   2PT Field Goal             2              Utah Jazz   -9  28
## 56   2PT Field Goal             2 Minnesota Timberwolves    0  26
## 57   2PT Field Goal             1 Minnesota Timberwolves    6  16
## 58   2PT Field Goal             0       Dallas Mavericks    2   7
## 59   2PT Field Goal             2              Utah Jazz    2  21
## 60   2PT Field Goal             1      San Antonio Spurs  -19   2
## 61   2PT Field Goal             1        Milwaukee Bucks   15   7
## 62   2PT Field Goal             1         Boston Celtics    9  -5
##                name minute new
## 1     Stephen-Curry     33   1
## 2     Stephen-Curry     27   1
## 3     Stephen-Curry     19   1
## 4     Stephen-Curry     31   1
## 5     Stephen-Curry     34   1
## 6     Stephen-Curry     43   1
## 7     Stephen-Curry     27   1
## 8     Stephen-Curry     23   1
## 9     Stephen-Curry     26   1
## 10    Stephen-Curry     33   1
## 11    Stephen-Curry     39   1
## 12    Stephen-Curry     45   1
## 13    Stephen-Curry     32   1
## 14    Stephen-Curry      3   1
## 15    Stephen-Curry     11   1
## 16    Stephen-Curry      4   1
## 17    Stephen-Curry     27   1
## 18    Stephen-Curry     43   1
## 19    Stephen-Curry      9   1
## 20    Stephen-Curry     31   1
## 21    Stephen-Curry      4   1
## 22    Stephen-Curry     33   1
## 23    Stephen-Curry     34   1
## 24    Stephen-Curry     42   1
## 25    Stephen-Curry      9   1
## 26    Stephen-Curry     23   1
## 27    Stephen-Curry     46   1
## 28    Stephen-Curry     28   1
## 29    Stephen-Curry     10   1
## 30    Stephen-Curry      1   1
## 31    Stephen-Curry     44   1
## 32    Stephen-Curry     28   1
## 33    Stephen-Curry     22   1
## 34    Stephen-Curry      3   1
## 35    Stephen-Curry      5   1
## 36    Stephen-Curry     20   1
## 37    Stephen-Curry     30   1
## 38    Stephen-Curry     47   1
## 39    Stephen-Curry     10   1
## 40    Stephen-Curry      8   1
## 41    Stephen-Curry     19   1
## 42    Stephen-Curry     16   1
## 43    Stephen-Curry      7   1
## 44    Stephen-Curry     23   1
## 45    Stephen-Curry     48   1
## 46    Stephen-Curry     35   1
## 47    Stephen-Curry     31   1
## 48    Stephen-Curry     10   1
## 49    Stephen-Curry     46   1
## 50    Stephen-Curry      5   1
## 51    Stephen-Curry      2   1
## 52    Stephen-Curry     35   1
## 53    Stephen-Curry     11   1
## 54    Stephen-Curry     48   1
## 55    Stephen-Curry     11   1
## 56    Stephen-Curry     34   1
## 57    Stephen-Curry     43   1
## 58    Stephen-Curry      5   1
## 59    Stephen-Curry     11   1
## 60    Stephen-Curry     24   1
## 61    Stephen-Curry     46   1
## 62    Stephen-Curry     29   1
##  [ reached getOption("max.print") -- omitted 4272 rows ]
```

```r
pic4 = total %>%
  select(minute, name, new) %>%
  group_by(minute, name) %>%
  count(new) %>%
  select(minute, name, n) %>%
  group_by(name, minute)


pic4 
```

```
## # A tibble: 233 x 3
## # Groups:   name, minute [233]
##    minute name               n
##     <dbl> <chr>          <int>
##  1   1.00 Draymond-Green    18
##  2   1.00 Kevin-Durant      31
##  3   1.00 Klay-Thompson     35
##  4   1.00 Stephen-Curry     21
##  5   2.00 Draymond-Green    10
##  6   2.00 Kevin-Durant      26
##  7   2.00 Klay-Thompson     42
##  8   2.00 Stephen-Curry     28
##  9   3.00 Draymond-Green    21
## 10   3.00 Kevin-Durant      26
## # ... with 223 more rows
```

```r
p5 <- ggplot(data = pic4, aes(x = minute, y = n)) + facet_wrap(~name) + geom_rect(data = pic4, aes(xmin = 0, xmax = 12, ymin = 0, ymax = 100)) + geom_rect(data = pic4, aes(xmin = 24, xmax = 36, ymin = 0, ymax = 100)) + geom_point() + geom_path(color = "blue") + scale_x_continuous(breaks = c(12, 24, 36, 48)) 
p5
```

![plot of chunk unnamed-chunk-4](/Users/cj/Desktop/stats133/hw-stats133/hw02/imagesunnamed-chunk-4-1.png)

