library(dplyr)

df <- data.frame(var1 = 1:100,
                 var2 = 1:100)

test_that("calculations are done correctly", {
  q <- c(0.2, 0.6, 0.78, 0.9)

  df_percented <- percentify_max(df, var1, q)

  expect_equal(
    (1 - q) * 100,
    group_size(df_percented)
  )

  expect_equal(
    (1 * 100 + q * 100 + 1) / 2,
    df_percented %>%
      summarise(avg = mean(var2)) %>%
      pull(avg)
  )
})

test_that("upper argument works as intended", {

  q <- c(0.2, 0.6)
  upper <- 0.7

  df_percented <- percentify_max(df, var1, q, upper)

  expect_equal(
    (upper - q) * 100,
    group_size(df_percented)
  )

  expect_equal(
    (upper * 100 + q * 100 + 1) / 2,
    df_percented %>%
      summarise(avg = mean(var2)) %>%
      pull(avg)
  )
})

test_that("arguments are being guarded", {
  expect_error(percentify_max(df, var1, -0.1, 1), "q")

  expect_error(percentify_max(df, var1, 0, 2), "upper")

  expect_error(percentify_max(df, var1, 0.5, 0.3))
})
