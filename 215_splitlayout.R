#REF:  https://stackoverflow.com/questions/20637248/shiny-4-small-textinput-boxes-side-by-side/21132918#21132918

##  PURPOSE:  box, splitlayout,  attempt to introduce CSS
##  USAGE:  interactive
##  STATUS:  no errors, but does not work

library(shiny)
library(shinydashboard)

shinyApp(
includeCSS('test.css')                 # Check this !  
  ui  <- shiny::fluidRow(
    shinydashboard::box(width = 12, title = "A Box in a Fluid Row I want to Split", 
                        background="light-blue", # do not see it
        splitLayout(
          textInput("inputA", "The first input"),
          textInput("inputB", "The second input"),
          textInput("inputC", "The third input")
        )
    )
  )

  server  <- function(input, output    ){}
)

shinyApp(ui, server)

