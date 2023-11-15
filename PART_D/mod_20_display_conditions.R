# mod_xx_conditions
# mod_20_display_conditions.R
# ------------------------------
library(data.table)
library(shiny)
x <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")

x <- setnames(x, c("_condition"), c("condition"))
y <- x[, .N, by = .(condition)][order(-N)]

conditions_ui <- function(id) {
  tagList(
    h2("Top 20 Conditions"),
    tableOutput(NS(id, "table")),
  )
}

conditions_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(head(y, n = 20))
    output$table <- renderTable({
      data()
    })
  })
}

conditions_demo <- function(id) {
  ui <- fluidPage(fluidRow(conditions_ui("fake")))

  server <- function(input, output, session) {
    conditions_server("fake")
  }


  shinyApp(ui, server)
}

conditions_demo()
