library(shiny)
library(bslib)

ui <- fluidPage (
  titlePanel("censusVis"),
  sidebarPanel(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices = 
        c("Percent White",
          "Percent Black",
          "Percent Hispanic",
          "Percent Asian"),
      selected = "Percent White"
    ),
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0, 
      max = 100, 
      value = c(0, 100)
    )
  ),
  textOutput("selected_var")
)

server <- function(input, output) {
  
  output$selected_var <- renderText({
    paste("You have selected this", input$var)
  })
  
}
#shinyApp(ui,server)
runApp("SHINY_GETTING_STARTED/census-app/census-app.R")
