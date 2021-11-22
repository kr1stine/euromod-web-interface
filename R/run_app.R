#' Run the Shiny Application
#'
#' @param ... arguments to pass to golem_opts.
#' See `?golem::get_golem_options` for more details.
#' @inheritParams shiny::shinyApp
#'
#' @export
run_app <- function(onStart = NULL,
                    options = list(),
                    enableBookmarking = NULL,
                    uiPattern = "/",
                    ...) {
  translator <-
    shiny.i18n::Translator$new(translation_json_path = "inst/extdata/translation.json")
  translator$set_translation_language("ee")
  
  shinyOptions(i18n = translator)
  
  shiny::shinyApp(
    ui = app_ui,
    server = app_server,
    onStart = onStart,
    #options = options,
    enableBookmarking = enableBookmarking,
    uiPattern = uiPattern
  )
}
