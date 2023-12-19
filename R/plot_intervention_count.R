#' @title Histogram of different intervention types over time
#' @description
#' Filters mCRC clinical trials within a given range of trial start date
#' and plots a histogram showing the number of each intervention type over time
#' @param dates A list of two date values (lower and upper, respectively)
#' @return A histogram showing the number of intervention types vs. time
#' @importFrom ggplot2 aes geom_histogram labs scale_x_date theme_minimal
#' @importFrom dplyr filter
#' @export
plot_intervention_count_time <- function(dates=c('2000-01-01','2100-01-01')) {
  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |>
    filter(start_date >= start & start_date <= end) |>
    ggplot(aes(start_date, fill=intervention_type)) +
    geom_histogram(position = "stack", bins = 50) +
    labs(x='start date') +
    scale_x_date(date_breaks = '5 year', date_labels = "%Y") +
    theme_minimal()
}
