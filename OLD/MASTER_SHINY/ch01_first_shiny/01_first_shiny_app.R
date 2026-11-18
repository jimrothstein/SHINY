library(shiny)


# PURPOSE:		First shiny app
#

# USAGE: (source(<file>))    (Note:  need  outer paranthesis, like printing)
# Also can open 2nd, exteranl browwer to see same results.
# Reactive:   code is 'recipe' to fire under right
# conditions.

ui <- fluidPage(
  "Hello, world!"
)
#
#
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })

  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}
shinyApp(ui, server)
#shiny::runApp(display.mode="showcase")
