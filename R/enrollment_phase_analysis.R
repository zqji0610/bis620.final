#' @title Statistical analysis of enrollment across trials with different phases
#' @description Given a specific date range, this functions explores the
#' differences in enrollment counts across different colorectal cancer trials
#' with different phases, by performing ANOVA and Tukey's Honest Significant
#' Difference (HSD) test for generating associated visualizations.
#' @param dates A list of two date values (lower and upper, respectively)
#' @return Results from the ANOVA and Tukey's HSD test, box plot showing the
#' enrollment distribution over phases, and 95% Family-Wise Confidence Level Plot.
#' @importFrom dplyr filter
#' @importFrom stats aov TukeyHSD
#' @importFrom ggplot2 aes geom_boxplot theme_minimal theme element_text labs scale_y_continuous
#' @importFrom scales comma
#' @export
#'
enrollment_phase_analysis <- function(dates=c('2000-01-01','2100-01-01')) {

  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |> filter(start_date >= start & start_date <= end)

  # Filter out rows with missing phase or enrollment information
  filtered_data <- crc_sub |>
    filter(!is.na(phase) & !is.na(enrollment))

  filtered_data$enrollment <- as.numeric(filtered_data$enrollment)

  # Perform ANOVA
  anova_result <- aov(enrollment ~ phase, data = filtered_data)
  print(summary(anova_result))

  tukey_result <- TukeyHSD(anova_result)
  plot(tukey_result)

  # plot a box plot showing the distribution of enrollments over phases
  ggplot2::ggplot(filtered_data, aes(x = phase, y = enrollment)) +
    ggplot2::geom_boxplot(outlier.colour = "red", outlier.shape = 8,
                 fill = "lightblue", colour = "darkblue", lwd = 0.75) +
    theme_minimal() +
    ggplot2::theme(text = ggplot2::element_text(size = 12),
          axis.text.x = ggplot2::element_text(angle = 45, hjust = 1),
          plot.title = ggplot2::element_text(hjust = 0.5, face = "bold", size = 16),
          legend.position = "none") +
    labs(title = "Enrollment Numbers by Clinical Trial Phase",
         x = "Phase",
         y = "Enrollment",
         caption = "Source: ClinicalTrials.gov") +
    ggplot2::scale_y_continuous(labels = scales::comma)

}
