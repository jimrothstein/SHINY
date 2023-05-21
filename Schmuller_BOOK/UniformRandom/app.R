library(shiny)
ui <- fluidPage(
sliderInput(inputId = "number", 
            label = "Select a number",
            value = 500, min = 25, max = 1000),
plotOutput("hist")
)


server = function(input,output){
  output$hist = renderPlot(  { hist(runif(input$number, min = 0, max = 1), 
                                xlab= "Value",
                                main=paste(input$number, "random values bet 0 & 1"))
  
  })
}

shinyApp(ui = ui, server = server)
    