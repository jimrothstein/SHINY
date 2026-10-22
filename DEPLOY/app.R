# TAGS:   observe, 

# con not predict which runs 1st observe or renderText
# both depend on input$number
# What when user removes number:
# both watch input$number


library(shiny)

ui <- fluidPage(
  numericInput("number", "Enter a number:", value = 5),
  textOutput("output")
)

server <- function(input, output, session) {
  # console
  observe({
    print(paste("Number changed to:", input$number))
  })
  
  output$output <- renderText({
    paste("Current number:", input$number)
  })
}

shinyApp(ui = ui, server = server)
