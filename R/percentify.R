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
#' library(broom)
#' percent_mtcars <- percentify_max(mtcars, mpg, c(0, 0.25, 0.5, 0.75))
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
  var <- ensym(var)

  p_format <- scales::percent_format()
  breaks_full <- paste(p_format(lower),
                       p_format(upper), sep = "-")

  cutoffs_lower <- quantile(data[[var]], lower)
  cutoffs_upper <- quantile(data[[var]], upper)

  name <- paste(key, var, sep = "_")

  new_grouped_df(
    data,
    groups = tibble(
      !!name := breaks_full,
      ".rows" := map2(cutoffs_lower, cutoffs_upper,
                      ~ which(data[[var]] >= .x & data[[var]] <= .y))),
    class = "percentiled_df"
  )
}
