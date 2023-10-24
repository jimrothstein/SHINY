##  USAGE:  Interactive, line-by-line displays HTML page
            Choose 1 drug, display approvals/denials
##  TODO:
#   use selectizeInput()

library(data.table)
library(shiny)

x  <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")
#drugs  <- x$drug
drugs = x[, .(drug)][order(drug)]   # to keep as dt
# -------------------------------------------------------

    ui = fluidPage(
      h3("Select Drug, Favorable v Denied")
      fluidRow(
        column(6,
          # R wants: selectizeInput()
          selectInput(inputId = "drug", 
                      label = "Choose Drug", 
                      choices = drugs,
                      multiple = FALSE
                      )
        ),
# --------------- List All Drugs & Freq
      fluidRow(
        column(12,
          tableOutput('drug')
        )
      )
    )
)
# -------------------------------------------------------
    server = function(input, output) {
#      output$drug  <- renderTable(table(x$drug))
#      output$drug  <- renderTable(x[drug == "LIDOCAINE", .N, by=decision])
       output$drug  <- renderTable(x[drug == input$drug , .N, by=decision])

    }
  
# -------------------------------------------------------
shinyApp(ui, server)
# -------------------------------------------------------

if(F) {
ui <- fluidPage(
  fluidRow(
    column(6,
      selectInput("code", "Product", choices = prod_codes)
    )
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  )
)
}
