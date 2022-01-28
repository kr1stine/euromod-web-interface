#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  i18n <- getShinyOption("i18n")

  tagList(
    tags$head(
      tags$title("Miinimumpalga tõusu mõju palgalõhele"),
      tags$link(type = "image/png", rel = "icon", href = "rege/ES_favicon.png"),
      shiny.i18n::usei18n(i18n)
    ),
    # ,
    fluidPage(
      theme = "rege/style.css",
      header(i18n),
      banner(i18n),
      sidebarLayout(
        sidebarPanel(mod_input_panel_ui("main_input", i18n)),
        mainPanel(mod_output_panel_ui("main_output", i18n))
      )
    ),
    tags$script(src = "rege/main.js")
  )
}

#' Header row containing site title and language switcher.
#' @param i18n {shiny.i18n} translator
#' @noRd
header <- function(i18n) {
  div(
    class = "container-fluid",
    id = "header",
    div(
      class = "row",
      column(4, i18n$t("Statistikaamet")),
      column(
        4,
        align = "right",
        offset = 4,
        actionLink("lang-et", "EST", class = "header-lang"),
        span("|", class = "header-lang"),
        actionLink("lang-en", "ENG", class = "header-lang")
      )
    )
  )
}

#' Banner row containing page graphics and title.
#' @param i18n translator from shiny.i18n
#' @noRd
banner <- function(i18n) {
  div(
    id = "banner",
    fluidRow(
      column(
        4,
        tags$a(
          img(
            src = "rege/ES_Logo.svg",
            height = 80,
            width = 200
          )
        )
      ),
      column(
        4,
        tags$h2(
          i18n$t("Miinimumpalga tõusu mõju palgalõhele")
        )
      ),
      column(4,
        tags$a(
          img(
            src = "rege/rege.jpg",
            height = 60,
            width = 150
          )
        ),
        align = "center"
      )
    )
  )
}
