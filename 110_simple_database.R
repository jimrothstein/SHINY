library(shiny)
### Only run this example in interactive R sessions
if (interactive()) {                   #
  # table example
  shinyApp(
    ui = fluidPage(
      fluidRow(
        column(12,
          tableOutput('table')
        )
      )
    ),
    server = function(input, output) {
      output$table <- renderTable(mtcars)
    }
  )
}

