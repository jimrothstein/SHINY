#  ISOLATE
## https://shiny.posit.co/r/articles/build/isolation/


## Run when push button;  not when slider changes. 
## Server reads input$obs;  but does not depend on it.
## Said another way, push button and chain is invalidated, so must recalcualte.
##  but no invalidation when input$obs changes
library(shiny)
ui <- pageWithSidebar(
  headerPanel("Click the button"),
  sidebarPanel(
    sliderInput("obs", "Number of observations:",
                min = 0, max = 1000, value = 500),
    actionButton("goButton", "Go!")
  ),
  mainPanel(
    plotOutput("distPlot")
  )
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    
    # Take a dependency on input$goButton
    input$goButton
    
    # Use isolate() to READ but avoid dependency on input$obs
    dist <- isolate(rnorm(input$obs))
    hist(dist)
  })
}
shinyApp(ui = ui, server = server)
