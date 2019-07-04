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
  var_text <- ensym(var)
  breaks <- c(0, q, 1)
  breaks_procent <- scales::percent_format()(breaks)
  breaks_full <-paste(breaks_procent[-length(breaks_procent)],
                      breaks_procent[-1], sep = "-")

  cuts <- cut(x = tbl[[var_text]],
              breaks = quantile(tbl[[var_text]], breaks),
              include.lowest = TRUE)


  name <- paste(".percentile", var_text, sep = "_")

  new_grouped_df(
    tbl,
    groups = tibble(
      !!name := breaks_full,
      ".rows" := map(levels(cuts), ~ which(cuts == .x))),
    class = "percentiled_df"
  )
}
