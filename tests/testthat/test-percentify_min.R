library(dplyr)

df <- data.frame(var1 = 1:100,
                 var2 = 1:100)

test_that("calculations are done correctly", {
  q <- c(0.2, 0.6, 0.78, 0.9)

  df_percented <- percentify_min(df, var1, q)

  expect_equal(
    (q) * 100,
    group_size(df_percented)
  )

  expect_equal(
    (0 * 100 + q * 100 + 1) / 2,
    df_percented %>%
      summarise(avg = mean(var2)) %>%
      pull(avg)
  )
})

test_that("lower argument works as intended", {

  q <- c(0.2, 0.6)
  lower <- 0.1

  df_percented <- percentify_min(df, var1, q, lower)

  expect_equal(
    (q - lower) * 100,
    group_size(df_percented)
  )

  expect_equal(
    (lower * 100 + q * 100 + 1) / 2,
    df_percented %>%
      summarise(avg = mean(var2)) %>%
      pull(avg)
  )
})
