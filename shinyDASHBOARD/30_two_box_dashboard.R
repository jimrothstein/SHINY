## app.R ##
##  https://rstudio.github.io/shinydashboard/get_started.html
library(shinydashboard)
library(shiny)
## Sidebar content

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      shinydashboard::menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th")),
      menuItem("Jim Widget", tabName = "jim_widget", icon = icon("th"))
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(
        tabName = "dashboard",
        fluidRow(
          box(plotOutput("plot1", height = 250)),
          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          ),
        ),
        fluidRow(
          helpText("This is help text")
        ),
      ),

      # Second tab content
      tabItem(
        tabName = "widgets",
        h2("Widgets tab content")
      ),
      # Third ?
      tabItem(
        tabName = "jim_widget",
        h2("Jim's widget"),
        p("The purpose is ..."),
        tags$li("item1"),
        tags$li("item2",
        fluidRow(
          box(
            title = "Future Project Description",
            background = "green"
          ),
        ),
        fluidRow(
          p("Begin discussion here")
        )
      )
    ) # end all tabItems
  ) # end dashboardbody
) # end dashboardPage


server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)] # seq_len(n) returns 1:n
    hist(data)
  })
}

# interactive, use:
if (F) shinyApp(ui, server)

# Autoreload, can run interactive()
options(shiny.autoreload = TRUE)
app <- shiny::shinyApp(ui, server)
shiny::runApp(app)

# 		/* vim: set filetype=r : */
