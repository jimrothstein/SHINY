# /home/jim/code/SHINY/MASTER_SHINY/03_chapter_reactive/07_simple_observer.R
#   PURPOSE:
#       Ch03
#       observeEvent: side effect, print to console
#   USAGE:
#       interactive

#   DETAILS:  `outputs`:   renderText in usual way
#                          side effect, from obserEvent
#                          Both are very eager!
#   SEE:        Ch 15.4 for more details
library(shiny)

ui <- fluidPage(
    textInput("name", "What's your name?"),
    textOutput("greeting")
)

server <- function(input, output, session) {
    string <- reactive(paste0("Hello ", input$name, "!"))

    output$greeting <- renderText(string())
    observeEvent(input$name, {
        message("Greeting performed")
    })
}


shinyApp(ui, server)

