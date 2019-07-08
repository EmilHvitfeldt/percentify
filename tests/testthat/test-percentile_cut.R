library(dplyr)

df <- data.frame(var1 = 1:100,
                 var2 = 1:100)

test_that("calculations are done correctly", {
  q <- c(0.2, 0.6, 0.78, 0.9)

  df_percented <- percentify_cut(df, var1, q)

  expect_equal(
    (c(q, 1) - c(0, q)) * 100,
    group_size(df_percented)
  )

  expect_equal(
    (c(q, 1) * 100 + c(0, q) * 100 + 1) / 2,
    df_percented %>%
      summarise(avg = mean(var2)) %>%
      pull(avg)
  )
})
