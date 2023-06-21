library(shiny)
#   CHOISE :   One (1)  of the follwing
##
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)
# --------------------------------- -----------------------------------
server <- function(input, output, session) {

server1 <- function(input, output, server) {
#  input$greeting <- renderText(paste0("Hello ", name))
  output$greeting <- renderText({paste0("Hello ", input$name)})
}

server2 <- function(input, output, server) {
#  greeting <- paste0("Hello ", input$name)
   greeting <- reactive(paste0("Hello ", input$name))
#  output$greeting <- renderText(greeting)
   output$greeting <- renderText({greeting()})
}

server3 <- function(input, output, server) {
  #output$greting <- paste0("Hello", input$name)
  output$greeting <- renderText({paste0("Hello", input$name)})
}
}

#
                                       #CHOOSE ONE --------------------
shinyApp(ui, server)
shinyApp(ui, server1)
shinyApp(ui, server2)
shinyApp(ui, server3)
# --------------------

