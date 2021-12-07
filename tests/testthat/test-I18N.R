test_that("Reading a resource file", {
  resource_file <- system.file("testdata/simple_resource.csv", package = "rege")
  
  i18n <- I18NStrings$new(resource_file)
  
  langs <- i18n$get_langs()
  
  expect_equal(c("EE", "ENG"), langs)
})

test_that("Getting a string resource for a language", {
  resource_file <- system.file("testdata/simple_resource.csv", package = "rege")
  
  i18n <- I18NStrings$new(resource_file)
  
  i18n_en <- i18n$clone()
  
  i18n_en$set_lang("ENG")
  
  begin_en <- i18n_en$get_string_resource('BEGIN')
  begin_en_sr <- i18n_en$sr('BEGIN')
  
  expect_equal(begin_en, begin_en_sr)
  expect_equal("Hello", begin_en)
})
