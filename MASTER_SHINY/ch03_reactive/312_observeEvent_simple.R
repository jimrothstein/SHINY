# observeEvent
# fires with any single change in input$name

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  phrase <- reactive(paste0("Hello ", input$name, "!"))
  
  output$greeting <- renderText(phrase())
  observeEvent(input$name, {
    message("Greeting performed (handler for observeEvent)", as.character(date()))
  })
}

shinyApp(ui, server)
