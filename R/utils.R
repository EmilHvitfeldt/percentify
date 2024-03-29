check_empty_dots <- function(...) {
  dots <- rlang::enquos(...)

  dots_are_empty <- length(dots) == 0L

  if (!dots_are_empty) {
    rlang::abort("`...` must be empty.")
  }

  invisible()
}

p_format <- function(x, scale = 1) paste0(round(x * scale, digits = 1), "%")
