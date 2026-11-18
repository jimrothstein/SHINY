## REF:  Chang, https://shiny.posit.co/r/articles/improve/modules/
## 311_reactive_OBSERVE.R

# id = part of namespace, set with call to UI function
# taglist = list, with no shiny layout
# ns = NS(id) returns function , ns
# ns("widget") combines both id and "widget"

library(shiny)
library(log4r)

logger <- create.logger(logfile = "debugging.log", level = "DEBUG")
log4r::info(logger, "begin")
counterButtonUI <- function(id, label = "Counter") {
  log4r::info(logger, "inside counterButtonUI")
  ns <- NS(id)
  tagList(
    actionButton(ns("button"), label = label),
    verbatimTextOutput(ns("out"))
  )
}

# id and function moduleServer passed to counterServer
counterServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      count <- reactiveVal(0) ## count is now reactive
      observeEvent(input$button, {   # waits for button push
        cat("button pushed", "\n")
        count(count() + 1)
      })
      output$out <- renderText({
        count()
      })
      count
    }
  )
}

ui <- fluidPage(
  counterButtonUI("counter1", "Counter #1")
)

server <- function(input, output, session) {
  counterServer("counter1")
}

# shinyApp(ui, server))


Counter_demo <- function() {
  ui <- counterButton("c1", label = "Counter #1")
  server <- function(input, output, session) {
    counterServer("c1")
  }

  shinyApp(ui, server)
}

# Counter_demo()
