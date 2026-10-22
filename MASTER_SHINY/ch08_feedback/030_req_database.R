# TAGS:   shinyFeedback:: req
library(shiny)
library(shinyFeedback)

# req() block until shiny has necessary info (ie user input etc.)
#  What is no database selected?
#------------------------------------
ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  textInput("dataset", "Dataset name"), 
  tableOutput("data")
)

shinyApp(ui, server)
