#' Group a data.frame by percentile ranges in variable with constant upper bound
#'
#' This function is a small wrapper around \code{\link{percentify}}, where the
#' upper bound is a fixed value.
#'
#' There is a [ggplot2::autoplot()] to vizualise the the percentile ranges.
#'
#' @inheritParams percentify
#' @param q Numerical values for lower bound of ranges. Must be between 0
#'   and 1.
#'
#' @return percentile grouped tibble
#' @export
#'
#' @family percentile samplers
#'
#' @examples
#' library(dplyr)
#' library(broom)
#' percent_mtcars <- percentify_max(mtcars, mpg, c(0, 0.25, 0.5, 0.75))
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
#'
#' library(ggplot2)
#' autoplot(percent_mtcars)
percentify_max <- function(data, var, q = numeric(), upper = 1) {
  percentify(data, {{var}}, lower = q, upper = rep(upper, length(q)))
}
