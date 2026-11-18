##  USAGE:  Interactive, line-by-line displays HTML page
##            Choose 1 drug, display approvals/denials
##  TODO:
#   use selectizeInput()
#   hot key to :RStop
#   theme or CSS for simple bold, red...
#   bindkey to go ../PART_D
#   bar chart showing most common drgs
#   BEST  coding layout:   tmux, R or R console 

library(data.table)
library(shiny)
library(bslib)
x  <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")
#drugs  <- x$drug
drugs = x[, .(drug)][order(drug)]   # to keep as dt
# -------------------------------------------------------

    ui = fluidPage(
      theme = bslib::bs_theme(bootswatch = "darkly"),
      h3("Select Drug, Favorable v Denied"),
      h4("Try ... LIDOCAINE or OZEMPIC"),
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
      ),
               fluidRow(
                        column(12,
                               tableOutput('details')
                               )
                        )
    )
)
# -------------------------------------------------------
if (F) {
x[, .N, by=drug][order(N)]
str(x)
}
    server = function(input, output, session) {

  y  <- reactive(x[drug == input$drug, .N, by=decision])
  output$drug  <- renderTable(y())
  z  <- reactive(x[drug == input$drug,])
  output$details  <- renderTable(z())

      if (F) {
#      output$drug  <- renderTable(table(x$drug))
#      output$drug  <- renderTable(x[drug == "LIDOCAINE", .N, by=decision])
       output$drug  <- renderTable(x[drug == input$drug , .N, by=decision])
      }
    }
  
# -------------------------------------------------------
shinyApp(ui, server)
# -------------------------------------------------------


