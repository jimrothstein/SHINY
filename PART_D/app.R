##  https://rstudio.github.io/shinydashboard/get_started.html

# TODO:
# - external functions for menuItem are working !
# interactive, use:
if (F) shinyApp(ui, server)

# Autoreload, can run interactive()
if (F) {
  options(shiny.autoreload = TRUE)
  app <- shiny::shinyApp(ui, server)
  shiny::runApp(app)
}

# TO RUN, separate R session (TODO: must open broswer to port)
if (F) {
  options(shiny.autoreload = TRUE)
  shiny::runApp()
}
new_menuItem <- function(label, tName = NULL) {
  menuItem(label, tabName = tName, icon = icon("th"))
}

tab_Item <- function(label, code) {
  tabItem(label, code)
}

source("mod_02_decisions.R")
source("mod_10_display_drugs.R")

library(shinydashboard)
library(shiny)
## Sidebar content

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      shinydashboard::menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Display Decisions", tabName = "decisions", icon = icon("th")),
      menuItem("Jim Widget", tabName = "jim_widget", icon = icon("th")),
      menuItem("List of Drugs", tabName = "list_drugs", icon = icon("th")),
      new_menuItem("experiment", tName = "jim_widget")
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

      # Second tab content/ Column to Display
      tabItem(
        tabName = "decisions",
        h2("Decisions tab content (very slow, ~ 60s)"),
        decisions_ui("decisions"),
      ),
      # Third ?
      tabItem(
        tabName = "jim_widget",
        h2("Jim's widget"),
        p("The purpose is ..."),
        tags$li("item1"),
        tags$li(
          "item2",
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
      ), # end tabItem

      tabItem(
        tabName = "list_drugs",
        p("List of Drugs ... soon or later"),
        drugs_ui("drugs"),
      ) # end tabItem
    ) # end all tabItems
  ) # end dashboardbody
) # end dashboardPage




server <- function(input, output) {
  decisions_server("decisions")
  drugs_server("drugs")

  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)] # seq_len(n) returns 1:n
    hist(data)
  })
}
# decisions_server("decisions")

# required for interactive AND running from external R
shinyApp(ui, server)

# 		/* vim: set filetype=r : */
