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
  var_text <- ensym(var)
  breaks <- c(q, 1)
  breaks_procent <- scales::percent_format()(c(lower, breaks))
  breaks_full <-paste(breaks_procent[1],
                      breaks_procent[-1], sep = "-")

  cutoffs <- quantile(tbl[[var_text]], breaks)
  min_cutoffs <- quantile(tbl[[var_text]], lower)

  name <- paste(".percentile", var_text, sep = "_")

  new_grouped_df(
    tbl,
    groups = tibble(
      !!name := breaks_full,
      ".rows" := map(cutoffs, ~ which(tbl[[var_text]] >= min_cutoffs & tbl[[var_text]] <= .x))),
    class = "percentiled_df"
  )
}
