##          Display all drugs, approvals/denials
##  TODO:

library(data.table)
library(shiny)


x <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")
drugs <- x$drug
# -------------------------------------------------------


drugs_ui <- function(id) {
  fluidRow(
    column(
      12,
      shiny::tableOutput(NS(id, "drug"))
    )
  )
}

# -------------------------------------------------------

drugs_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(x)
    output$drug <- renderTable(data()[, .N, by = drug][order(-N)]) #  FREQ order
  })
}


# -------------------------------------------------------
# shinyApp(ui, server)
# -------------------------------------------------------

drugs_demo <- function(id) {
  ui <- fluidPage(drugs_ui("fake"))
  server <- function(input, output, session) {
    drugs_server("fake")
  }

  shinyApp(ui, server)
}


# drugs_demo()
