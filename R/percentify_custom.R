#' Title
#'
#' @param tbl data.frame or tibble
#' @param var a variable
#' @param lower numeric
#' @param upper numeric
#'
#'
#' @return percentile grouped tibble
#' @export
#'
#' @examples
#' library(dplyr)
#' cut_mtcars <- percentify_custom(mtcars, mpg, c(0, 0.1, 0.5), c(1, 0.6, 0.7))
#'
#' summarize(cut_mtcars,
#'           mean_hp = mean(hp),
#'           mean_wt = mean(wt),
#'           n_obs = n()
#'           )
percentify_custom <- function(tbl, var, lower = 0, upper = 1) {
  var_text <- ensym(var)
  p_format <- scales::percent_format()
  breaks_full <-paste(p_format(lower),
                      p_format(upper), sep = "-")

  cutoffs_lower <- quantile(tbl[[var_text]], lower)
  cutoffs_upper <- quantile(tbl[[var_text]], upper)

  name <- paste(".percentile", var_text, sep = "_")

  new_grouped_df(
    tbl,
    groups = tibble(
      !!name := breaks_full,
      ".rows" := map2(cutoffs_lower, cutoffs_upper,
                      ~ which(tbl[[var_text]] >= .x & tbl[[var_text]] <= .y)))
  )
}
