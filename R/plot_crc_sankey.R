
#' @title Sankey plot of trial study types, intervention types, and phases
#' @description
#' Filters mCRC clinical trials within a given range of trial start date
#' and visualizes a Sankey diagram showing the distribution of study types stratified
#' by intervention types and phases
#' @param dates A list of two date values (lower and upper, respectively)
#' @return A Sankey (or Alluvial) plot showing the clinical trials distribution
#' @importFrom ggplot2 aes geom_text labs theme_void
#' @importFrom ggalluvial geom_alluvium geom_stratum
#' @importFrom dplyr filter group_by summarize
#' @export
plot_crc_sankey <- function(dates=c('2000-01-01','2100-01-01')) {
  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |>
    filter(start_date >= start & start_date <= end) |>
    group_by(study_type, intervention_type, phase)|>
    summarize(count = n() ) |>
    ggplot(aes(axis1 = study_type,   # First variable on the X-axis
               axis2 =  intervention_type, # Second variable on the X-axis
               axis3 = phase,   # Third variable on the X-axis
               y = count)) +
    geom_alluvium(aes(fill = intervention_type)) +
    geom_stratum() +
    geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
    labs(title=paste("Study, Intervention, & Phase Distribution from", dates[1], 'to', dates[2])) +
    theme_void()
}
