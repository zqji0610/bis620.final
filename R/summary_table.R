
#' @title Summary table of clinical study types, intervention types, and phases
#' @description
#' Filters mCRC clinical trials within a given range of trial start date
#' and creates a summary table showing the distribution of study types stratified
#' by intervention types and phases
#' @param dates A list of two date values (lower and upper, respectively)
#' @return A summary table showing the clinical trials distribution
#' @importFrom dplyr filter select
#' @importFrom gtsummary tbl_summary
#' @export
summarize_crc_table <- function(dates=c('2000-01-01','2100-01-01')) {
  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |>
    filter(start_date >= start & start_date <= end) |>
    select(intervention_type, phase, study_type) |>
    tbl_summary(by = study_type)
}
