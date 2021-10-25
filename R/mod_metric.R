#' metric UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_metric_ui <- function(id){
  ns <- NS(id)
  uiOutput(ns("value"))
}
    
#' metric Server Functions
#'
#' @noRd 
mod_metric_server <- function(id, metric, tooltip = reactive(NULL)){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    output$value <- renderUI({
      t <- tooltip()
      
      div(
        span(id = ns("v"), sprintf("%.2f%%", metric())),
        if (is.null(t)) span() else shinyBS::bsTooltip(ns("v"), t)
      )
    })
  })
}
