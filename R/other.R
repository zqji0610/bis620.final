# library(shiny)
# library(duckdb)
# library(dplyr)
# library(ggplot2)
# library(ctrialsgov)
# library(gtsummary)
# if(require("ggalluvial")==F){install.packages("ggalluvial")}; library("ggalluvial")
#
# con = dbConnect(
#   duckdb(file.path("data-raw", "ctrialsgov.duckdb")
#   )
# )
# # dbListTables(con)
# studies = tbl(con, "studies")
# sponsors = tbl(con, "sponsors")
# conditions = tbl(con,"conditions")
# interventions = tbl(con, "interventions")
# outcome_analyses = tbl(con, 'outcome_analyses')
#
# ### define funciton
# rename_columns <- function(data, data_name, columns = c('id','name')) {
#   rename_with(
#     data,
#     ~ paste0(data_name, "_", .x, recycle0 = TRUE),
#     starts_with(columns)
#   )
# }
#
# sponsors <- rename_columns(sponsors, "sponsor")
# conditions <- rename_columns(conditions, "condition")
# interventions <- rename_columns(interventions, "intervention")
# View(crc |> head(10))
# # View(sponsors |> collect() |> head(10))
# # View(studies |> collect() |> head(10))
# # View(conditions |> collect() |> head(10))
# # View(interventions |> collect() |> head(10))
# # View(outcome_analyses |> collect() |> head(10))
#
#
# # get mCRC clinical trial ids
# crc_ids <- conditions |> collect() |>
#   select(nct_id, condition_id, condition_name) |>
#   filter(grepl("\\bmetastatic", condition_name, ignore.case = T) &
#            !grepl("non-metast", condition_name, ignore.case = T) &
#           grepl("colorectal cancer", condition_name, ignore.case = T) )
#
# # combine basic info and specific interventions applied
# crc_sub <-  crc_ids |>
#   left_join(as_tibble(interventions), by='nct_id') |>
#   left_join(as_tibble(studies), by='nct_id')
#   select(nct_id, condition_name, intervention_id, intervention_type, intervention_name,
#          description, start_date, completion_date, study_type, brief_title, official_title,
#          overall_status, phase, enrollment, why_stopped, source_class) |>
#   filter(!grepl("^Expand", study_type) &
#            !grepl("Behavioral|Dietary", intervention_type) &
#            !is.na(intervention_type) ) |>
#   mutate(study_type=replace(study_type, study_type=='Observational [Patient Registry]','Observational'))
#
# # main table
# crc <- crc_sub |>
#   select(-c(intervention_id, intervention_type, intervention_name, description)) |>
#   distinct()
# # save data
# saveRDS(crc, file = "data-raw/crc.rds")
# saveRDS(crc_sub, file = "data-raw/crc_sub.rds")
#
#
#
# ##### PLOT FUNCTIONS #####
#
# # intervention type
# crc_sub |>
#   filter(start_date >= as.Date('2022-01-01')) |>
#   count(intervention_type)
#
#
# start <- as.Date("2000-01-01")
# end <- as.Date("2024-01-01")
# summary_crc_table(start, end)
#
#
# View(crc_sub |>
#        mutate(start_date_yrmo = strftime(crc_sub$start_date, "%Y-%m")) |>
#        group_by(start_date_yrmo, intervention_type) |>
#        count(intervention_type))
#
# library(lubridate)
#
# ## Drug
#
# intervention_kwds_time_trend <- function(kwds, )
# crc_sub |>
#   mutate(start_date_mo = floor_date(start_date, "month")) |>
#   filter(
#     # intervention_type=='Drug' &
#     grepl('bev', description, ignore.case=T)   &
#     (!is.na(start_date_mo))) |>
#   group_by(start_date_mo) |>
#   mutate(count = n()) |>
#   ggplot(aes(x=start_date_mo, y=count)) +
#   geom_line() +
#   scale_x_date(breaks = "2 year", date_labels = '%Y')
#
# crc_sub |>
#   filter(grepl("FOLFOX.*pani|pani.*FOLFOX", description, ignore.case=T))
#
#
# crc |>
#   filter(grepl("radio", brief_title, ignore.case = T)) |>
#   mutate(start_date_mo = floor_date(start_date, "month")) |>
#   # filter(intervention_type=='Drug' & (!is.na(start_date_mo))) |>
#   group_by(start_date_mo) |>
#   summarize(count = n()) |>
#   # right_join(
#   #   data.frame(
#   #     start_date_mo = seq(
#   #       min(crc_drug$start_date_mo),
#   #       max(crc_drug$start_date_mo),
#   #       by = "month")
#   #   ), by = "start_date_mo") |>
#   # mutate(count = runner::fill_run(count, run_for_first = T))
#   ggplot(aes(x=start_date_mo, y=count)) +
#   geom_line() +
#   scale_x_date(breaks = "5 year", date_labels = '%Y')
#
#
# par(mfrow=c(1,2))
# acf(crc_drug$count)
# pacf(crc_drug$count)
#
# library(tseries)
# kpss.test(crc_drug$count, null = "Trend")
#
#
# # install.packages("forecast")
# library("forecast")
# drug.m <- auto.arima(crc_drug$count)
# bio.m <- auto.arima(crc_bio$count)
# checkresiduals(drug.m)
# checkresiduals(bio.m)
# plot(crc_drug$count, drug.m$fitted, main = "ARIMA regression model", xlab="Original", ylab="Fitted")
#
# autoplot(crc_drug$count)
# ts(1:10, frequency = 4, start = 1959) # 2nd Quarter of 1959
# dates <- ts(start = c(2000, 1), end =c(2024,1), frequency = 12)
#
