#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Drawing Balls Experiment"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "num",
                  "Number of Repetitions:",
                  min = 1,
                  max = 5000,
                  value = 100)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # Create two character vectors box1 and box2 with colors of balls:
    box1 <- c('blue', 'blue', 'red')
    box2 <- c('blue', 'blue', rep('red', 3), 'white')
    
    n <- input$num
    # simulate one random experiment, size 4, first with replacement,
    # second without replacement
    # generating a uniform distribution first in the if statement
    if (runif(1, min = 0, max = 1) >= 0.5){
      sample(box1, size = 4, replace = TRUE)
    }else{
      sample(box2, size = 4, replace = FALSE)
    }
    
    # repeat the experiment 1000 times using a for loop
    drawn_balls <- matrix(data = NA, nrow = n, ncol = 4)
    
    for(i in 1:n){
      if (runif(1, min = 0, max = 1) >= 0.5){
        drawn_balls[i, ] <- sample(box1, size = 4, replace = TRUE)
      }else{
        drawn_balls[i, ] <- sample(box2, size = 4, replace = FALSE)
      }
    }
    # take a look at the first 5 rows
    head(drawn_balls)
    
    # compute the proportion of samples containing: 0, 1, 2, 3, or 4 blue balls.
    count_blue <- c(rep(0, n))
    for(i in 1:n){
      for(j in 1:4){
        if(drawn_balls[i, j] == "blue"){
          count_blue[i] <- count_blue[i] + 1
        }
      }
    }
    
    # obtain the following plot showing the relative frequencies 
    # of number of blue balls over the series of repetitions.
    freqs0 <- c(rep(0, n))
    if(count_blue[1] == 0){
      freqs0[1] <- 1
    }
    for(i in 2:n){
      if(count_blue[i] == 0){
        freqs0[i] <- freqs0[i - 1] + 1
      }else{
        freqs0[i] <- freqs0[i - 1]
      }
    }
    
    freqs1 <- c(rep(0, n))
    if(count_blue[1] == 1){
      freqs1[1] <- 1
    }
    for(i in 2:n){
      if(count_blue[i] == 1){
        freqs1[i] <- freqs1[i - 1] + 1
      }else{
        freqs1[i] <- freqs1[i - 1]
      }
    }
    
    freqs2 <- c(rep(0, n))
    if(count_blue[1] == 2){
      freqs2[1] <- 1
    }
    for(i in 2:n){
      if(count_blue[i] == 2){
        freqs2[i] <- freqs2[i - 1] + 1
      }else{
        freqs2[i] <- freqs2[i - 1]
      }
    }
    
    freqs3 <- c(rep(0, n))
    if(count_blue[1] == 3){
      freqs3[1] <- 1
    }
    for(i in 2:n){
      if(count_blue[i] == 3){
        freqs3[i] <- freqs3[i - 1] + 1
      }else{
        freqs3[i] <- freqs3[i - 1]
      }
    }
    
    freqs4 <- c(rep(0, n))
    if(count_blue[1] == 4){
      freqs4[1] <- 1
    }
    for(i in 2:n){
      if(count_blue[i] == 4){
        freqs4[i] <- freqs4[i - 1] + 1
      }else{
        freqs4[i] <- freqs4[i - 1]
      }
    }
    
    # creating a dataframe
    freq <- c(freqs0, freqs1, freqs2, freqs3, freqs4)
    reps <- rep(1:n, 5)
    
    blue_freq <- data.frame(
      reps,
      num_blue = c(rep(0, n), rep(1, n), rep(2, n), rep(3, n), rep(4, n)),
      freq,
      rel_freq = freq/reps
    )
    blue_freq$num_blue <- as.factor(blue_freq$num_blue)
    
    # use the dataframe to create the plot
    library(ggplot2)
    ggplot(data = blue_freq, aes(x = reps, y = rel_freq, group = num_blue)) +
      geom_path(aes(color = num_blue)) +
      ggtitle("Relative Frequencies of Number of Blue Balls")
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

