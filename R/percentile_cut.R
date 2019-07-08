#' Group a data.frame by percentile ranges in variable by cutting points
#'
#' This function is a small wrapper around \code{\link{percentify}}. This
#' function takes a vector of points and creates ranges between those points,
#' resulting in non-overlapping groups.
#'
#' @inheritParams percentify
#' @param q Numerical values for cutting points. Must be between 0
#'   and 1.
#'
#' @return percentile grouped tibble
#' @export
#'
#' @family percentile samplers
#'
#' @seealso [cut_evenly]
#'
#' @examples
#' library(dplyr)
#' library(broom)
#' percent_mtcars <- percentify_cut(mtcars, mpg, c(0.25, 0.5, 0.75))
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
#' # cut_evenly() can be used to create cuts
#' percentify_cut(mtcars, mpg, cut_evenly(8))
percentify_cut <- function(data, var, q = numeric()) {
  percentify(data, {{var}}, lower = c(0, q), upper = c(q, 1))
}
