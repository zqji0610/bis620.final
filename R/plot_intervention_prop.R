#' @title Proportions of differnt intervention types over time
#' @description Filters mCRC clinical trials within a given range of trial start date
#' and plots a density plot showing the proportion of each intervention type over time
#' @param dates A list of two date values (lower and upper, respectively)
#' @return A density plot showing the proportion of intervention types vs. time
#' @importFrom ggplot2 aes geom_density scale_x_date labs theme_minimal
#' @importFrom dplyr filter
plot_intervention_proportion_time <- function(dates=c('2000-01-01','2100-01-01')) {
  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |>
    filter(start_date >= start & start_date <= end) |>
    ggplot(aes(start_date, after_stat(count),
               color=intervention_type, fill=intervention_type)) +
    geom_density(position = "fill", alpha=0.8) +
    labs(x='start date', y='density') +
    scale_x_date(date_breaks = '5 year', date_labels = "%Y") +
    theme_minimal()
}
