#' Group a data.frame by percentile ranges in variable with constant upper bound
#'
#' This function is a wrapper around \code{\link{percentify}}. Given a `width``
#' and a `n`, it will generate a number of random interval with fixed width.
#'
#' @inheritParams percentify
#' @param width Numerical values for the width of the interval. Must be between
#'  0 and 1.
#' @param n Integer, number of intervals to create.
#'
#' @return percentile grouped tibble
#' @export
#'
#' @family percentile samplers
#'
#' @examples
#' library(dplyr)
#' library(broom)
#' percent_mtcars <- percentify_random(mtcars, mpg, 0.4, 10)
#'
#' percent_mtcars
#'
#' summarize(percent_mtcars,
#'           mean_hp = mean(hp),
#'           mean_wt = mean(wt),
#'           n_obs = n()
#'           )
#'
#' percent_mtcars %>%
#'   group_modify(~tidy(lm(disp ~ wt + cyl, data = .x)))
percentify_random <- function(data, var, width, n = 10) {
  lower <- stats::runif(n, 0, 1 - width)
  percentify(data, {{var}},
             lower = lower,
             upper = lower + width)
}
