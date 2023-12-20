test_that("plot_qeury_time_trend() works", {
  data(crc_sub)
  vdiffr::expect_doppelganger(
    "plot_drug_time_trend",
    plot_query_time_trend('drug', dplyr::quo(intervention_type))
  )
})


