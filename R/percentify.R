#' Group a data.frame by percentile ranges in variable
#'
#' `percentify()` is the main function in percentify. It takes a data.frame or
#'  tibble, and creates groups based on the quantiles lower and upper bounds
#'  specified. This become handy once you start working with multiple
#'  overlapping bounds.
#'
#'  There is a [ggplot2::autoplot()] to visualize the the percentile ranges.
#'
#' @param data A data.frame or tibble,
#' @param var Variable to do grouping by as string or symbol.
#' @param lower Numerical values for lower bound of ranges. Must be between 0
#'     and 1. Length of lower and upper must be equal.
#' @param upper Numerical values for upper bound of ranges. Must be between 0
#'     and 1. Length of lower and upper must be equal.
#' @param key A single character specifying the name of the virtual group
#' that is added. Defaults to ".percentile".
#'
#' @return percentile grouped [tibble][tibble::tibble-package]
#' @export
#'
#' @family percentile samplers
#'
#' @examples
#' library(dplyr)
#' library(broom)
#' percent_mtcars <- percentify(mtcars, mpg,
#'                              lower = c(0.2, 0.4),
#'                              upper = c(0.6, 0.8)
#'                              )
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
#' library(ggplot2)
#' autoplot(percent_mtcars)
#' @importFrom rlang := ensym
#' @importFrom stats quantile
#' @importFrom dplyr new_grouped_df
#' @importFrom tidyr nest
percentify <- function(data, var, lower = 0, upper = 1, key = ".percentile") {
  if (any(lower < 0)) {
    stop("All values of `lower` much be greater than 0.")
  }
  if (any(upper > 1)) {
    stop("All values of `upper` much be lesser than 1.")
  }
  if (length(lower) != length(upper)) {
    stop("`lower` and `upper` must be the same length.")
  }
  if (any(lower > upper)) {
    stop("`lower` must be smaller then `upper`.")
  }

  UseMethod("percentify")
}

#' @export
percentify.data.frame <- function(data, var, lower, upper,
                                  key = ".percentile") {
  percentify(dplyr::as_tibble(data), {{var}}, lower, upper, key = key)
}

map2 <- function(.x, .y, .f, ...) {
  out <- mapply(.f, .x, .y, MoreArgs = list(...), SIMPLIFY = FALSE)
  if (length(out) == length(.x)) {
    rlang::set_names(out, names(.x))
  } else {
    rlang::set_names(out, NULL)
  }
}

#' @export
percentify.tbl_df <- function(data, var, lower, upper, key = ".percentile") {
  var <- ensym(var)

  breaks_full <- paste(p_format(lower, 100),
                       p_format(upper, 100), sep = "-")

  cutoffs_lower <- quantile(data[[var]], lower)
  cutoffs_upper <- quantile(data[[var]], upper)

  name <- paste(key, var, sep = "_")

  new_grouped_df(
    data,
    groups = tibble(
      !!name := breaks_full,
      ".rows" := map2(
        .x = cutoffs_lower,
        .y = cutoffs_upper,
        .f = function(.x, .y) {
          which_index(.x, .y, data, var)
        })
      ),
    class = "percentiled_df"
  )
}

which_index <- function(x, y, data, var) {
  which(data[[var]] >= x & data[[var]] <= y)
}
