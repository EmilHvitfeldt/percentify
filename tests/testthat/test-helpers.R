test_that("even_spaced works as intended", {
  expect_equal(
    even_spaced(1),
    0.5
  )

  expect_equal(
    even_spaced(3),
    c(0.25, 0.5, 0.75)
  )

  expect_error(
    even_spaced(1:5)
  )
})
