#=============================================================================================================
# Title: stats133-lab06
# Description: This lab is about practicing exporting plots and graphs.As well, It is about learning "dplyr"
# Input(s): csv files of nba player data
# Output(s): graphs and plots
# Author(s): Betty Cui
# Date: 02/28/18
#=============================================================================================================

library(readr)    
library(dplyr) 
library(ggplot2)

dat <- data.frame(read_csv("~/Desktop/stats133/lab06", 
                           col_types = cols(
                             player = col_character(),
                             team = col_character(),
                             position = col_character(),
                             height = col_integer(),
                             weight = col_integer(),
                             age = col_integer(),
                             experience = col_integer(),
                             college = col_character(),
                             salary = col_double(),
                             games = col_integer(),
                             minutes = col_integer(),
                             points = col_integer(),
                             points3 = col_integer(),
                             points2 = col_integer(),
                             points1 = col_integer()
                           )))
warriors <- filter(dat, team == "GSW")
warriors <- arrange(warriors, salary)
warriors

write.csv(warriors, file = "~/Desktop/stats133/lab06/data/warriors.csv", 
          row.names = FALSE)
lakers <- filter(dat, team == "LAL")
lakers <- arrange(lakers, desc(experience))
write.csv(lakers, file = "~/Desktop/stats133/lab06/data/lakers.csv", 
          row.names = FALSE)
sink(file = '~/Desktop/stats133/lab06/output/data-structure.txt')
str(dat)
sink()

# Output the structure of the data warriors
sink(file = '~/Desktop/stats133/lab06/output/summary-warriors.txt')
summary(warriors)
sink()

#output the structure of the data lakers
sink(file = "~/Desktop/stats133/lab06/output/summary-lakers.txt")
summary(lakers)
sink()

#Output the images of the scatterplot
png(filename = "~/Desktop/stats133/lab06/images/scatterplot-height-weight.png")
plot(dat$height, dat$weight, main = "Scatterplot of height and weight",
     xlab = "Height", ylab = "Weight",
     col = 2, pch = 20)
dev.off()

#Output the images of the higher resolution of scatterplot
png(filename = "E:/Stat 133/lab06/images/scatterplot-height-weight-higher.png",
    width = 960, height = 960)
plot(dat$height, dat$weight, main = "Scatterplot of height and weight",
     xlab = "Height", ylab = "Weight",
     col = 2, pch = 20, cex = 1.5)
dev.off()

# Output the jpeg form of the histogram
jpeg(filename = "~/Desktop/stats133/lab06/images/hist-of-age.jpg",
     width = 600, height = 400)
hist(dat$age, xlab = "Age", main = "Histogram of Age", col = "grey")
dev.off()

# Output the histogram of age in pdf form
pdf(file = "~/Desktop/stats133/lab06/images/hist-of-age.pdf",
    width = 7, height = 5)
hist(dat$age, xlab = "Age", main = "Histogram of Age", col = "grey")
dev.off()

# Output the ggplot to a pdf file
library(ggplot2)
gg_pts_salary <- ggplot(data = dat, mapping = aes(x = points, y = salary)) +
  geom_point(col = 4, cex = 1.6)
ggsave(filename = "~/Desktop/stats133/lab06/images/point_salary.pdf",
       width = 7, height = 5)

# Creating a new plot to pdf
library(ggplot2)
gg_ht_wt_positions <- ggplot(data = dat, mapping = aes(x = height, y = weight)) +
  geom_point(col = 4) +
  facet_wrap(~ position)
ggsave(filename = "~/Desktop/stats133/lab06/images/height_weight_by_position.pdf",
       width = 7, height = 5)

# display the player names of Lakers
library(dplyr)
dat %>%
  filter(team == "LAL") %>%
  select(player)  

#display the name and salary of the pg of gsw
dat %>%
  filter(position == "PG", team == "GSW") %>%
  select(player, salary)

# Display the 10 more years experienced players
dat %>%
  filter(experience > 10, salary < 10000000) %>%
  select(player, age, team)

#display the height and weight of rookie and age 20 players
dat %>%
  filter(experience = 0, age = 20) %>%
  select(player, team, height, weight) %>%
  slice(1:5)

# create a data frame `gsw_mpg` of GSW players
gsw_mpg <- 
  dat %>%
  cbind(min_per_game = dat$minutes/dat$games) %>%
  filter(team == "GSW") %>%
  select(player, experience, min_per_game) %>%
  arrange(desc(min_per_game))

# worst 3pointer teams
dat %>%
  group_by(team) %>%
  summarise(avg_triple = mean(points3, na.rm = TRUE)) %>%
  arrange(avg_triple) %>%
  slice(1:5)

#obtain the mean and standard deviation of age
age_pf <- 
  dat %>%
  filter(position == "PF", experience >= 5 & experience <= 10) %>%
  select(age)
mean(age_pf$age)
sd(age_pf$age)

