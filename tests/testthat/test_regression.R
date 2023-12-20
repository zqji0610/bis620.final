
test_that("duration_regression_analysis prints model summary", {
  output <- capture.output(duration_regression_analysis())
  
  expect_true(any(grepl("Residuals", output)), 
              info = "The function should print the summary of the model.")
  
  expect_true(any(grepl("Coefficients", output)), 
              info = "The function should print the coefficients of the model.")
})
