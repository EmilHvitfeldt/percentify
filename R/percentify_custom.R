#' Title
#'
#' @param data data.frame or tibble
#' @param var a variable
#' @param lower numeric
#' @param upper numeric
#' @param key A single character specifying the name of the virtual group
#' that is added. Defaults to ".percentile".
#'
#'
#' @return percentile grouped tibble
#' @export
#'
#' @examples
#' library(dplyr)
#' cut_mtcars <- percentify(mtcars, mpg, c(0, 0.1, 0.5), c(1, 0.6, 0.7))
#'
#' summarize(cut_mtcars,
#'           mean_hp = mean(hp),
#'           mean_wt = mean(wt),
#'           n_obs = n()
#'           )
percentify <- function(data, var, lower = 0, upper = 1, key = ".percentile") {
  UseMethod("percentify")
}

#' @export
percentify.data.frame <- function(data, var, lower, upper,
                                  key = ".percentile") {
  percentify(dplyr::as_tibble(data), {{var}}, lower, upper, key = key)
}

#' @export
percentify.tbl_df <- function(data, var, lower, upper, key = ".percentile") {
  var_text <- ensym(var)

  p_format <- scales::percent_format()
  breaks_full <-paste(p_format(lower),
                      p_format(upper), sep = "-")

  cutoffs_lower <- quantile(data[[var_text]], lower)
  cutoffs_upper <- quantile(data[[var_text]], upper)

  name <- paste(".percentile", var_text, sep = "_")

  new_grouped_df(
    data,
    groups = tibble(
      !!name := breaks_full,
      ".rows" := map2(cutoffs_lower, cutoffs_upper,
                      ~ which(data[[var_text]] >= .x & data[[var_text]] <= .y)))
  )
}
