#' metric UI Function
#'
#' @description A shiny Module.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_metric_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("tooltiped"))
}

#' metric Server Functions
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param metric reactive numeric to be formatted and displayed.
#' @param tooltip reactive string to be displayed as a bootstrap tooltip.
mod_metric_server <-
  function(input, output, session, metric, tooltip = reactive("")) {
    ns <- session$ns

    output$tooltiped <- renderUI({
      span(
        "data-toggle" = "tooltip",
        "data-placement" = "top",
        "title" = tooltip(),
        sprintf("%.2f%%", metric())
      )
    })
  }
