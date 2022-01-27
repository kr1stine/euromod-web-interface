#' poverty UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_poverty_ui <- function(id, i18n){
  ns <- NS(id)
  div(
    br(),
    h4(i18n$t("Töötav elanikkond")),
    br(),
    mod_desc_metric_change_ui(
      ns("in_work_poverty"),
      i18n$t("Palgavaesuse määr"),
      i18n$t(
        "Nende elanike osatähtsus, kes on vaesuses vaatamata sellele, et käivad tööl."
      )
    ),
    h4(i18n$t("Kogu elanikkond")),
    br(),
    mod_desc_metric_change_ui(
      ns("relative_poverty"),
      i18n$t("Suhtelise vaesuse määr"),
      i18n$t("Nende elanike osatähtsus, kes on suhtelises vaesuses.")
    ),
    uiOutput(ns("hh_rel")),
    br(),br(),
    mod_desc_metric_change_ui(
      ns("absolute_poverty"),
      i18n$t("Absoluutse vaesuse määr"),
      i18n$t(
        "Nende elanike osatähtsus, kelle sissetulek jääb alla elatusmiinimumi."
      )
    ),
    uiOutput(ns("hh_abs")),
    br(),
  )
}
    
#' poverty Server Functions
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_poverty_server <- function(input, output, session, i18n, results){
    ns <- session$ns
 
    callModule(mod_desc_metric_change_server,
      "in_work_poverty",
      reactive(results()$original$"in work poverty"),
      reactive(results()$computed$"new in-work poverty rate"),
      desc_tt = reactive(i18n()$t(
        "Palgavaesus näitab, mitu protsenti töötavatest inimestest on suhtelises vaesuses, ehk nende ekvivalentnetosissetulek on allpool suhtelise vaesuse piiri."
      )),
      old_tt = reactive(i18n()$t("Tegelik väärtus")),
      new_tt = reactive(i18n()$t("Ennustatatud uus väärtus"))
    )
    
    callModule(mod_desc_metric_change_server,
      "relative_poverty",
      reactive(results()$original$"relative poverty rate"),
      reactive(results()$computed$"new relative poverty rate"),
      desc_tt = reactive(i18n()$t(
        "Suhtelise vaesuse määr näitab, mitu protsenti kogu elanikkonnast on suhtelises vaesuses, ehk nende ekvivalentnetosissetulek on allpool suhtelise vaesuse piiri."
      )),
      old_tt = reactive(i18n()$t("Tegelik väärtus")),
      new_tt = reactive(i18n()$t("Ennustatatud uus väärtus"))
    )
    
    callModule(mod_desc_metric_change_server,
      "absolute_poverty",
      reactive(results()$original$"abs poverty rate"),
      reactive(results()$computed$"new abs poverty rate"),
      desc_tt = reactive(i18n()$t(
        "Absoluutse vaesuse määr näitab, mitu protsenti kogu elanikkonnast on absoluutses vaesuses, ehk nende ekvivalentnetosissetulek on allpool elatusmiinimumi."
      )),
      old_tt = reactive(i18n()$t("Tegelik väärtus")),
      new_tt = reactive(i18n()$t("Ennustatatud uus väärtus"))
    )
    
    observeEvent(results, {
      hh <- results()$household$abs
      for (scenario in names(hh)) {
        
        ns_id <- ns(paste("rel", scenario))
        callModule(mod_icon_metric_change_server, ns_id,  reactive(hh[[scenario]]$actual), reactive(hh[[scenario]]$projected))
      }
    })
    
    output$hh_rel<- renderUI({
      scenarios <- list()
      
      hh <- results()$household$rel
      for (scenario in names(hh)) {
        
        ns_id <- ns(paste("rel", scenario))
        ac <- hh[[scenario]]$actual
        pr <- hh[[scenario]]$projected
        
        color = if (ac > pr)
          "rgb(0,166,90)" # green
        else if (ac == pr)
          "black"
        else
          "red"
        
        scenarios[[scenario]] <- fluidRow(
          br(),
          column(8, span(i18n()$t(scenario))), 
          column(4, align = "center", tagList(
            span(sprintf("%.2f%%", ac)),
            span(style = sprintf("color: %s", color), icon("arrow-right")),
            span(sprintf("%.2f%%", pr))
          )),
        )
      }
      
      div(scenarios)
    })
    
    output$hh_abs<- renderUI({
      scenarios <- list()
      
      hh <- results()$household$abs
      for (scenario in names(hh)) {
        ns_id <- ns(paste("rel", scenario))
        ac <- hh[[scenario]]$actual
        pr <- hh[[scenario]]$projected
        
        color = if (ac > pr)
          "rgb(0,166,90)" # green
        else if (ac == pr)
          "black"
        else
          "red"
        
        scenarios[[scenario]] <- fluidRow(
          br(),
          column(8, span(i18n()$t(scenario))), 
          column(4, align = "center", tagList(
            span(sprintf("%.2f%%", ac)),
            span(style = sprintf("color: %s", color), icon("arrow-right")),
            span(sprintf("%.2f%%", pr))
          )),
          
        )
      }
      
      div(scenarios)
    })
}
