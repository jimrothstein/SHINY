# non-interactive;   To Run in Rstudio
library(shiny)
library(ggplot2)
library(admiral)

# sidebar Panel, selectInput, mainPanel .... select from dataset
dates <- c(
  "2019-07-18T15:25:40",
  "2019-07-18T15:25",
  "2019-07-18T15",
  "2019-07-18",
  "2019-02",
  "2019",
  "2019",
  "2019---07",
  ""
)
dataset <- dates

ui = fluidPage(
      h3("Working with derive_advs_dt.R"),
      textOutput('version'),
       tags$h3("Third level heading"),
       tags$br(),
       tags$a("This app is built with Shiny.", href = "https://shiny.posit.co/"),
       tags$br(),
      # embed your html yourself
      HTML("hello </br> world"),
      

  titlePanel("Impute Explorer"),

  sidebarPanel(

    selectInput('impute_level','Highest Imputation Level', c("M", "D", "n")),
    
   # selectInput('x', 'X', names(dataset)),
   # selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
   # selectInput('color', 'Color', c('None', names(dataset))),

    #checkboxInput('jitter', 'Jitter'),
    #checkboxInput('smooth', 'Smooth'),
  ),

  mainPanel(
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
          tableOutput('dataset')
        )
      ),
      fluidRow(
        column(12,
          tableOutput('imputed')
        )
      )
    )
) # ui

server = function(input,output) {
  output$dataset = renderTable(dataset)
  
imputed = dataset
res = reactive(impute_dtc_dtm(dtc = dataset,
                        highest_imputation = input$impute_level))
output$imputed = renderTable(res())
} 


shinyApp(ui,server)

if (F){
  shinyApp(
    ui = fluidPage(
      
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
    ),   # end page

?admiral::derive_vars_dt
) # end App 
} # end if 
