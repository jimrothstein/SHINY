library(shiny)

# PURPOSE:		First shiny app
# REF:   Chapter 1.6 - reative functions
#

# USAGE: (source(<file>))    (Note:  need  outer paranthesis, like printing)
#Also can open 2nd, exteranl browwer to see same results.
#Reactive:   code is 'recipe' to fire under right
#conditions. 

ui <- fluidPage(
  "Hello, world!"
)
#
#
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {

# 1) Create a reactive expression
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })

# 
  output$summary <- renderPrint({
# 2) replace 2 lines with
  #  dataset <- get(input$dataset, "package:datasets")
  # summary(dataset)
    summary(dataset())  # call like function
  })

  output$table <- renderTable({
#  3) Use :
    dataset()

    # And not
#    dataset <- get(input$dataset, "package:datasets")
#    dataset
  })
}
shinyApp(ui, server)
