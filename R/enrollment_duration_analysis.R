#' @title Statistical Analysis of Enrollment Across Trials with Duration of Study
#' @description This function performs a statistical analysis to explore the relationship between enrollment counts and study duration in colorectal cancer trials within a specified date range. The analysis includes ANOVA and the creation of a scatter plot for visualizing the relationship.
#' @param dates A list of two date values (lower and upper, respectively) defining the period for analysis.
#' @return Returns the results from the ANOVA analysis and a scatter plot showing the relationship between study duration and enrollment counts.
#' @importFrom dplyr filter mutate
#' @importFrom lubridate ymd
#' @importFrom stats aov
#' @importFrom ggplot2 ggplot aes geom_point theme_minimal theme element_text labs scale_y_continuous scale_color_gradient
#' @export

enrollment_duration_analysis <- function(dates=c('2000-01-01','2100-01-01')) {

  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |> filter(start_date >= start & start_date <= end)


  filtered_data <- crc_sub |>
    filter(!is.na(enrollment))

  filtered_data$enrollment <- as.numeric(filtered_data$enrollment)

  data <- filtered_data |>
    dplyr::mutate(start_date = lubridate::ymd(start_date),
           completion_date = lubridate::ymd(completion_date),
           study_time = as.numeric(difftime(completion_date, start_date, units = "days"))) |>
    filter(!is.na(study_time))

  #ANOVA
  anova_result <- aov(enrollment ~ study_time, data = data)
  print(summary(anova_result))



  # plot a scatter plot showing the distribution of enrollments over study duration
  ggplot2::ggplot(data, aes(x = study_time, y = enrollment)) +
    ggplot2::geom_point(aes(color = study_time), alpha = 0.6) +
    theme_minimal() +
    ggplot2::theme(text = ggplot2::element_text(size = 12),
          axis.text.x = ggplot2::element_text(angle = 45, hjust = 1),
          plot.title = ggplot2::element_text(hjust = 0.5, face = "bold", size = 16),
          legend.position = "right") +
    labs(title = "Enrollment vs Study Time",
         x = "Study Time (Days)",
         y = "Enrollment",
         caption = "Source: ClinicalTrials.gov") +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::scale_color_gradient(low = "blue", high = "red")

}
