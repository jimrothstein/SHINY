### sidebarLayout

library(shiny)
options(shiny.autoreload = TRUE)

# Define UI with default width sidebar
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      strong("Sidebar"),
      "Usually inputs go here, width = 4 by default"
    ),
    mainPanel(
      strong("Main panel"),
      tags$br(),
      tags$br(),
      "Usually outputs go here, width = 8 by default"
    )
  )
)

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)
