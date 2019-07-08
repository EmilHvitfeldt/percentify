library(dplyr)

test_that("can create grouped data frames", {

  expect_error(
    x <- percentify(mtcars, mpg, 0, 1),
    NA
  )

  expect_is(x, "grouped_df")

  x_gd <- group_data(x)

  expect_equal(
    colnames(x_gd),
    c(".percentile_mpg", ".rows")
  )

  expect_equal(
    x_gd[[".percentile_mpg"]],
    c("0%-100%")
  )

  expect_equal(
    nrow(x_gd),
    1
  )

  expect_equal(
    unique(vapply(x_gd$.rows, length, integer(1))),
    c(32)
  )
})

test_that("calculations are done correctly", {
  df <- data.frame(var1 = 1:100,
                   var2 = 1:100)
  lower <- c(0.0, 0.1, 0.2, 0.5, 0.8)
  upper <- c(0.6, 0.9, 0.8, 0.6, 0.95)

  df_percented <- percentify(df, var1, lower, upper)

  expect_equal(
    (upper - lower) * 100,
    group_size(df_percented)
  )

  expect_equal(
    (upper * 100 + lower * 100 + 1) / 2,
    df_percented %>%
      summarise(avg = mean(var2)) %>%
      pull(avg)
  )
})
