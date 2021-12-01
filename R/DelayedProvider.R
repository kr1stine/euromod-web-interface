#' Delayed provider
#' @export
DelayedProvider <- R6::R6Class(
  public = list(
    #' Creates a new delayed provider
    #' @param delay integer, computation delay in seconds
    initialize = function(delay = 5) {
      private$provider <- ComputedProvider$new()
      private$delay <- delay
    },
    get_input_limits = function(){
      Sys.sleep(private$delay)
      private$provider$get_input_limits()
    },
    compute = function(year, min_wage) {
      Sys.sleep(private$delay)
      private$provider$compute(year, min_wage)
    }
  ),
  private = list(
    provider  = NULL,
    delay = 5
  )
)