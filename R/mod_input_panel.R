#' input_panel UI Function
#'
#' @description A shiny Module.
#'
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_input_panel_ui <- function(id, i18n) {
  ns <- NS(id)
  tagList(
    i18n$t(
      "Rakendus ennustab miinimumpalga muutuse esmast mõju sotsiaalsetele näitajatele, eeldusel, et muud näitajad jäävad samaks."
    ),
    br(),
    numericInput(
      ns("min_wage"),
      tagList(
        i18n$t("Sisesta miinimumpalk (bruto)"),
        textOutput(ns("range"), inline = TRUE)
      ),
      600
    ),
    span(textOutput(ns("error"), inline = TRUE), class = "error"),
    selectInput(
      ns("year"),
      i18n$t("Rakendumise aasta"),
      c(2018, 2019, 2020)
    ),
    actionButton(ns("run"), i18n$t("Arvuta")),
  )
}

#' input_panel Server Functions
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @noRd
mod_input_panel_server <-
  function(input, output, session, i18n, input_limits) {
    ns <- session$ns

    err <- reactiveVal("")

    limits <-
      reactive(input_limits[input_limits$year == input$year, ])

    output$range <-
      renderText(sprintf("[%d,%d]", limits()$min, limits()$max))

    output$error <- renderText(i18n()$t(err()))

    observeEvent(input$min_wage, {
      err("")
    })

    app_inputs <- eventReactive(input$run,
      {
        valid <- limits()$max >= input$min_wage && limits()$min <= input$min_wage

        if (!valid) {
          err("Sisend väljaspool vahemikku")
        }

        req(valid)

        list("year" = input$year, "min_wage" = input$min_wage)
      },
      ignoreInit = TRUE
    )

    return(app_inputs)
  }
