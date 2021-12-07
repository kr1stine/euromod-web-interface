
I18NStrings <- R6::R6Class(
  "I18NStrings",
  public = list(
    initialize = function(resource_file) {
      private$resource <- read.csv(resource_file)
      private$lang <-  names(private$resource)[2]
    },
    get_langs = function() {
      nn <- names(private$resource)
      l <- length(nn)
      return(nn[2:l])
    },
    set_lang = function(lang) {
      private$lang <- lang
    },
    get_string_resource = function(key) {
      dplyr::filter(private$resource, .data$"I18N" == key)[[private$lang]]
    },
    sr = function(key) self$get_string_resource(key),
    t = function(key) self$get_string_resource(key)
  ),
  private = list(
    resource = NULL,
    lang = NULL
  )
)

