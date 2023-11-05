library(shiny)
simple_ui <- function(id) {
  fluidRow(
    textOutput(NS(id, "text"))
  )
}

simple_server <- function(id, msg) {
  moduleServer(id, function(input, output, session) {
    output$text <- renderText({
      msg
    })
  })
}
simple_demo <- function() {
  ui <- fluidPage(simple_ui("x"))

  server <- function(input, output, session) {
    simple_server("x", msg = "")
  }
  shinyApp(ui, server)
}
simple_demo()
