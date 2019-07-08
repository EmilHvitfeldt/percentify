#' @rdname percentify
#' @param object The `percentiled_df` data frame returned from  any percentify
#' functions.
#' @export
autoplot.percentiled_df <- function(object) {
  ranges <- dplyr::group_data(object)[[1]]
  ranges_string <- strsplit(gsub("%", "", ranges), "-")

  left <- sapply(ranges_string, function(x) as.numeric(x[1]))
  right <- sapply(ranges_string, function(x) as.numeric(x[2]))

  ymin <- seq_along(ranges) - 0.4
  ymax <- seq_along(ranges) + 0.4

  data <- tibble(left = left,
                 right = right,
                 ymin = ymin,
                 ymax = ymax)
  ggplot2::ggplot(data) +
    ggplot2::geom_rect(ggplot2::aes(xmin = left, xmax = right,
                                    ymin = ymin, ymax = ymax),
                       inherit.aes = FALSE) +
    ggplot2::theme_minimal() +
    ggplot2::scale_y_continuous(breaks = seq_along(ranges),
                                labels = ranges, minor_breaks = NULL) +
    ggplot2::scale_x_continuous(labels = p_format,
                                limits = c(0, 100))
}
