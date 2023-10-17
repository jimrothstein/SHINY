# ---------------------------------------------------
#   /home/jim/code/SHINY/MASTER_SHINY/02_chapter_UI/02_UT_intro.R
#   INTERACTIVE ONLY:
#   PURPOSE:    ui:   buttons!
#   USAGE:      Selectively choose sections to run.
#   TAGS:   actionButton, textInput, placeholder, label, class, bootstrap 
# ---------------------------------------------------

#   CHOOSE 1, I/active ONLY
library(shiny)
# ---------------------------------UI -----------------------------------
library(shiny)
ui <- fluidPage(
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail"))
)
#> This Font Awesome icon ('cocktail') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can 
#>   be deactivated with `verify_fa = FALSE`


# ---------------------------------UI  + bootstrap-----------------------------------
ui <- fluidPage(
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionButton("drink", "Drink me!", class = "btn-lg btn-success")
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block"),
    textInput("short", label="short text input", placeholder="Your  name")
  )

)
# ---------------------------------SERVER -----------------------------------

server <- function(input, output, session) {
}

shinyApp(ui, server)





