test_that("metric_description server inserts a tooltip when provided one", {
  testServer(mod_metric_description_server, args = list(), {
    
    cat("Output is ", output$tooltip)
  })
})
