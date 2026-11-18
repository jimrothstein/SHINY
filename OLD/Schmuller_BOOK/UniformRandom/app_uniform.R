# PURPOSE: Hist of sample data draw from uniform distribution

# USAGE:  (source("app_uniform.R"))
# TAGS:  shiny, hist, uniform dist, siderInput

library(shiny)
ui <- fluidPage(
sliderInput(inputId = "number", 
            label = "Select a number for N",
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
    
