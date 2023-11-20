##  file <- "01_reactive_console.R"
##  PURPOSE:    Run in console, not shiny in web app
##  USAGE:      interactive
##
##
library(shiny)
reactiveConsole(TRUE)

# make object x reactive
x <- reactiveVal(10)
y <- observe({
  message("The value of x is ", x())
})

x() # acts as get
x(20) # sets
x(30)

reactiveConsole(FALSE)
