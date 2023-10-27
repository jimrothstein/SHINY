## app.R ##
##  https://rstudio.github.io/shinydashboard/get_started.html
library(shinydashboard)
library(shiny)
## Sidebar content

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
        fluidRow(
          box(plotOutput("plot1", height = 250)),

          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      ),

      # Second tab content
      tabItem(tabName = "widgets",
        h2("Widgets tab content")
      ),
      # Third ?
      tabItem(tabName = "jim",
              h2("Jim's widget")
              )
      )                                # end all tabItems
  )
)


server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)] #seq_len(n) returns 1:n
    hist(data)
  })
}

shinyApp(ui, server)

#		/* vim: set filetype=r : */
