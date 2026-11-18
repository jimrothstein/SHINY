library(shiny)

sales <- vroom::vroom("data/sales_data_sample.csv", col_types = list(), na = "")
sales %>% 
  dplyr::select(TERRITORY, CUSTOMERNAME, ORDERNUMBER, everything()) %>%
  dplyr::arrange(ORDERNUMBER)

base::unique(sales$TERRITORY)

ui <- fluidPage(
  selectInput("territory", "territory", choices = unique(sales$TERRITORY)),
  tableOutput("selected")
)
server <- function(input, output, session) {
  selected <- reactive(sales[sales$TERRITORY == input$territory, ])
  output$selected <- renderTable(head(selected(), 10))
}

shinyApp(ui, server)


## QUESTIONS
## head(sales$TERRITORY == "EMEA", 25)

## sales[sales$TERRITORY == "EMEA", c("TERRITORY")]
## sales[, c("TERRITORY")]
##
##
subset(sales, is.na(TERRITORY))  #0
subset(sales, TERRITORY == "NA") # many
subset(sales, TERRITORY == NA)   #0
