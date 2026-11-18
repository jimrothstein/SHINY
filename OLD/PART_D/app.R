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
source("mod_04_boxplot.R")
source("mod_10_display_drugs.R")
source("mod_20_display_conditions.R")

library(shinydashboard)
library(shiny)
## Sidebar content

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      shinydashboard::menuItem("Welcome", tabName = "welcome", icon = icon("dashboard")),
      menuItem("Display Decisions", tabName = "decisions", icon = icon("th")),
      menuItem("Boxplot", tabName = "boxplot", icon = icon("th")),
      menuItem("List of Drugs", tabName = "list_drugs", icon = icon("th")),
      menuItem("List of Conditions", tabName = "list_conditions", icon = icon("th")),
      new_menuItem("experiment", tName = "jim_widget")
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(
        tabName = "welcome",
        fluidRow(
          box(h2("Part D - Denials")),
        )
      ),
      # Second tab content/ Column to Display
      tabItem(
        tabName = "decisions",
        h2("Decisions tab content (very slow, ~ 60s)"),
        decisions_ui("decisions"),
      ),
      # Third: Boxplot of decisions
      tabItem(
        tabName = "boxplot",
        h2("boxplot"),
        boxplot_ui("boxplot"),
      ), # end tabItem
      tabItem(
        tabName = "list_drugs",
        p("List of Drugs ... soon or later"),
        drugs_ui("drugs"),
      ), # end tabItem
      tabItem(
        tabName = "list_conditions",
        conditions_ui("conditions"),
      ) # end tabItem
    ) # end all tabItems
  ) # end dashboardbody
) # end dashboardPage


server <- function(input, output) {
  decisions_server("decisions")
  boxplot_server("boxplot")
  drugs_server("drugs")
  conditions_server("conditions")
}


# required for interactive AND running from external R
shinyApp(ui, server)

# 		/* vim: set filetype=r : */
