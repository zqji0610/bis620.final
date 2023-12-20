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

test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(enrollment_source_analysis(c('2000','2023')))
  }
)

test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(enrollment_duration_analysis(c('2000','2023')))
  }
)

test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(enrollment_phase_analysis(c('2000','2023')))
  }
)

test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(duration_regression_analysis(c('2000','2023')))
  }
)

test_that(
  "The plot_() errors when dates are not in '%Y-%m-%d' format.",
  {
    data(crc_sub)
    expect_error(status_classification(c('2000','2023')))
  }
)
