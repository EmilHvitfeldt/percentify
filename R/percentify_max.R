#' Title
#'
#' @param tbl data.frame or tibble
#' @param var a variable
#' @param q q
#' @param upper numeric
#'
#' @return percentile grouped tibble
#' @export
#'
#' @examples
#' library(dplyr)
#' cut_mtcars <- percentify_max(mtcars, mpg, c(0.25, 0.75))
#' summarize(cut_mtcars,
#'           mean_hp = mean(hp),
#'           mean_wt = mean(wt),
#'           n_obs = n()
#'           )
percentify_max <- function(tbl, var, q = numeric(), upper = 1) {
  percentify(tbl, {{var}}, lower = q, upper = rep(upper, length(q)))
}
