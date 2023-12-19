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
#
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
# crc_drug <- crc_sub |>
#   mutate(start_date_mo = floor_date(start_date, "month")) |>
#   group_by(start_date_mo, intervention_type) |>
#   summarize(count = n()) |>
#   filter(intervention_type=='Drug')
# crc_drug |>
#   ggplot(aes(x=start_date_mo, y=count)) +
#   geom_point() + geom_line()
#
# acf(crc_drug$count)
