# originally hello_1
# https://shiny.posit.co/r/articles/build/execution-scheduling/
# ----
# one reactive value input$obs
# one reactive OBSERVER  output$distPlot, has no value, but has side effect: pass to browser
# ----
# Change the value of input$obs and all decendents are invalidated (dirty).  Then recomputed.
# To recompute, the server function calls to read input$obs, ie a dependency. 
#Graph is finished and sent to brower. Mark output$distPlot as clean.

library(shiny)

# Define UI for application that plots random distributions 
ui = shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello Shiny!"),
  
  # Sidebar with a slider input for number of observations
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", 
                  "Number of observations:", 
                  min = 1, 
                  max = 1000, 
                  value = 500)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))



# Define server logic required to generate and plot a random distribution
server = shinyServer(function(input, output) {
  
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
  output$distPlot <- renderPlot({
    
    # generate an rnorm distribution and plot it
    dist <- rnorm(input$obs)
    hist(dist)
  })
  
})
# Run the application
shinyApp(ui = ui, server = server)



