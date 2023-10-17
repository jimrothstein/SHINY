library(shiny)

ui <- fluidPage(
  numericInput("a", label="a", 0),
  numericInput("b", label="b", 0),
  numericInput("d", label="d", 0),

  # seems like generic for output
verbatimTextOutput("f")
)

server1 <- function(input, output, session) {
  c <- reactive(input$a + input$b)
  e <- reactive(c() + input$d)
  output$f <- renderText(e())
}

shinyApp(ui, server1)
