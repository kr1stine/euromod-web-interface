#' Provider for pre-computed results
#' @export
ComputedProvider <- R6::R6Class(
  "ComputedProvider",
  public = list(
    #' @description
    #' Get input limits
    #' @importFrom dplyr %>% filter
    #' @importFrom purrr map
    #' @return dataframe of (year, min, max)
    get_input_limits = function(){
      values <- unique(income_poverty_taxes_benefits$year) %>%
        map( ~ filter(income_poverty_taxes_benefits, year == .x)) %>%
        map(function(x) {
          mwage <- x$"min wage"
          c(x$year[1], min(mwage), max(mwage))
        })
      
      df <- as.data.frame(do.call(rbind, values))
      
      names(df) <- c("year", "min", "max")
      
      return(df)
    },
    #' @description
    #' Return the pre-computed values
    #' @param year singular numeric
    #' @param min_wage singular numeric
    compute = function(year, min_wage) {
      
      computed <-
        dplyr::filter(
          income_poverty_taxes_benefits,
          .data$year == .env$year,
          .data$"min wage" == .env$min_wage
        )
      
      hh <-
        dplyr::filter(household_poverty,
                      .data$year == .env$year,
                      .data$"min wage" == .env$min_wage)
      
      orig <- dplyr::filter(original, .data$year == .env$year)
      
      return(list(
        "computed" = computed,
        "original" = orig,
        "household" = hh
      ))
    }
  )
)