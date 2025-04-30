# observeEvent
# print to CONSOLE
library(shiny)

 ## App 2: Using `once`
ui = basicPage(
  actionButton("go", "Go")
  )

    server = function(input, output, session) {

      observeEvent(input$go, {
        print(paste("This will only be printed once; all",
              "subsequent button clicks won't do anything"))
      }, once = TRUE)

      # The observeEvent() above is equivalent to:
      # observe({
      #   print(paste("This will only be printed once; all",
      #         "subsequent button clicks won't do anything"))
      #   }) %>%
      #   bindEvent(input$go, once = TRUE)
      
      observeEvent(input$go, {
        print(paste("But this one, prints EACH time button pushed."))
      }, once = FALSE)
    }
    
  

shinyApp(ui, server)

# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

