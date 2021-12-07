#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  i18n <- getShinyOption("i18n")
  
  tagList(
    add_external_resources(i18n),
    fluidPage(
      theme = "deps/brand.stat.ee.css",
      #theme = "deps/lux.bootswatch.css",
      titlePanel(i18n$t("Miinimumpalga tõusu mõju palgalõhele")),
      
      column(
        2,
        offset = 10,
        selectInput(
          "selector",
          label = NULL,
          choices = list("Eesti keel" = "ee",
                         "In English" = "en"),
          selected = i18n$get_key_translation()
        )
      ),
      sidebarLayout(
        sidebarPanel(mod_input_panel_ui("main_input", i18n)),
        mainPanel(mod_output_panel_ui("main_output", i18n))
      )
    )
  )
}

i18n_app_ui <- function(i18n) {
  function() {
    tagList(
      fluidPage(
        theme = "deps/brand.stat.ee.css",
        titlePanel(i18n$sr('TITLE'))
      ))
  }
}


#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @noRd
add_external_resources <- function(i18n) {
  #
  # golem::add_resource_path(
  #   'www', app_sys('app/www')
  # )
  
  tags$head(# bundle_resources(
    #htmltools::htmlDependency('rege', '0.0.9000', app_sys('app/www'), package = "rege"),
    #   path = app_sys('app/www'),
    #   app_title = "Not used"
    # ),
    #HTML("<title>Just checking</title>"),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    #shinyjs::useShinyjs(),
    shiny.i18n::usei18n(i18n))
}
