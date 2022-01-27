
test_that("get_input_limits() returns the proper limits format", {
  provider <- ComputedProvider$new()

  actual <- provider$get_input_limits()

  expected_names <- c("year", "min", "max")

  expect_equal(names(actual), expected_names)

  expected_names %>% purrr::map(function(x) expect_type(actual[[x]], "integer"))
})


test_that("compute returns the proper data format", {
  provider <- ComputedProvider$new()

  computed <- provider$compute(2018, 600)

  expect_named(computed$household, c("abs", "rel"))

  for (x in computed$household) {
    expect_length(x, 7)
    for (scenario in x) {
      expect_named(scenario, c("actual", "projected"))
    }
  }
})
