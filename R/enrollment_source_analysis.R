
#' @title Statistical analysis of enrollment across trials with different source classes
#' @description Given a specific date range, this functions explores the
#' differences in enrollment counts across different colorectal cancer trials
#' with different source classes, by performing ANOVA and Kruskal-Wallis and
#' generating associated visualizations.
#' @param dates A list of two date values (lower and upper, respectively)
#' @return Results from the ANOVA and Kruskal-Wallis test, enrollment distribution
#' histogram, and barp lot showing mean enrollment counts across different source classes
#' @importFrom ggplot2 aes geom_histogram geom_bar labs theme
#' @importFrom dplyr filter group_by summarize
#' @export
enrollment_source_analysis <- function(dates=c('2000-01-01','2100-01-01')) {

  dates=c('2000-01-01','2100-01-01')
  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |> filter(start_date >= start & start_date <= end)

  #leave out empty values
  crc_temp <- crc_sub[!is.na(crc_sub$source_class) & !is.na(crc_sub$enrollment), ]

  #histogram providing overview of enrollment counts
  enroll_hist <- ggplot2::ggplot(crc_temp, aes(x = enrollment)) +
    geom_histogram(binwidth = 10, fill = "blue", alpha = 0.7) +
    labs(title = "Enrollment Distribution",
         x = "Enrollment",
         y = "Frequency")
  print(enroll_hist)

  #anova analysis
  aov_result <- aov(enrollment ~ source_class, data = crc_temp)
  print(summary(aov_result))

  #kruskal-wallis test
  kruskal_result <- kruskal.test(enrollment ~ source_class, data = crc_temp)
  print(kruskal_result)

  #mean enrollment counts by different source classes
  crc_temp |>
    group_by(source_class) |>
    summarize(mean_enrollment = mean(enrollment, na.rm = TRUE)) |>
    ggplot2::ggplot(aes(x = source_class, y = mean_enrollment)) +
    ggplot2::geom_bar(stat = "identity", fill = "coral") +
    labs(title = "Mean Enrollment by Source Class",
         x = "Source Class",
         y = "Mean Enrollment")
}
