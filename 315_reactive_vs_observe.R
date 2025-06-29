# 315
# compare observeEvent vs renderText

# reactive: 
# any change in box "a", render Text runs (or accodring to lazy reactive)

# observeEvent - not 'reactive'   need an event
# enter into text "a" - nothing happens
# but push GO - console prints 
library(shiny)
ui  <- fluidPage(
  textInput("a", "A"),   # labeled "A"
  textOutput("b"),
  actionButton("go", "GO") # button labeled "GO"
  
  )
  
# server, appears to be dependeny on "a";   must push GO 1st
# push GO 2nd time (without change text) get another console print

server  <- function(input, output){
  observeEvent(
    input$go,  # event expr, nothing till this event happens
    {print(input$a)} # # handler expr, print to console
  )
  # reactive
 output$b  <- renderText({input$a})

  }

shinyApp(ui, server)
