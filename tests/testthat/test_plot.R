test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(plot_crc_sankey(c('2000','2023')))
  }
)

test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(plot_intervention_count_time(c('2000','2023')))
  }
)


test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(plot_intervention_proportion_time(c('2000','2023')))
  }
)
