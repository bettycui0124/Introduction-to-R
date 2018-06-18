# ===================================================================
# Title: Archive of an R Package
# Description: This script performs to create the functions 
# Input(s): NA
# Output(s):NA 
# Author(s): Betty Cui
# Date: 04-12-2018
# ===================================================================

#Function reads data from website
#' @title Read Archive Data Table
#' @description check its associated archive
#' @param x is package name 
#' @return data tabe 
read_archive <-function(x){
  list <- readHTMLTable(paste0('http://cran.r-project.org/src/contrib/Archive/',x))
  return(list[[1]])
}
raw_data <- read_archive('stringr')

#Function extracts dates
#' @title Read Date
#' @description Read date return the data column
#' @param x is the raw data
#' @return data column 
version_dates <- function(x){
  raw_vector <- x[,2]
  return(raw_vector)
}

#Function extracts sizes
#' @title Read Size
#' @description Read size return the data column
#' @param x is the raw data
#' @return size column 
version_sizes <- function(x){
  raw_vector <- x[,3]
  return(raw_vector)
}

#Function extracts names
#' @title Read Name
#' @description Read name return the data column
#' @param x is the raw data
#' @return name column 
version_names <- function(x){
  raw_vector <- x[,1]
  return(raw_vector)
}

#Function cleans data
#' @title Data Cleaning
#' @description clean the data
#' @param x is table 
#' @return data frame 
clean_archive <- function(x){
  x <- x[-c(1,2,nrow(x)),-c(1)]
  name_newlist <- unlist(strsplit(str_replace_all(x$Name, pattern = '.tar.gz', replacement = ''), '_'))
  names <- name_newlist[rep(c(TRUE, FALSE))]
  versions <- name_newlist[rep(c(FALSE, TRUE))]
  
  dates <- as.Date(str_sub(version_dates(x), start = 1, end = 10))
  sizes <- as.numeric(str_sub(version_sizes(x), start = 1, end = -2))
  unit <- str_sub(version_sizes(x), start = -1)
  sizes[unit == 'M'] <- 1024 * sizes[unit == 'M']
  
  y <- data.frame(name = names, version = versions, date = dates, size = sizes, stringsAsFactors = FALSE)
  return(y)
}


#' @title Timeline plot
#' @description visualize the timeline with the version sizes of a package.
#' @param x is data frame
#' @return graph
plot_archive = function(clean_data){
  ggplot(data = clean_data, aes(x = date, y = size)) +
    geom_step(color = 'blue') +
    geom_point(color = 'blue')+
    ggtitle("stringr: timeline of version sizes") +
    labs(y = "Size (Kilobytes)")
} 


