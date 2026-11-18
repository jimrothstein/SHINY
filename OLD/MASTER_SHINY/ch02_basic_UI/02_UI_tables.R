# ---------------------------------------------------
#   /home/jim/code/SHINY/MASTER_SHINY/02_chapter_UI/02_UT_intro.R
#   INTERACTIVE ONLY:
#   PURPOSE:    ui:   table vs dataTable
#   USAGE:      Selectively choose sections to run.
# ---------------------------------------------------

library(shiny)

# 
# ---------------------------------------------------------------------------
ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic")
)


# ---------------------------------------------------------------------------
server <- function(input, output, session) {
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
# ---------------------------------------------------------------------------
}
shinyApp(ui, server)




