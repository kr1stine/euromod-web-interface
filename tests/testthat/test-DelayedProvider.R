test_that("Providers have same method outputs", {
  cProvider <- ComputedProvider$new()
  
  dProvider <- DelayedProvider$new(0)
  
  limits <- cProvider$get_input_limits()
  expect_equal(limits, dProvider$get_input_limits())
  
  year <- sample(limits$year, 1)
  
  params <- limits[limits$year == year,]
  
  min_wage <- sample(params$min:params$max, 1)
  
  expect_equal(cProvider$compute(year, min_wage), dProvider$compute(year, min_wage))
})
