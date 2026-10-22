# ---------------------------------------------------
#   /home/jim/code/SHINY/MASTER_SHINY/02_chapter_UI/02_UT_intro.R
#   INTERACTIVE ONLY:
#   PURPOSE:    ui
#   USAGE:      Selectively choose sections to run.
# ---------------------------------------------------

library(shiny)

# 
ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("print")
)
server <- function(input, output, session) {
  output$text <- renderText("hello!")
  output$print <- renderPrint("hello!")   # like char []
}
shinyApp(ui, server)




