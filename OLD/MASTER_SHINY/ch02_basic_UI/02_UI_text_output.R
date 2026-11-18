# ---------------------------------------------------
#   /home/jim/code/SHINY/MASTER_SHINY/02_chapter_UI/02_UT_intro.R
#   INTERACTIVE ONLY:
#   PURPOSE:    ui
#   USAGE:      Selectively choose sections to run.
# ---------------------------------------------------

#   CHOOSE 1, I/active ONLY
library(shiny)
# ---------------------------------UI -----------------------------------
library(shiny)

# ---------------------------------UI  + textOutput-----------------------------------
ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("code")
)

# ---------------------------------SERVER -----------------------------------
server <- function(input, output, session) {
  output$text <- renderText({ 
    "Hello friend!" 
  })

  output$code <- renderPrint({ 
    summary(1:10) 
  })
}


# 
ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("print")
)
server <- function(input, output, session) {
  output$text <- renderText("hello!")
  output$print <- renderPrint("hello!")
}
shinyApp(ui, server)





