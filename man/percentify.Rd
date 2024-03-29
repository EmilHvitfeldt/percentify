% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/autoplot.R, R/percentify.R
\name{autoplot.percentiled_df}
\alias{autoplot.percentiled_df}
\alias{percentify}
\title{Group a data.frame by percentile ranges in variable}
\usage{
autoplot.percentiled_df(object)

percentify(data, var, lower = 0, upper = 1, key = ".percentile")
}
\arguments{
\item{object}{The \code{percentiled_df} data frame returned from  any percentify
functions.}

\item{data}{A data.frame or tibble,}

\item{var}{Variable to do grouping by as string or symbol.}

\item{lower}{Numerical values for lower bound of ranges. Must be between 0
and 1. Length of lower and upper must be equal.}

\item{upper}{Numerical values for upper bound of ranges. Must be between 0
and 1. Length of lower and upper must be equal.}

\item{key}{A single character specifying the name of the virtual group
that is added. Defaults to ".percentile".}
}
\value{
percentile grouped \link[tibble:tibble-package]{tibble}
}
\description{
\code{percentify()} is the main function in percentify. It takes a data.frame or
tibble, and creates groups based on the quantiles lower and upper bounds
specified. This become handy once you start working with multiple
overlapping bounds.
}
\details{
There is a \code{\link[ggplot2:autoplot]{ggplot2::autoplot()}} to visualize the the percentile ranges.
}
\examples{
library(dplyr)
library(broom)
percent_mtcars <- percentify(mtcars, mpg,
                             lower = c(0.2, 0.4),
                             upper = c(0.6, 0.8)
                             )

percent_mtcars

summarize(percent_mtcars,
          mean_hp = mean(hp),
          mean_wt = mean(wt),
          n_obs = n()
          )

percent_mtcars \%>\%
  group_modify(~tidy(lm(disp ~ wt + cyl, data = .x)))

library(ggplot2)
autoplot(percent_mtcars)
}
\seealso{
Other percentile samplers: \code{\link{percentify_cut}},
  \code{\link{percentify_max}},
  \code{\link{percentify_min}},
  \code{\link{percentify_random}}
}
\concept{percentile samplers}
