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
  var_text <- ensym(var)
  breaks <- c(0, q)
  breaks_procent <- scales::percent_format()(c(upper, breaks))
  breaks_full <-paste(breaks_procent[-1],
                      breaks_procent[1], sep = "-")

  cutoffs <- quantile(tbl[[var_text]], breaks)
  max_cutoffs <- quantile(tbl[[var_text]], upper)

  name <- paste(".percentile", var_text, sep = "_")

  new_grouped_df(
    tbl,
    groups = tibble(
      !!name := breaks_full,
      ".rows" := map(cutoffs, ~ which(tbl[[var_text]] <= max_cutoffs & tbl[[var_text]] >= .x))),
    class = "percentiled_df"
  )
}
