#' metric_description UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_metric_description_ui <- function(id, title, description){
  ns <- NS(id)
  div(
    strong(title),
    p(description, uiOutput(ns("tooltip"), inline = TRUE))
  )
}
    
#' metric_description Server Functions
#'
#' @noRd 
mod_metric_description_server <- function(input, output, session, tooltip = reactive("")){
    ns <- session$ns
 
    output$tooltip <- renderUI({
      tt = tooltip()
      if (tt == "") {
       span()
      } else {
       span("data-toggle" = "tooltip",
            "title" = tt,
            icon("question-circle", "far", "font-awesome"))
      }
    })
}