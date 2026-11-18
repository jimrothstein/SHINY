# TAGS:   shinyFeedback:: req
library(shiny)
library(shinyFeedback)

# req() block until shiny has necessary info (ie user input etc.)
#
# If input is blank (no user input and NO default), get error.
# Use req()   halts shiny until user enters all necessary info.
#------------------------------------
ui <- fluidPage(
  selectInput("language", "Language", choices = c("", "English", "Maori")),
  textInput("name", "Name"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  greetings <- c(
    English = "Hello", 
    Maori = "Kia ora"
  )
  output$greeting <- renderText({
    # block if any necessary info missing
    req(input$language, input$name)
    paste0(greetings[[input$language]], " ", input$name, "!")
  })
}

shinyApp(ui, server)
