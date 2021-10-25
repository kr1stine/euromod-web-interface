#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  i18n <- golem::get_golem_options("i18n")
  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(i18n),
    fluidPage(
      titlePanel(
        i18n$t("Miinimumpalga tõusu mõju palgalõhele"),
        # Translated window title in server
        "Miinimumpalga tõusu mõju palgalõhele" 
      ),
      # Fake tooltip so shinyBS server functions work
      shinyBS::bsTooltip("tt", "tt"), 
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

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(i18n){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  # shinyBS attach workaround from https://github.com/ThinkR-open/golem/issues/297
  add_resource_path(
    "sbs", system.file("www", package = "shinyBS")
  )

  tags$head(
    favicon(),
    # bundle_resources(
    #   path = app_sys('app/www'),
    #   app_title = "Not used"
    # ),
    #HTML("<title>Just checking</title>"),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    shinyjs::useShinyjs(),
    shiny.i18n::usei18n(i18n)
  )
}

