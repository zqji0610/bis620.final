test_that("status_classification prints a confusion matrix and accuracy", {
  output <- capture.output(status_classification())

  expect_true(any(grepl("Accuracy of Logistic Regression Model", output)), 
              info = "The function should print the accuracy of the model.")
})
