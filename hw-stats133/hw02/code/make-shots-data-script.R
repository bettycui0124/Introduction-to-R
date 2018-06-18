# ======================================================================
# Title: make shots data script of five NBA players
# Description: this is script that will display all made shots
#              and missed shots of five NBA player
# Input(s): five csv files of NBA player data
# Output(s): Data Table
# Author: Betty Cui
# Data: 03/03/2018
# =====================================================================================================
# 3) Data Preparation
curry <- read.csv("/Users/cj/Desktop/stats133/hw-stats133/hw02/data/stephen-curry.csv", stringsAsFactors = FALSE)
thompson <- read.csv("/Users/cj/Desktop/stats133/hw-stats133/hw02/data/klay-thompson.csv", stringsAsFactors = FALSE)
durant <- read.csv("/Users/cj/Desktop/stats133/hw-stats133/hw02/data/kevin-durant.csv", stringsAsFactors = FALSE)
green <- read.csv("/Users/cj/Desktop/stats133/hw-stats133/hw02/data/draymond-green.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("/Users/cj/Desktop/stats133/hw-stats133/hw02/data/andre-iguodala.csv", stringsAsFactors = FALSE)

curry["name"] <- "Stephen-Curry"
thompson["name"] <- "Klay-Thompson"
durant["name"] <- "Kevin-Durant"
green["name"] <-"Draymond-Green"
iguodala["name"] <- "Andre-Iguodala"

curry$shot_made_flag[curry$shot_made_flag == "n"] <- "missed shot"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "made shot"


thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "missed shot"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "made shot"


durant$shot_made_flag[durant$shot_made_flag == "n"] <- "missed shot"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "made shot"


green$shot_made_flag[green$shot_made_flag == "n"] <- "missed shot"
green$shot_made_flag[green$shot_made_flag == "y"] <- "made shot"


iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "missed shot"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "made shot"

curry["minute"] <- 12*curry$period - curry$minutes_remaining
thompson["minute"] <- 12*thompson$period - thompson$minutes_remaining
durant["minute"] <- 12*durant$period - durant$minutes_remaining
green["minute"] <- 12*green$period - green$minutes_remaining
iguodala["minute"] <- 12*iguodala$period - iguodala$minutes_remaining

sink(file = 
       '/Users/cj/Desktop/stats133/hw-stats133/hw02/output/stephen-curry-summary.txt')
summary(curry)
sink()

sink(file = 
       '/Users/cj/Desktop/stats133/hw-stats133/hw02/output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file = 
       '/Users/cj/Desktop/stats133/hw-stats133/hw02/output/graymond-green-summary.txt')
summary(green)
sink()

sink(file = 
       '/Users/cj/Desktop/stats133/hw-stats133/hw02/output/klay-thompson-summary.txt')
summary(thompson)
sink()

sink(file = 
       '/Users/cj/Desktop/stats133/hw-stats133/hw02/output/andre-inguodala-summary.txt')
summary(iguodala)
sink()

total <- rbind(curry, thompson, green, durant, iguodala)

write.csv(total,
          file = '/Users/cj/Desktop/stats133/hw-stats133/hw02/data/shots-data.csv'
         )

sink(file = 
       '/Users/cj/Desktop/stats133/hw-stats133/hw02/output/shots-data-summary.txt')
summary(total)
sink()

