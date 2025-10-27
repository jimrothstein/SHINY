# Exercise 14.
# No errors, but not output widgets

library(shiny)
library(reactlog)
reactlog::reactlog_enable()   # C-F3 to see
# --------------------------------- Slider-----------------------------------

ui <- fluidPage(
    numericInput("x", "Number X", value = 2, min = 0, max = 100),
    numericInput("y", "Number Y", value = 4, min = 0, max = 100),
    numericInput("z", "Number Z", value = 10, min = 0, max = 100),
    textOutput("out")
)

server <- function(input, output, session) {
  sum <- reactive(input$x + input$y + input$z)
  prod <- reactive(input$x * input$y * input$z)
  division <- reactive(prod() / sum())

  # ADD this to make it work

  output$out  <- renderText( {
    division()
   })
}

shinyApp(ui, server)
