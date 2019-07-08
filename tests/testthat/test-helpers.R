test_that("cut_evenly works as intended", {


  expect_equal(
    cut_evenly(4),
    c(0.25, 0.5, 0.75)
  )
})

test_that("cut_evenly errors out when n is missspecified", {
  expect_error(
    cut_evenly(1)
  )

  expect_error(
    cut_evenly(1.5)
  )

  expect_error(
    cut_evenly(1:5)
  )
})
