##  file <- "320_simple_App.R"
##
##  PURPOSE:    Very simple Shiny App.
##  USAGE:      >source("<filename>") (only 1st)
library(shiny)

# # Create and then Run a Shiny app object
  app <- shinyApp(
    ui = bootstrapPage(
      numericInput('n', 'Number of obs', 100),
      plotOutput('plot')
    ),
    server = function(input, output) {
      output$plot <- renderPlot({ hist(runif(input$n)) })
    }
  )
runApp(app)

##-----------------------------------
##  INTERACTIVE, slightly different
##-----------------------------------
if (FALSE) {

## Only run this example in interactive R sessions
if (interactive()) {
  options(device.ask.default = FALSE)

  # Apps can be run without a server.r and ui.r file
  runApp(list(
    ui = bootstrapPage(
      numericInput('n', 'Number of obs', 100),
      plotOutput('plot')
    ),
    server = function(input, output) {
      output$plot <- renderPlot({ hist(runif(input$n)) })
    }
  ))
