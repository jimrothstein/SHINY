library(shiny)
library(data.table)

x <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")
decisions_ui <- function(id) {
  tagList(
    # here setting ui id to var, hist
    selectInput(NS(id, "var"), "Choose column", choices = names(x)),
    tableOutput(NS(id, "table")),
    # plotOutput(NS(id, "hist"))
  )
}

decisions_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(x)
    output$table <- renderTable({
      data()
    })
    #     output$hist <- renderPlot({
    #       hist(data())
    #     })
  })
}

decision_demo <- function(id) {
  ui <- fluidPage(fluidRow(decisions_ui("fake")))

  server <- function(input, output, session) {
    decisions_server("fake")
  }


  shinyApp(ui, server)
}

decision_demo()
