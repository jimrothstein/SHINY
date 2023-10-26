##  USAGE:  Interactive, line-by-line displays HTML page
##          Display all drugs, approvals/denials
##  TODO:

library(data.table)
library(shiny)


x  <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")
drugs  <- x$drug
# -------------------------------------------------------

    ui = fluidPage(
# --------------- List All Drugs & Freq
      fluidRow(
        column(12,
          tableOutput('drug')
        )
      )
    )

# -------------------------------------------------------
    server = function(input, output) {

      ## CHOOSE 1 (Alpha v Freq)
      #output$drug  <- renderTable(table(x$drug)) # ALPHA order 
      output$drug  <- renderTable(x[, .N, by=drug][order(-N)]) #  FREQ order

    }
  
# -------------------------------------------------------
shinyApp(ui, server)
# -------------------------------------------------------

