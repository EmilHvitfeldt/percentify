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
#' @importFrom rlang := ensym
#' @importFrom purrr map map2
#' @importFrom stats quantile
#' @importFrom dplyr new_grouped_df
#' @importFrom tidyr nest
percentify_cut <- function(tbl, var, q = numeric()) {
  percentify(tbl, {{var}}, lower = c(0, q), upper = c(q, 1))
}
