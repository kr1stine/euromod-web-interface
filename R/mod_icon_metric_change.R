mod_icon_metric_change_ui <- function(id, title, ic) {
  ns <- NS(id)
  fluidRow(
    column(8, span(title)),
    column(4, mod_metric_change_ui(ns("values")))
  )
}

mod_icon_metric_change_server <-
  function(input,
           output,
           session,
           old_value,
           new_value) {
    ns <- session$ns

    callModule(mod_metric_change_server, "values", old_value, new_value)
  }
