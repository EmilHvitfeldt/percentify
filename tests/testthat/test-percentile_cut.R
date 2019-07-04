library(dplyr)

test_that("can create bootstrapped data frames", {

  expect_error(
    x <- percentify_cut(mtcars, mpg, 0.5),
    NA
  )

  expect_is(x, "percentiled_df")
  expect_is(x, "grouped_df")

  x_gd <- group_data(x)

  expect_equal(
    colnames(x_gd),
    c(".percentile_mpg", ".rows")
  )

  expect_equal(
    x_gd[[".percentile_mpg"]],
    c("0%-50%", "50%-100%")
  )

  expect_equal(
    nrow(x_gd),
    2
  )

  expect_equal(
    unique(vapply(x_gd$.rows, length, integer(1))),
    c(17, 15)
  )

})
