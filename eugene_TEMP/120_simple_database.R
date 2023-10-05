library(shiny)

    ui = fluidPage(
                   tableOutput('table')

                   )


    server = function(input, output) {
      output$table <- renderTable(mtcars)
    #  output$hist <- renderPlot({
    #x1 <- rnorm(input$n1, input$mean1, input$sd1)
    #x2 <- rnorm(input$n2, input$mean2, input$sd2)
    #}
  #)
}

  shinyApp(ui, server)
