# file <- "00_setup.R"

# REF:    Mastering Shiny, Chapter 04, ER injuries
# REF:   https://www.cpsc.gov/Research--Statistics/NEISS-Injury-Data
#        cribs, shopping cart .... injuries
#
#
#       USAGE:  (source("10_prototype.R"))
library(shiny)
library(vroom)
library(tidyr)
library(dplyr)
library(ggplot2)

##  tries to install `BH`, which has errors (don't want to waste  time on this
##  now) -- see issues in httpgd
if (F) library(httpgd) # control plots easily 


# change "master" to "main", then works 
  if (F) {
  download <- function(name) {
    url <- "https://github.com/hadley/mastering-shiny/raw/main/neiss/"
    cat(from  <- paste0(url, name), "\n")
    cat(to  <-  paste0("neiss/", name), "\n")
    utils::download.file(from,to,  quiet = TRUE)
  }
  download("injuries.tsv.gz")
  download("population.tsv")
  download("products.tsv")
  }
injuries <- vroom::vroom("../neiss/injuries.tsv.gz")
injuries
str(injuries)


products <- vroom::vroom("../neiss/products.tsv")
products
#> # A tibble: 38 × 2
#>   prod_code title                            
#>       <dbl> <chr>                            
#> 1       464 knives, not elsewhere classified 
#> 2       474 tableware and accessories        
#> 3       604 desks, chests, bureaus or buffets
#> 4       611 bathtubs or showers              
#> 5       649 toilets                          
#> 6       676 rugs or carpets, not specified   
#> # … with 32 more rows

population <- vroom::vroom("../neiss/population.tsv")
population


prod_codes <- setNames(products$prod_code, products$title)

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

server <- function(input, output, session) {

  selected <- reactive(injuries %>% filter(prod_code == input$code))

  output$diag <- renderTable(
    selected() %>% count(diag, wt = weight, sort = TRUE)
  )
  output$body_part <- renderTable(
    selected() %>% count(body_part, wt = weight, sort = TRUE)
  )
  output$location <- renderTable(
    selected() %>% count(location, wt = weight, sort = TRUE)
  )

  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })

  output$age_sex <- renderPlot({
    summary() %>%
      ggplot(aes(age, n, colour = sex)) +
      geom_line() +
      labs(y = "Estimated number of injuries")
  }, res = 96)
}

shinyApp(ui, server)
