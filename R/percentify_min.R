#' Title
#'
#' @param tbl data.frame or tibble
#' @param var a variable
#' @param q q
#' @param lower numeric
#'
#' @return percentile grouped tibble
#' @export
#'
#' @examples
#' library(dplyr)
#' library(broom)
#' percent_mtcars <- percentify_min(mtcars, mpg, c(0.25, 0.5, 0.75, 1))
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
percentify_min <- function(tbl, var, q = numeric(), lower = 0) {
  percentify(tbl, {{var}}, lower = rep(lower, length(q)), upper = q)
}
