# app.R
library(shiny)
source("mod-simple.R")


ui <- fluidPage(
  simple_ui("x"),
  simple_ui("y")
)

server <- function(input, output, session) {
  simple_server("x", msg = "this is x")
  simple_server("y", msg = "this is y")
}


shinyApp(ui, server)
