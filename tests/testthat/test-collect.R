library(dplyr)
test_that("can collect()", {

  x <- percentify(mtcars, mpg, 0, 1,)

  expect_error(
    x_c <- collect(x),
    NA
  )

  expect_equal(
    nrow(x_c),
    32
  )

  expect_is(
    x_c,
    "grouped_df"
  )

  expect_false("resample_df" %in% class(x_c))

  expect_equal(
    colnames(x_c),
    c(".percentile_mpg", colnames(mtcars))
  )
})


test_that("`key` is propagated to `collect()`", {

  x <- percentify(mtcars, mpg, 0, 1, ".test")

  expect_equal(
    colnames(collect(x))[1],
    ".test_mpg"
  )

})
