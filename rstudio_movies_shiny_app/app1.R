# Load packages ----------------------------------------------------------------

library(shiny)
library(ggplot2)

# Load data --------------------------------------------------------------------

load("~/code/SHINY/rstudio_movies_shiny_app/movies.RData")

# calc ratio, outside of ui/server ---------------------------------------------

# ratio of critics and audience scores
movies_ratio <- movies %>%
  mutate(score_ratio = audience_score / critics_score)

# Define UI --------------------------------------------------------------------

ui <- fluidPage(
  sidebarLayout(

    # Inputs: Select variables to plot
    sidebarPanel(

      # Select variable for y-axis
      selectInput(
        inputId = "y",
        label = "Y-axis:",
        choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"),
        selected = "audience_score"
      ),
      # Select variable for x-axis
      selectInput(
        inputId = "x",
        label = "X-axis:",
        choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"),
        selected = "critics_score"
      ),
      # Subset for title types
      checkboxGroupInput(
        inputId = "selected_title_type",
        label = "Select title type:",
        choices = levels(movies$title_type),
        selected = levels(movies$title_type)
      )
    ), # sidebarPanel


    # Output: Show scatterplot
    mainPanel(
      plotOutput(outputId = "scatterplot"),
      # Show data table
      tableOutput(outputId = "summarytable"),
      # show raw 
      tableOutput(outputId = "raw_table")
    )
  )
) # end fluidPage

# Define server ----------------------------------------------------------------

server <- function(input, output, session) {
  
  
  # wow, this works: x,y must be reactive to inputs
  # but to use in aes it must a symbol
  x = reactive({as.symbol(input$x)})
  y = reactive({as.symbol(input$y)})
  
  
  output$scatterplot = renderPlot({
    ggplot(movies, aes(!!x(), !!y())) +
      geom_point()
  })
  
  
  output$summarytable <- renderTable({
    movies_ratio %>%
     dplyr::filter(title_type %in% input$selected_title_type) %>%
      group_by(mpaa_rating) %>%
      summarise(mean_score_ratio = mean(score_ratio), SD = sd(score_ratio), n = n())
  },
  striped = TRUE,
  spacing = "l",
  align = "lccr",
  digits = 4,
  width = "90%",
  caption = "Score ratio (audience / critics' scores) summary statistics by MPAA rating."
)
  
  output$raw_table = renderTable({
    movies |>
      dplyr::select(input$x, input$y)
  })

}   # end server fct
# Create a Shiny app object ----------------------------------------------------

shinyApp(ui = ui, server = server)
