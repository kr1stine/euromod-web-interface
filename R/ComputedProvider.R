
#' Provider for precomputed results
#' @export
#' @importFrom dplyr %>% filter
ComputedProvider <- R6::R6Class(
  "ComputedProvider",
  public = list(
    get_input_limits = function(){
      values <- unique(income_poverty_taxes_benefits$year) %>%
        purrr::map( ~ dplyr::filter(income_poverty_taxes_benefits, year == .x)) %>%
        purrr::map(function(x) {
          mwage <- x$"min wage"
          c(x$year[1], min(mwage), max(mwage))
        })
      
      df <- as.data.frame(do.call(rbind, values))
      
      names(df) <- c("year", "min", "max")
      
      return(df)
    },
    
    compute = function(year, min_wage) {
      
      computed <-
        dplyr::filter(
          income_poverty_taxes_benefits,
          .data$year == .env$year,
          .data$"min wage" == .env$min_wage
        )
      
      hh <-
        filter(household_poverty,
                      .data$year == .env$year,
                      .data$"min wage" == .env$min_wage)
      
      df_hh_abs <- hh[c("household", "scenario", "absolute poverty")]
      df_hh_rel <- hh[c("household", "scenario", "relative poverty")]
      
      hh_abs <- list()
      
      for (household in unique(df_hh_abs$household)) {
        abs_hh <- dplyr::filter(df_hh_abs, .data$"household" == household)
        values <- abs_hh$"absolute poverty"
        hh_abs[[household]] <- list("actual" = values[1], "projected" = values[2])
      }
      
      hh_rel <- list()
      
      for (household in unique(df_hh_rel$household)) {
        rel_hh <- dplyr::filter(df_hh_rel, .data$"household" == household)
        values <- abs_hh$"absolute poverty"
        hh_rel[[household]] <- list("actual" = values[1], "projected" = values[2])
      }
      
      
      orig <- filter(original, .data$year == .env$year)
      
      return(list(
        "computed" = computed,
        "original" = orig,
        "household" = list("abs" = hh_abs, "rel" = hh_rel)
      ))
    }
  )
)