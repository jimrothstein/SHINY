## observeEvent 
## eventReactive
## Only run examples in interactive R sessions
if (interactive()) {

  ## App 1: Sample usage
  shinyApp(
    ui = fluidPage(
      column(4,
        numericInput("x", "Value", 5),
        br(),
        actionButton("button", "Show")
      ),
      column(8, tableOutput("table"))
    ),
    server = function(input, output) {
      
      # observeEvent (button) ----
      
      # Take an action every time button is pressed;
      # here, we just print a message to the console
      observeEvent(input$button, {
        cat("Showing", input$x, "rows\n")
      })
      # The observeEvent() above is equivalent to:
      # observe({
      #    cat("Showing", input$x, "rows\n")
      #   }) %>%
      #   bindEvent(input$button)
      
      # observeEvent (input$x)----
      
      observeEvent(input$x, {
        cat("You changed # rows to", input$x, "Now push the button! \n")
      })
      
      # Take a reactive dependency on input$button, but
      # not on any of the stuff inside the function
      # ie reacts UPON button push; not change input$x
     
      # react  (input$button, NOT input$x) ----
      df <- eventReactive(input$button, {
        head(cars, input$x)
      })
      output$table <- renderTable({
        df()
      })
    }  # server
  ) # shinyApp

}  #end if