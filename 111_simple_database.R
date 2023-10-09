library(shiny)
    ui = fluidPage(
      fluidRow(
        column(12,
          tableOutput('table')
        )
      )
    )

    server = function(input, output) {
      output$table <- renderTable(mtcars)
    }
  
shinyApp(ui, server)


#   USAGE:  interactively run each line or as entire block

#   THESE do not work:
if (F) {
  (source("111_simple_database.R"))
}

if (F) {
  shiny::runApp("111_simple_database.R")
}

