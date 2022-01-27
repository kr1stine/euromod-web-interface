#' metric_change UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_desc_metric_change_ui <- function(id, title, description) {
  ns <- NS(id)
  fluidRow(
    column(8, div(
      strong(title),
      p(description, uiOutput(ns("tooltip"), inline = TRUE))
    )),
    column(
      4,
      align = "center",
      mod_metric_change_ui(ns("values"))
    )
  )
}

#' metric_change Server Functions
#'
#' @noRd
mod_desc_metric_change_server <-
  function(input,
           output,
           session,
           old_value,
           new_value,
           desc_tt = reactive(""),
           old_tt = reactive(""),
           new_tt = reactive(""),
           more_is_positive = FALSE) {
    ns <- session$ns

    output$tooltip <- renderUI({
      tt <- desc_tt()
      if (tt == "") {
        span()
      } else {
        span(
          "data-toggle" = "tooltip",
          "title" = tt,
          icon("question-circle", "far", "font-awesome")
        )
      }
    })

    callModule(mod_metric_change_server, "values", old_value, new_value, old_tt, new_tt)
  }
