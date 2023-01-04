## Interface of the application
## REF: https://kimloanrobinson.shinyapps.io/r_shiny_book_web/
ui <- fluidPage(
  # title of the app
  titlePanel("Data Visualization"),
  sidebarLayout(
    # Sidebar Panel
    sidebarPanel(
      selectInput("dt", "Select Dataset", choices = c("mtcars", "iris")),
      uiOutput("var"),
      actionButton("submit", "Plot"),
      hr() # a line break
    ),
    #close sidebarPanel()
    
    # Main Panel
    mainPanel(# Create tab Panel
      tabsetPanel(
        id = "tab_id",
        # Data Review tab will print out the data
        tabPanel(
          "Data Review",
          value = "data_tab",
          br(),
          br(),
          DT::DTOutput("dtable"),
          br(),
          br()
        ),
        # Plot tab will print out the plot
        tabPanel(
          "Plot",
          value = "plot_tab",
          br(),
          br(),
          plotOutput("plot_out", width = "70%", height  = "550px"),
          br(),
          uiOutput("dl_butt")
        )
      )) # close mainPanel()
    
  ),
  # close sidebarLayout
  
  br(),
  br(),
  br(),
  br(),
  hr(),
  source("footer.R", local = TRUE)$value
)
