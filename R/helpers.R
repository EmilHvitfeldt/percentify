#' Evenly space n points between 0 and 1
#'
#' @param n number of points
#'
#' @return numeric vector
#' @export
#'
#' @examples
#' even_spaced(3)
#' even_spaced(4)
#' even_spaced(9)
even_spaced <- function(n) {
  if (length(n) !=  1) {
    stop("`n` must be a single number.")
  }
  seq(0, 1, length.out = n + 2)[-c(1, n + 2)]
}
