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
res1 =derive_vars_dt(
  mhdt,
  new_vars_prefix = "AST",
  dtc = MHSTDTC,
  highest_imputation="n",   # default
  flag_imputation="auto"   # default, "date", "none"
 )
res2 =derive_vars_dt(
  mhdt,
  new_vars_prefix = "AST",
  dtc = MHSTDTC,
  highest_imputation="M"
 )


#if (interactive()) {                   #
  # table example
  shinyApp(
    ui = fluidPage(
      
      h3("Working with derive_advs_dt.R"),
      textOutput('version'),
       tags$h3("Third level heading"),
       tags$br(),
       tags$a("This app is built with Shiny.", href = "https://shiny.posit.co/"),
       tags$br(),
      # embed your html yourself
      HTML("hello </br> world"),
      
     selectInput( 
    inputId = "select", 
    label = "Select highest imputataton level:", 
    choices = list("n" = "n", "Y" = "Y", "M" = "M", "D" = "D")
  ), 
      fluidRow(
        column(12,
          tableOutput('table1')
        )
      ),
    
      tags$h4("Highest Imputation= n, default"),
      tags$h5('highest_imputation </br>
              Highest imputation level</br>
              The highest_imputation argument controls which components of the DTC value are imputed if they are missing. All components up to the specified level are imputed.
              If a component at a higher level than the highest imputation level is missing, NA_character_ is returned. For example, for highest_imputation = "D" "2020" results in NA_character_ because the month is missing.
              If "n" is specified no imputation is performed, i.e., if any component is missing, NA_character_ is returned.
              If "Y" is specified, date_imputation should be "first" or "last" and min_dates or max_dates should be specified respectively. Otherwise, NA_character_ is returned if the year component is missing.
              Permitted Values: "Y" (year, highest level), "M" (month), "D" (day), "n" (none, lowest level)) '),
      fluidRow(
        column(12,
          tableOutput('table2')
        ),
      ),
      
      tags$h4("Highest Imputation= D"),
      fluidRow(
        column(12,
          tableOutput('table3')
        )
      ),
    ),
    
    server = function(input, output) {
      
  wrapper = function(dtc, highest_imputation){
  res = impute_dtc_dt(dtc=dtc, highest_imputation=highest_imputation) 
  tibble(dtc, imputed )
  } 
  
res =wrapper(unlist(mhdt), highest_imputation=select ) 

      output$table1<- renderTable(mhdt)
      output$table2 <- renderTable(res1)
      output$table3 <- renderTable(res)
      
    }
)
  
  