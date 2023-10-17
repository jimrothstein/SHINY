# ---------------------------------------------------
#   /home/jim/code/SHINY/MASTER_SHINY/02_chapter_UI/02_UT_intro.R
#   INTERACTIVE ONLY:
#   PURPOSE:    ui:     Plots
#   USAGE:      Selectively choose sections to run.
# ---------------------------------------------------
#   TAGS:   plotOutput, renderPlot,

library(shiny)

# 
# ---------------------------------------------------------------------------
ui <- fluidPage(
  plotOutput("plot", width = "400px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}
# --------------------------------------------------------------------------

shinyApp(ui, server)




