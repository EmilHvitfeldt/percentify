#' Evenly  divide the range 0 to 1 into n pieces
#'
#' This function work very well in combination with \code{\link{percentify_cut}}
#' to create evenly spaced intervals.
#'
#' @param n number of points
#'
#' @return numeric vector of length n-1.
#' @export
#'
#' @seealso [percentify_cut]
#'
#' @examples
#' cut_evenly(3)
#' cut_evenly(4)
#' cut_evenly(9)
#'
#' library(dplyr)
#'
#' # cut_evenly() is primarily used along with percentify_cut() to space the
#' # cuts easily.
#' percentify_cut(mtcars, mpg, cut_evenly(4)) %>%
#'   summarise(mean(wt))
cut_evenly <- function(n) {
  if (length(n) !=  1) {
    stop("`n` must be a single number.")
  }
  if (as.integer(n) != n) {
    stop("`n` must be an integer value.")
  }
  if (n < 2) {
    stop("`n` must be 2 or more.")
  }
  seq(0, 1, length.out = n + 1)[-c(1, n + 1)]
}
