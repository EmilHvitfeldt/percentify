library(dplyr)

df <- data.frame(var1 = 1:100,
                 var2 = 1:100)

test_that("calculations are done correctly", {

  df_percented <- percentify_random(df, var1, 0.5, 10)

  expect_equal(
    rep(50, 10), tolerance = 1,
    group_size(df_percented)
  )
})

test_that("upper n works as intended", {

  n <- c(5, 10, 20)

  for (i in seq_len(length(n))) {
    df <- percentify_random(df, var1, 0.5, n[i])

    expect_equal(group_data(df) %>% nrow(),
                 n[i])
  }
})

test_that("arguments are being guarded", {
  expect_error(percentify_random(df, var1, -0.2, 10), "width")

  expect_error(percentify_random(df, var1, 1.2, 10), "width")

  expect_error(percentify_random(df, var1, 0.2, 0), "n")
})
