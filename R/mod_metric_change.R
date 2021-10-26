#' metric_change UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_metric_change_ui <- function(id, title, description) {
  ns <- NS(id)
  fluidRow(
    column(8, mod_metric_description_ui(ns("description"), title, description)),
    column(
      4,
      align = "center",
      mod_metric_ui(ns("old")),
      uiOutput(ns("arrow")),
      mod_metric_ui(ns("new"))
    )
  )
}

#' metric_change Server Functions
#'
#' @noRd
mod_metric_change_server <-
  function(id,
           old_value,
           new_value,
           desc_tt = reactive(NULL),
           old_tt = reactive(NULL),
           new_tt = reactive(NULL),
           more_is_positive = FALSE) {
    moduleServer(id, function(input, output, session) {
      ns <- session$ns
      
      output$arrow <- renderUI({
        nv <- new_value()
        ov <- old_value()
        
        color = if (nv > ov && more_is_positive || nv < ov && !more_is_positive)
            "rgb(0,166,90)"
          else if (nv == ov)
            "black"
          else
            "red"
        
        icon("arrow-down", style = sprintf("color: %s", color))
      })
      
      mod_metric_description_server("decription", desc_tt)
      
      mod_metric_server("old", old_value, old_tt)
      
      mod_metric_server("new", new_value, new_tt)
    })
  }
