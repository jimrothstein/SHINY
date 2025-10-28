
## Chapter 4,   4.4   PROTOTYPE
##
source("10_prototype.R")
prod_codes <- setNames(products$prod_code, products$title)
names(prod_codes)

ui <- fluidPage(
  fluidRow(
    column(3, 
      h3("v 45_shiny_prototype II.R"),
      )
    ),
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


# hadley includes top 5 only, converts to factors
if (F){
  injuries %>%
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))
}
##  generalize for any df, var
count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}

  selected <- reactive(injuries %>% dplyr::filter(prod_code == input$code))

  output$diag <- renderTable(
    count_top(selected(), diag), width = "100%")
    #selected() %>% count(diag, wt = weight, sort = TRUE)

  output$body_part <- renderTable(
    #selected() %>% count(body_part, wt = weight, sort = TRUE)
    count_top(selected(), body_part), width = "100%")
  
  output$location <- renderTable(
    #selected() %>% count(location, wt = weight, sort = TRUE)
    count_top(selected(), location), width = "100%")

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
