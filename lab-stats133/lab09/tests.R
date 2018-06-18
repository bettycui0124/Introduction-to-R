source("functions.R")
context("Test for range value")
test_that("range works as expected", {
  x <- c(1, 2, 3, 4, 5)
  
  expect_equal(stat_range(x), 4)
  expect_length(stat_range(x), 1)
  expect_type(stat_range(x), 'double')
})

## Write more groups of tests -- test_that to test stat_range() with the rest of 
## testing vectors y, z, w
## Test vector y
context("Test for range value")
test_that("range works as expected", {
  y <- c(1, 2, 3, 4, NA)
  
  expect_length(stat_range(y), 1)
  expect_equal(stat_range(y), NA_real_)
})

## Test vector z
context("Test for range value")
test_that("range works as expected", {
  z <- c(TRUE, FALSE, TRUE)

  expect_length(stat_range(z), 1)
  expect_type(stat_range(z), 'integer')
  expect_equal(stat_range(z), 1L)
})

## Test vector q
context("Test for range value")
test_that("range works as expected", {
  w <- letters[1:5]
  
  expect_error(stat_range(w))
})


