#' Title
#'
#' @param tbl data.frame or tibble
#' @param var a variable
#' @param q q
#'
#' @return percentile grouped tibble
#' @export
#'
#' @examples
#' library(dplyr)
#' cut_mtcars <- percentify_cut(mtcars, mpg, c(0.25, 0.75))
#' summarize(cut_mtcars,
#'           mean_hp = mean(hp),
#'           mean_wt = mean(wt),
#'           n_obs = n()
#'           )
#'
#' @importFrom rlang := ensym
#' @importFrom purrr map map2
#' @importFrom stats quantile
#' @importFrom dplyr new_grouped_df
#' @importFrom tidyr nest
percentify_cut <- function(tbl, var, q = numeric()) {
  percentify(tbl, {{var}}, lower = c(0, q), upper = c(q, 1))
}
