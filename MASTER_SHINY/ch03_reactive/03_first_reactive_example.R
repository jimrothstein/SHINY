library(shiny)
#   PROBLEM:  Shiny too reactive; reacts each letter of name
#   USAGE:  interactive choose ONE of the servers below

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

# CHOOSE 1 server

# --------------------- Simplest-----------------------
server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name, "!")
  })
}


# --------------------- SAME, but a reactive expr-----------------------

server <- function(input, output, session) {
  string <- reactive(paste0("Hello ", input$name, "!"))
  output$greeting <- renderText(string())
}

# --------------------------------------------
shinyApp(ui, server)
