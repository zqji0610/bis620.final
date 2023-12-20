#' Function that queries the `crc_sub` table using a keyword/a list of keyword strings
#'
#' @param kwds A string / list of strings. The query keyword(s)
#' @param column A quosure (a string enclosed in `quo()`). The column to be filtered upon.
#' @param ignore_case A Boolean, default TRUE. Specify whether the query is case-insensitive
#' @param match_all A Boolean, default FALSE. Specify whether the query
#' requires the column value to match all the kwds or just one of them
#' @return A table with filtered entries
#' @importFrom dplyr filter
#' @export
query_kwds <- function(kwds, column, ignore.case = TRUE, match_all = FALSE) {
  if(match_all) {
    pattern <- paste0(paste0(kwds,collapse=".*"), "|",
                      paste0(rev(kwds),collapse='.*'))[1]
  } else {
    pattern <- paste0(kwds, collapse = "|")
  }
  crc_sub |>
    filter(grepl(pattern, !!column, ignore.case))
}

#' Function that query the clinical trial table and plots the number of trials
#' matching the given keywords over time.
#'
#' @param kwds A string / list of strings. The query keyword(s)
#' @param column A quosure (a string enclosed in `quo()`). The column to be filtered upon.
#' @param ignore_case A Boolean, default TRUE. Specify whether the query is case-insensitive
#' @param match_all A Boolean, default FALSE. Specify whether the query
#' requires the column value to match all the kwds or just one of them
#' @return a line plot showing the count of queried clinical trials over time
#' @importFrom dplyr filter mutate group_by
#' @importFrom ggplot2 geom_line scale_x_date labs
plot_query_time_trend <- function(kwds, column, ignore.case = TRUE, match_all = FALSE) {
   query_kwds(kwds, column, ignore.case, match_all) |>
    mutate(start_date_mo = lubridate::floor_date(start_date, "month")) |>
    filter(!is.na(start_date_mo)) |>
    group_by(start_date_mo) |>
    mutate(count = n()) |>
    ggplot(aes(x=start_date_mo, y=count)) +
    geom_line() +
    labs(x='start date') +
    scale_x_date(breaks = "2 year", date_labels = '%Y')
}
