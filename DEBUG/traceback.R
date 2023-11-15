# Mastering Shiny -
# Workflow - CHAPTER 5.2 traceback
# USAGE:  Best in Rstudio, will traceback for debugging
#          Run this app by running shiny-run.R (sets port, autoreload option...)

library(shiny)

f <- function(x) g(x)
g <- function(x) h(x)
h <- function(x) x * 2

ui <- fluidPage(
  selectInput("n", "N", 1:10),
  plotOutput("plot")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(
    {
      # problem and fix
      # n <- f(input$n)
      n <- f(as.numeric(input$n))
      plot(head(cars, n))
    },
    res = 96
  )
}
shinyApp(ui, server)
