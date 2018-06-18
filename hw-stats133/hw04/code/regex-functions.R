# Input(s): NA
# Output(s):NA 
# Author(s): Betty Cui
# Date: 04-13-2018
# ===================================================================
library(stringr)

# 2.1 Splitting Characters
#' @title split_chars
#' @description split the content into one single character elements
#' @param l is a string 
#' @return single vector contains elements which are single characters
split_chars <- function(l) {
  result <- strsplit(l, "")
  result <- as.vector(unlist(result))
  return(result)
}

split_chars('Go Bears!')
split_chars('Expecto Patronum')

# 2.2 Number of Vowels
#' @title num_vowels
#' @description returns the number of vowels in a character vector
#' @param x is a single vector
#' @return the number of vowels in a character vector
num_vowels <- function(x) {
  result <- c(0, 0, 0, 0, 0)
  names(result) <- c('a', 'e', 'i', 'o', 'u')
  for (ch in x) {
    if (ch == 'a') {
      result[1] = result[1] + 1
    }
    if (ch == 'e') {
      result[2] = result[2] + 1
    }
    if (ch == 'i') {
      result[3] = result[3] + 1
    }
    if (ch == 'o') {
      result[4] = result[4] + 1
    }
    if (ch == 'u') {
      result[5] = result[5] + 1
    }
  }
  return(result)
}

vec <- c("G", "o", " ", "B", "e", "a", "r", "s", "!")
num_vowels(vec)

# 2.3 Counting vowels
#' @title count_vowels
#' @description computes the number of vowels of a character string (counts both upper and lower case)
#' @param l is a string 
#' @return the number of vowels of a character string
count_vowels <- function(l) {
  l <- tolower(l)
  result <- num_vowels(split_chars(l))
  return(result)
}

count_vowels("The quick brown fox jumps over the lazy dog")
count_vowels("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG")

# 2.4 Reversing characters
#' @title reverse_chars
#' @description reverses a string by characters
#' @param x is a character vector
#' @return a character string with the reversed characters
reverse_chars <- function(x) {
  x <- split_chars(x[1])
  n <- length(x) / 2
  for (i in 1 : n) {
    temp <- x[i]
    x[i] <- x[length(x) - i + 1]
    x[length(x) - i + 1] <- temp
  }
  x <- paste(x, collapse="")
  return(x)
}

reverse_chars("gattaca")
reverse_chars("Lumox Maxima")

# 2.5 Reversing Sentences by Words
#' @title reverse_words
#' @description reverses a string by words
#' @param x is a character vector
#' @return a character string with the reversed words
reverse_chars <- function(x) {
  x <- strsplit(x, " ")
  x <- as.vector(unlist(x))
  n <- length(x) / 2
  for (i in 1 : n) {
    temp <- x[i]
    x[i] <- x[length(x) - i + 1]
    x[length(x) - i + 1] <- temp
  }
  x <- paste(x, collapse=" ")
  return(x)
}

reverse_chars("sentense! this reverse")
reverse_chars("string")


