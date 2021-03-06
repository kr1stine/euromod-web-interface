#' gender_pay_gap UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_gender_pay_gap_ui <- function(id, i18n) {
  ns <- NS(id)
  div(
    br(),
    h4(i18n$t("Töötav elanikkond")),
    br(),
    mod_desc_metric_change_ui(
      ns("pay_gap"),
      i18n$t("Sooline palgalõhe"),
      i18n$t("Täisajaga töötavate meeste ja naiste brutotunnipalkade lõhe.")
    ),
    br(),
    mod_desc_metric_change_ui(
      ns("disp_ft"),
      i18n$t("Kättesaadava sissetuleku sooline lõhe"),
      i18n$t(
        "Täisajaga töötavate meeste ja naiste kasutatava sissetuleku (brutopalk + toetused - maksud) lõhe."
      )
    ),
    br(),
    mod_desc_metric_change_ui(
      ns("disp"),
      i18n$t("Kättesaadava sissetuleku sooline lõhe"),
      i18n$t(
        "Positiivse sissetulekuga meeste ja naiste kasutatava sissetuleku (brutopalk + toetused - maksud) lõhe."
      )
    )
  )
}

#' gender_pay_gap Server Functions
#'
#' @noRd
mod_gender_pay_gap_server <- function(input, output, session, i18n, results) {
  ns <- session$ns

  callModule(mod_desc_metric_change_server,
    "pay_gap",
    reactive(results()$original$"gender pay gap"),
    reactive(results()$computed$"new pay gap"),
    desc_tt = reactive(i18n()$t(
      "Palgalõhe näitab, mitu protsenti on naiste brutotunnipalk meeste omast madalam."
    )),
    old_tt = reactive(i18n()$t("Tegelik väärtus")),
    new_tt = reactive(i18n()$t("Ennustatatud uus väärtus"))
  )

  callModule(mod_desc_metric_change_server,
    "disp_ft",
    reactive(results()$original$"disp income gap workers"),
    reactive(results()$computed$"new disp inc gap ft"),
    desc_tt = reactive(i18n()$t(
      "Palgalõhe näitab, mitu protsenti on naiste brutotunnipalk meeste omast madalam."
    )),
    old_tt = reactive(i18n()$t("Tegelik väärtus")),
    new_tt = reactive(i18n()$t("Ennustatatud uus väärtus"))
  )

  callModule(mod_desc_metric_change_server,
    "disp",
    reactive(results()$original$"disp income gap all"),
    reactive(results()$computed$"new disp inc gap"),
    desc_tt = reactive(i18n()$t("Arv näitab, mitu protsenti on naiste kuus kättesaadav sissetulek meeste omast madalam.")),
    old_tt = reactive(i18n()$t("Tegelik väärtus")),
    new_tt = reactive(i18n()$t("Ennustatatud uus väärtus"))
  )
}
