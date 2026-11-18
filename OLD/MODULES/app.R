# app.R
##  PURPOSE:  Example of  app.R and module (mod-simple.R)
##  USAGE:  This file is app.R and calls 'functions' for ui/server that are defined in mod-simple.R

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
