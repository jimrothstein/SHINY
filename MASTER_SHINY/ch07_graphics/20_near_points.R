library(shiny)
library(ggplot2)

##  TODO
##  - Choice 2 , problem with showing entire database on click.
ui <- fluidPage(
  plotOutput("plot", click = "plot_click"),
  tableOutput("data")
)

## Choose 1,  base R plot, OR
server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  }, res = 96)
  
  ##  input$plot_click is event object; in particular x, y values
  ## allRows = TRUE, entire database, with selected point marked TRUE
  output$data <- renderTable({
    nearPoints(mtcars, input$plot_click, xvar = "wt", yvar = "mpg", allRows =TRUE)
  })
}


## Choice #2   ggplot

server <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point()
  }, res = 96)
  
  output$data <- renderTable({
    req(input$plot_click)
#    nearPoints(mtcars, input$plot_click, allRows=TRUE)
    nearPoints(mtcars, input$plot_click)
  })
}

options(shiny.autoload.r = TRUE)
shinyApp(ui, server)
