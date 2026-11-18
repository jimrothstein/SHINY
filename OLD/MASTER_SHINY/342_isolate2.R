#  ISOLATE2
## https://shiny.posit.co/r/articles/build/isolation/

## TODO
## want output$text1 to update when input$x changes
## want output$text2 to update only wwhen input$y changes 

library(shiny)
ui <- pageWithSidebar(
   
  textInput(inputId= "x", label = "x"),
  textInput(inputId = "y",label =  "y"),
  verbatimTextOutput(outputId = "text1"),
  verbatimTextOutput(outputId= "text2")
    
  )
  
  
server <- function(input, output) {
  
output$text1 <- renderText({
  paste("The value of x is", input$x)
})

# With isolate - only re-runs when input$y changes, not when input$x changes
 output$text2 <- renderText({
#   paste("Y is", input$y, "and X is", isolate(input$x))
   paste("hi")
 })
   }

shinyApp(ui = ui, server = server)