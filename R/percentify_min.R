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
#' cut_mtcars <- percentify_min(mtcars, mpg, c(0.25, 0.75))
#' summarize(cut_mtcars,
#'           mean_hp = mean(hp),
#'           mean_wt = mean(wt),
#'           n_obs = n()
#'           )
percentify_min <- function(tbl, var, q = numeric(), lower = 0) {
  percentify(tbl, {{var}}, lower = rep(lower, length(q)), upper = q)
}
