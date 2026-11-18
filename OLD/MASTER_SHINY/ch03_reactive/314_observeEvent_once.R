# observeEvent
# print to CONSOLE
library(shiny)

 ## App 2: Using `once`
ui = basicPage(
  actionButton("go", "Go")  # displays "Go"
  )

    server = function(input, output, session) {

      # observe ONCE
      observeEvent(input$go, {
        print(paste("This will only be printed once; all",
              "subsequent button clicks won't do anything"))
      }, once = TRUE)

      # observe each time button pushed
      observeEvent(input$go, {
        print(paste("But this one, prints EACH time button pushed."))
      }, once = FALSE)
    }
    
  

shinyApp(ui, server)
