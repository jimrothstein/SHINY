library(shiny)
library(ggplot2)

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

  titlePanel("Impute Explorer"),

  sidebarPanel(

   # sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                #value=min(1000, nrow(dataset)), step=500, round=0),

    selectInput('impute_level','Highest Imputation Level', c("M", "D", "n")),
    
   # selectInput('x', 'X', names(dataset)),
   # selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
   # selectInput('color', 'Color', c('None', names(dataset))),

    #checkboxInput('jitter', 'Jitter'),
    #checkboxInput('smooth', 'Smooth'),

    #selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
    #selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
  ),

  mainPanel(
      fluidRow(
        column(12,
          tableOutput('dataset')
        )
      )
    )
)

server = function(input,output) {
  output$dataset = renderTable(dataset)
} 

shinyApp(ui,server)