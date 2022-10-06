

#Load Required R Packages
library(shiny)
#library(tidyverse)
library(data.table)
library(lubridate)
#library(readxl)
library(shinyWidgets)

faves <- readRDS('faves.rds')

langs <- c("rstats| r |rstudio|tidyverse", "python", "sql", "excel ", "tableau", "power bi")
names(langs) <- c("R", "Python", "SQL", "Excel", "Tableau", "Power BI")
langs <- sort(langs)
subjects <- c("nlp", "machine learning", "shiny", "data vi", "cloud", "data mining|datamining", "web3|crypto|blockchain|nft", "statistics", "deeplearning|neuralnet|neural|artificial|tensor")
names(subjects) <- c("Natural Language Processing", "Machine Learning", 
                     "Shiny Dashboards", "Data Visualisation", "Cloud Computing", "Data Mining", "Web3, Blockchain, NFTs and Crypto", "Statistics", "Deep Learning, Neural Networks and AI")
subjects <- sort(subjects)


ui  <- shiny::fluidRow(column(6, 
											 shinyWidgets::pickerInput("lang", "Select Language / Software / Service:", 
                            choices = langs, 
                            options = list(`actions-box` = TRUE), 
                            multiple = TRUE, selected = "python", width = '100%')),
         (column(6,
          pickerInput("subject", "Filter by Subject / Area:", 
                            choices = subjects, 
                            options = list(`actions-box` = TRUE), 
                            multiple = TRUE, width = '100%'))),)


faves_new <- reactive({
  faves %>%
    filter(str_detect(lower_text, str_c(input$lang, collapse = '|'))) %>%
    filter(str_detect(lower_text, str_c(input$subject, collapse = '|'))) %>%
    arrange(-favorite_count,-retweet_count)
})



server <- function(input, output, session) {

output$table  <- renderTable({
  faves_new <- faves_new()
  faves_new <- faves_new[, c(4, 19, 20, 46)]
	as.data.table(faves_new,
                options = list(pageLength = 5), 
                colnames = c("Tweet Text", "#RTs", "#Faves", "Content"),
                rownames = FALSE,
                escape = F)  
})
}

shinyApp(ui, server)

##	To run
if (F) {
	(source("211_shiny.R"))
}

