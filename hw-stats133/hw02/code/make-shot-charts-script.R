library(ggplot2)
klay_scatterplot <- ggplot(data = thompson) + 
  geom_point(aes(x = x, y=y, color = shot_made_flag))
klay_scatterplot

install.packages("jpeg")
library(grid)
library(jpeg)
court_file <- "/Users/cj/Desktop/stats133/hw-stats133/hw02/images/nba-court.jpg"
court_image <- rasterGrob(readJPEG(court_file),
                          width = unit(1, "npc"),
                          height = unit(1, "npc"))

###4.1）
klay_thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y=y, color = shot_made_flag)) +
               ylim(-50, 420) +
               ggtitle("Short Chart: Klay Thompson (2016 season)") +
               theme_minimal()
klay_thompson_shot_chart

andre_iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y=y, color = shot_made_flag)) +
            ylim(-50, 420) +
            ggtitle("Short Chart: Andre Iguodala (2016 season)") +
            theme_minimal()
andre_iguodala_shot_chart

draymond_green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y=y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle("Short Chart: Andre Iguodala (2016 season)") +
  theme_minimal()
draymond_green_shot_chart

kevin_durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y=y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle("Short Chart: Andre Iguodala (2016 season)") +
  theme_minimal()
kevin_durant_shot_chart

stephen_curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y=y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle("Short Chart: Andre Iguodala (2016 season)") +
  theme_minimal()
stephen_curry_shot_chart

pdf(file = '/Users/cj/Desktop/stats133/hw-stats133/hw02/images/klay_thompson_shot_chart.pdf', width = 6.5, height = 5)
klay_thompson_shot_chart
dev.off()

pdf(file = '/Users/cj/Desktop/stats133/hw-stats133/hw02/images/stephen_curry_shot_chart.pdf', width = 6.5, height = 5)
stephen_curry_shot_chart
dev.off()

pdf(file = '/Users/cj/Desktop/stats133/hw-stats133/hw02/images/kevin_durant_shot_chart.pdf', width = 6.5, height = 5)
kevin_durant_shot_chart
dev.off()

pdf(file = '/Users/cj/Desktop/stats133/hw-stats133/hw02/images/andre_iguodala_shot_chart.pdf', width = 6.5, height = 5)
andre_iguodala_shot_chart
dev.off()

pdf(file = '/Users/cj/Desktop/stats133/hw-stats133/hw02/images/draymond_green_shot_chart.pdf', width = 6.5, height = 5)
draymond_green_shot_chart
dev.off()


### 4.2) Facetted Shot Chart
All_shot_chart <- ggplot(data = total) + annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: (2016 season)') + theme_minimal() +
  facet_wrap(~ name)

pdf("/Users/cj/Desktop/stats133/hw-stats133/hw02/images/gsw-shot-charts.pdf", width = 8, height = 7)
All_shot_chart
dev.off()


