library(shiny)

ui <- fluidPage(
  textOutput("message")
)
server <- function(input, output, session) {
  output$message <- renderText("hello message changed")
}
shinyApp(ui, server)

