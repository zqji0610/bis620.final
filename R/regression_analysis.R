#' @title Regression Analysis of Study Duration
#' @description This function performs regression analysis on the duration of studies, considering factors such as enrollment, source class, and phase. The analysis includes the removal of outliers based on Cook's distance, and is conducted within a specified date range.
#' @param dates A list of two date values (start and end date, respectively) to define the period for analysis.
#' @return The function returns the results from the regression analysis, diagnostic plots to assess the model, and a plot comparing
#' actual vs predicted values of study duration.
#' @importFrom dplyr filter mutate
#' @importFrom lubridate ymd
#' @importFrom stats lm cooks.distance
#' @importFrom ggplot2 ggplot aes geom_point geom_abline theme_minimal theme element_text labs
#' @export

duration_regression_analysis <- function(dates=c('2000-01-01','2100-01-01')) {

  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |> filter(start_date >= start & start_date <= end)

  # Filter out rows with missing phase or enrollment information
  filtered_data <- crc_sub |>
    filter(!is.na(phase)  & !is.na(source_class) & !is.na(enrollment))


  data <- filtered_data |>
    dplyr::mutate(start_date = lubridate::ymd(start_date),
           completion_date = lubridate::ymd(completion_date),
           study_time = as.numeric(difftime(completion_date, start_date, units = "days")),
           phase = as.factor(phase),
           source_class = as.factor(source_class)) |>
    filter(!is.na(study_time))


  lm_model <- lm(study_time ~ phase + enrollment + source_class, data = data)

  #remove Outliers based on Cook's distance
  cooksd <- cooks.distance(lm_model)

  #remove the data points that have a Cook's distance greater than the threshold 4/n
  influential_points <- which(cooksd > (4/length(cooksd)))
  data_no_outliers <- data[-influential_points, ]

  lm_model_no_outliers <- lm(study_time ~ phase + enrollment + source_class, data = data_no_outliers)
  print(summary(lm_model_no_outliers))


  par(mfrow = c(2, 2))
  plot(lm_model_no_outliers)


  data_no_outliers$predicted <- predict(lm_model_no_outliers, data_no_outliers)
  ggplot2::ggplot(data_no_outliers, aes(x = study_time, y = predicted)) +
    ggplot2::geom_point(aes(color = source_class)) +
    ggplot2::geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
    theme_minimal() +
    ggplot2::theme(text = ggplot2::element_text(size = 12),
          axis.text.x = ggplot2::element_text(angle = 45, hjust = 1),
          plot.title = ggplot2::element_text(hjust = 0.5, face = "bold", size = 16)) +
    labs(title = "Predicted vs Actual Values",
         x = "Actual Values",
         y = "Predicted Values")
}
