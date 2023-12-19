## code to prepare `DATASET` dataset goes here

accel = readRDS("data-raw/accel.rds")
crc = readRDS("data-raw/crc.rds")
crc_sub = readRDS("data-raw/crc_sub.rds")
# studies = readRDS("studies.rds")
# conditions = readRDS("conditions.rds")
# interventions = readRDS("interventions.rds")
# sponsors = readRDS("sponsors.rds")


usethis::use_data(accel, overwrite = TRUE)
usethis::use_data(crc, overwrite = TRUE)
usethis::use_data(crc_sub, overwrite = TRUE)
# usethis::use_data(studies, overwrite = TRUE)
# usethis::use_data(sponsors, overwrite = TRUE)
# usethis::use_data(interventions, overwrite = TRUE)
# usethis::use_data(conditions, overwrite = TRUE)
