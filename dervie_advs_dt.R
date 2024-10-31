# PURPOSE:   Examples of how derive_vars_dt processes tibbles.
library(shiny)
library(admiral)
library(lubridate)
### Only run this example in interactive R sessions

# table for testing
mhdt <- tribble(
   ~MHSTDTC,
   "2019-07-18T15:25:40",
   "2019-07-18T15:25",
   "2019-07-18",
   "2019-02",
   "2019",
   "2019---07",
   ""
 )

# Create ASTDT and ASTDTF
# No imputation for partial date
res =derive_vars_dt(
  mhdt,
  new_vars_prefix = "AST",
  dtc = MHSTDTC
 )

if (interactive()) {                   #
  # table example
  shinyApp(
    ui = fluidPage(
      fluidRow(
        column(12,
          tableOutput('table')
        )
      ),
    
      fluidRow(
        column(12,
          tableOutput('table1')
        )
    )
    ),
    
    server = function(input, output) {
      output$table <- renderTable(mhdt)
      output$table1 <- renderTable(res)
      
    }
  )
}
