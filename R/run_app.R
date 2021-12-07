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
  # translator <-
  #   shiny.i18n::Translator$new(translation_json_path = "inst/extdata/translation.json")
  # translator$set_translation_language("ee")
  # 
  # shinyOptions(i18n = translator)
  
  # Is this the right way to add this?
  #addResourcePath("deps", app_sys("app/www"))
  
  #resource_file <- system.file("inst/extdata/translation.csv", package = "rege")
  
  #i18n <- I18NStrings$new("inst/extdata/translation.csv")
  #i18n$set_lang('EN')
  
  router <- shiny.router::make_router(
    shiny.router::route("/", app_ui, app_server),
    shiny.router::route("en", app_ui, app_server)
    #shiny.router::route("en", i18n_app_ui(i18n), i18n_app_server(i18n))
  )
  
  server <- function(input, output, session) {
    #router$server(input, output, session)
  }
  ui <- function() {
    router$ui
  }
  shiny::shinyApp(
    ui = ui,
    server = router$server,
    onStart = onStart,
    #options = options,
    enableBookmarking = enableBookmarking,
    uiPattern = uiPattern
  )
}
