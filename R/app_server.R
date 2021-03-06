#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  provider <- ComputedProvider$new()

  lang <- reactiveVal("ee")

  observeEvent(input$"lang-en", ignoreInit = TRUE, {
    shiny.i18n::update_lang(session, "en")
    lang("en")
  })

  observeEvent(input$"lang-et", ignoreInit = TRUE, {
    shiny.i18n::update_lang(session, "ee")
    lang("ee")
  })

  translator <- getShinyOption("i18n")

  i18n <- reactive({
    translator$set_translation_language(lang())
    translator
  })

  limits <- provider$get_input_limits()

  app_inputs <- callModule(mod_input_panel_server, "main_input", i18n, limits)

  observeEvent(app_inputs, {
    message("App Inputs", app_inputs())
  })

  results <- reactive({
    app_inputs() # NEED to draw this dependency so the inputs don't compute with NULL
    provider$compute(app_inputs()$year, app_inputs()$min_wage)
  })

  callModule(mod_output_panel_server, "main_output", i18n, results)
}
