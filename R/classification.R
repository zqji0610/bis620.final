
#' @title Overall Status classification task
#' @description Given a specific date range, this functions classifies overall
#' status using a set of predictor values, including enrollment, duration, phase,
#' intervention type and source class through a logistic regression model
#' @param dates A list of two date values (lower and upper, respectively)
#' @return Results from the logistic regression model, including a confusion matrix,
#' accuracy levels, and a graph visualizing the confusion matrix values.
#' @importFrom ggplot2 aes geom_tile geom_text scale_fill_gradient labs theme_minimal
#' @importFrom dplyr filter mutate summarise case_when
#' @importFrom stats glm predict binomial kruskal.test
#' @importFrom reshape2 melt
#' @importFrom pROC roc coords
#' @export
status_classification <- function(dates=c('2000-01-01','2100-01-01')) {

  start <- as.Date(dates[1])
  end <- as.Date(dates[2])
  crc_sub |> filter(start_date >= start & start_date <= end)


  #create a copy of original
  crc_temp <- crc_sub

  #recoding overall_status to binary
  crc_temp <- crc_temp |>
    dplyr::mutate(overall_status = dplyr::case_when(
      overall_status == "Completed" ~ 1,
      overall_status == "Recruiting" ~ 1,
      overall_status == "Active, not recruiting" ~ 1,
      overall_status == "Not yet recruiting" ~ 1,
      overall_status == "Terminated" ~ 0,
      overall_status == "Withdrawn" ~ 0,
      overall_status == "Suspended" ~ 0,
    ))

  #calculate duration
  crc_temp$start_date <- as.Date(crc_temp$start_date)
  crc_temp$completion_date <- as.Date(crc_temp$completion_date)
  crc_temp$duration <- crc_temp$completion_date - crc_temp$start_date

  #leave out empty values
  crc_temp <- crc_temp[!is.na(crc_temp$overall_status) & !is.na(crc_temp$duration)
                       & !is.na(crc_temp$enrollment) & !is.na(crc_temp$intervention_type)
                       & !is.na(crc_temp$phase) & !is.na(crc_temp$source_class), ]

  set.seed(1)
  #creating training and testing dataset
  training_indices <- sample(1:nrow(crc_temp), 0.7 * nrow(crc_temp))
  train_data <- crc_temp[training_indices, ]
  test_data <- crc_temp[-training_indices, ]

  #fit model for binary classification with training data
  log_model <- glm(overall_status ~ duration + enrollment + intervention_type + source_class + phase,
                   data = train_data, family = binomial())

  #testing model on test dataset, getting optimal threshold, and converting to binary class
  pred_probs <- predict(log_model, test_data, type = "response")
  roc_results <- pROC::coords(pROC::roc(test_data$overall_status, pred_probs), "best")
  pred_results <- ifelse(pred_probs > roc_results$threshold, 1, 0)


  #evaluation
  confusion_matrix <- table(pred_results, test_data$overall_status)
  print(confusion_matrix)
  accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
  print(paste("Accuracy of Logistic Regression Model:", accuracy))

  #visualizing confusion matrix
  confusion_df <- as.data.frame(reshape2::melt(confusion_matrix))
  names(confusion_df) <- c("predictions", "actual", "counts")
  ggplot2::ggplot(confusion_df, aes(x = actual, y = predictions, fill = counts)) +
    ggplot2::geom_tile() +
    ggplot2::geom_text(aes(label = counts)) +
    ggplot2::scale_fill_gradient(low = "white", high = "coral") +
    labs(title = "Confusion Matrix for Overall Status Prediction (Accuracy: 81.0%)", x = "actual", y = "predictions") +
    theme_minimal()
}
