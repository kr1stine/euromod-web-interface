#' metric_description UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_metric_description_ui <- function(id, title, description) {
  ns <- NS(id)
  div(strong(title),
      p(description),
      uiOutput(ns("tooltip")))
}
    
#' metric_description Server Functions
#'
#' @noRd 
mod_metric_description_server <- function(id, tooltip = reactive(NULL)){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    output$tooltip <- renderUI({
      
      tt <- tooltip
      if (is.null(tt)) {
        span("Empty")
      } else {
        span(
          span(
            id = ns("info"), icon("question-circle", "far", "font-awesome")
          ),
          shinyBS::bsTooltip(id = ns("info"), title = tt)
        )
        
      }
    })
  })
}