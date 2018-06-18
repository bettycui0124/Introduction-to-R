# ======================================================================
# Title: R script binomial-function
# Description: Practice Writing functions
# Author: Betty Cui
# Data: 03/23/2018
# =====================================================================================================

#' @title is_integer function
#' @description to test if a single number is an integer
#' @param single number input
#' @return True or False which is a Boolean function

is_integer <- function(x){
  if (x %% 1 == 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

## True
is_integer(-1) # TRUE
is_integer(0) # TRUE
is_integer(2L) # TRUE
is_integer(2) # TRUE

## False
is_integer(2.1) # FALSE
is_integer(pi) # FALSE
is_integer(0.01) # FALSE


#' @title is_positive function
#' @description to test if a single number is positive
#' @param single number input
#' @return True or False which is a Boolean function

is_positive <- function(x){
  if (x > 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

## True
is_positive(0.01) #TRUE
is_positive(2) #TRUE

## False
is_positive(-2) #FALSE
is_positive(0) #FALSE


#' @title is_non-negative function
#' @description to test if a single number is non-negative
#' @param single number input
#' @return True or False which is a Boolean function

is_nonnegative <- function(x){
  if (x >= 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

## True
is_nonnegative(0) #TRUE
is_nonnegative(2) #TRUE

## False
is_nonnegative(-0.00001) #FALSE
is_nonnegative(-2) #FALSE


#' @title is_positive_integer function
#' @description to test if a single number is positive integer
#' @param single number input
#' @return True or False which is a Boolean function

is_positive_integer <- function(x){
  if (x > 0 & x %% 1 == 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

## True
is_positive_integer(2L) #TRUE
is_positive_integer(2) #TRUE

## False
is_positive_integer(-2) #FALSE
is_positive_integer(0) #FALSE


#' @title is_nonneg_integer function
#' @description to test if a single number is nonnegative integer
#' @param single number input
#' @return True or False which is a Boolean function

is_nonneg_integer <- function(x){
  if (x >= 0 & x %% 1 == 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

## True
is_nonneg_integer(0) #TRUE
is_nonneg_integer(1) #TRUE

## False
is_nonneg_integer(-2.5) #FALSE
is_nonneg_integer(-1) #FALSE


#' @title is_probability function
#' @description to test if a given number is a valid probability value: 0 <= p <= 1
#' @param single number input
#' @return True or False which is a Boolean function

is_probability <- function(x){
  if (x <= 1 & x >= 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

## True
is_probability(0) #TRUE
is_probability(0.5) #TRUE
is_probability(1) #TRUE
## False
is_probability(-1) #FALSE
is_probability(1.000000001) #FALSE


#' @title bin_factorial function
#' @description to calculate the factorial of non-negative integer n
#' @param single number input
#' @return factorial product

bin_factorial <- function(x){
  if (x == 0 | x == 1) {
    return(1)
  }
  answer <- 1
  for (i in 1:x){
    answer <- answer * (1:x)[i]
  }
  return(answer)
}

bin_factorial(5) # 120
bin_factorial(0) # 1


#' @title bin_combinations function
#' @description to calculate the the number of combination in which k successes can occur in n trials
#' @param single number input
#' @return bin_combinations result

bin_combinations <- function(n,k){
  return(bin_factorial(n)/(bin_factorial(k)*bin_factorial(n-k)))
}
 
bin_combinations(5, 2) 
bin_combinations(10, 3) 
bin_combinations(4, 4)


#' @title bin_probability function
#' @description to calculate the the number of combination in which k successes can occur in n trials
#' @param single number input
#' @return bin_probability function

bin_probability <- function(trials, success, prob){
  if (is_nonneg_integer(trials) & is_nonneg_integer(success) & is_probability(prob)){
    return(bin_combinations(trials, success) * prob^success * (1 - prob)^(trials - success))
  }
  else{
    stop("Error")
  }
}
bin_probability(trials = 5, success = 2, prob = 0.5)


#' @title bin_distribution function
#' @description to calculate the bin_distribution
#' @param single number input
#' @return bin_distribution function
bin_distribution <- function(trials, prob){
  dat <- data.frame(success = 0:trials, probability = rep(0, trials+1))
  for(i in 0:trials) {
    dat[,2][i+1] <- bin_probability(trials, i ,prob)
  }
  return(dat)
}

