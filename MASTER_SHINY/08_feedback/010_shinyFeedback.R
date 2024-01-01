# TAGS:   shinyFeedback:: req
library(shiny)
library(shinyFeedback)


# Warns if user enters odd integer
ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  numericInput("n", "n", value = 10),
  textOutput("half")
)
# - v1-----------------------------------
server <- function(input, output, session) {
  half <- reactive({
    even <- input$n %% 2 == 0
    shinyFeedback::feedbackWarning("n", !even, "Please select an even number")
    input$n / 2    
  })
  
  output$half <- renderText(half())
}

# -- v2-----------------------------
# req() blocks still any non-false answer 'truthy'

server <- function(input, output, session) {
  half <- reactive({
    even <- input$n %% 2 == 0
    shinyFeedback::feedbackWarning("n", !even, "Please select an even number")
    req(even)
    input$n / 2    
  })
  
  output$half <- renderText(half())
}
#------------------------------------


shinyApp(ui, server)
