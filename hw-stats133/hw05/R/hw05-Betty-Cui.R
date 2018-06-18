# 1) Object die
# helper functino check if the probability of the die is valid
check_prob <- function(prob) {
  if (length(prob) != 6 | !is.numeric(prob)) {
    stop("\n'prob' must be a numeric vector of length 6")
  }
  if (any(prob < 0) | any(prob > 1)) {
    stop("\n'prob' values must be between 0 and 1")
  }
  if (sum(prob) != 1) {
    stop("\nelements in 'prob' must add up to 1")
  }
  TRUE
}

# check if the number of sides is 6
check_sides <- function(sides) {
  if (length(sides) != 6) {
    stop("\n'prob' must be a vector of length 6")
  }
  TRUE
}

# override the print function for die class
print.die <- function(x) {
  cat('object "die"\n\n')
  cd <- data.frame(
    side = x$sides, prob = x$prob
  )
  print(cd)
  invisible(x)
}

# Default contructor
die <- function(sides = c(1, 2, 3, 4, 5, 6), prob = c(1/6, 1/6, 1/6, 1/6 ,1/6 ,1/6)) {
  # check if the sides are valid
  check_sides(sides)
  # check if the prob is valid
  check_prob(prob)
  # create an object first
  res <- list(sides = sides, prob = prob)
  # convert to class
  class(res) <- "die"
  # return
  return (res)
}


# Test
fairDie <- die()
fairDie

fairdie <- die(sides = c("i", "ii", "iii", "iv", "v", "vi"))
fairdie

# 2) Object roll

# check if the number of sides is 6
check_times <- function(times) {
  if (!is.numeric(times) | times <= 0) {
    stop("\n'times' must be a positive number")
  }
  TRUE
}

# constuctor of roll class
roll <- function(die = die(), times = 1) {
  check_times(times)
  rolls <- sample(die$sides, size = times, replace = TRUE, prob = die$prob)
  res <- list(rolls = rolls, sides = die$sides, prob = die$prob, total = times)
  class(res) <- "roll"
  return(res)
}



# override the print function for roll class
print.roll <- function(x) {
  cat('object "roll"\n\n')
  cd <- list(rolls = x$rolls)
  print(cd)
  invisible(x)
}

#Test
fair50 <- roll(fairdie, 50)
names(fair50)
fair50
fair50$rolls
fair50$sides
fair50$prob
fair50$total

set.seed(123)
str_die <- die(sides = c('a', 'b', 'c', 'd', 'e', 'f'), prob = c(0.075, 0.1, 0.125, 0.15, 0.20, 0.35))
str_rolls <- roll(str_die, times = 20)
names(str_rolls)
str_rolls

# 3) Summary method for roll objects
summary.roll <- function(x) {
  table <- table(x$rolls)
  side <- names(table)
  count <- as.numeric(table)
  prop <- count / x$total
  freqs <- data.frame(side = side, count = count, prop = prop)
  res <- list(freqs = freqs)
  class(res) <- "summary.roll"
  return(res)
}

# override the print function for summary roll
print.summary.roll <- function(x) {
  cat('summary "roll"\n\n')
  cd <- data.frame(
    side = x$freqs$side, count = x$freqs$count, prop = x$freqs$prop
  )
  cd.names = c("side", "counts", "prop")
  print(cd)
  invisible(x)
}

#Test
fair_50sum <- summary(fair50)
fair_50sum
class(fair_50sum)
names(fair_50sum)
fair_50sum$freqs

# 4) Plot methods for "roll" object
plot.roll <- function(x) {
  x_sum <- summary(x)
  dat <- x_sum$freqs
  barplot(as.vector(dat$prop), 1, ylim = c(0, max(dat$prop)),
          xlab = "sides of die",
          ylab = "reletave frequencies", names.arg = dat$side, border = "grey")
  # add a title
  title(sprintf("Frequencies in a series of %s die rolls", x$total))
}

#Test
plot(fair50)
plot(str_rolls)

# 5)
# extract value
"[.roll" <- function(x, i) {
  if (i > x$total) {
    stop("\nindex out of bounds")
  }
  x$rolls[i]
}

# replace value
"[<-.roll" <- function(x, i, value) {
  if (value != x$sides[1] & value != x$sides[2] & value != x$sides[3] 
      & value != x$sides[4] & value != x$sides[5] & value != x$sides[6]) {
    stop(sprintf('\nreplacing value must be %s or %s or %s or %s or %s or %s',
                 x$sides[1], x$sides[2], x$sides[3], x$sides[4], x$sides[5], x$sides[6]))
  }
  print("la")
  if (i > x$total) {
    stop("\nindex out of bounds")
  }
  x$rolls[i] <- value
  return(x)
}

# addition method
"+.roll" <- function(obj, incr) {
  if (length(incr) != 1 | incr <= 0) {
    stop("\ninvalid increament (must be positive)")
  }
  newdie <- die(obj$sides, obj$prob)
  more_rolls <- roll(newdie, times = incr)
  obj$rolls <- c(obj$rolls, more_rolls$rolls)
  obj$total <- obj$total + more_rolls$total
  
  return(obj)
}


#Test
fair50[50]
fair50[4]
fair50[455] <- 'ii'
fair50[455]
fair50[3]
fair50[3] <- 'oo'
fair50[3] <- 'ii'
fair50[3]
fair50[4]
fair60 <- fair50 + 10
fair60


