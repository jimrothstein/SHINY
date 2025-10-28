# ---------------------------------------------------
#   /home/jim/code/SHINY/MASTER_SHINY/02_chapter_UI/02_UT_intro.R
#   INTERACTIVE ONLY:
#   PURPOSE:    ui
#   USAGE:      Selectively choose sections to run.
#   TAGS:   radioButtons, textInput, passwordInput, textAreaInput(, numericInput(, sliderInput(, dateInput(, dateRangeInput, selectInput, icon
# ---------------------------------------------------

library(shiny)
#   CHOISE :   One (1)  of the follwing (for UI)
##
# --------------------------------- Text-----------------------------------
ui <- fluidPage(
    textInput("name", "What's your name?"),
    passwordInput("password", "What's your password?"),
    textAreaInput("story", "Tell me about yourself", rows = 3)
)


# --------------------------------- Slider-----------------------------------

ui <- fluidPage(
    numericInput("num", "Number one", value = 0, min = 0, max = 100),
    sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
    sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100)
)
# --------------------------------- DATES-----------------------------------
#
ui <- fluidPage(
    dateInput("dob", "When were you born?"),
    dateRangeInput("holiday", "When do you want to go on vacation next?")
)

# --------------------------------- Radio-----------------------------------
animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")


ui <- fluidPage(
    selectInput("state", "What's your favourite state?", state.name),
    radioButtons("animal", "What's your favourite animal?", animals)
)
# --------------------------------- Radio with Icons -----------------------------------
ui <- fluidPage(
    radioButtons("rb", "Choose one:",
        choiceNames = list(
            icon("angry"),
            icon("smile"),
            icon("sad-tear")
        ),
        choiceValues = list("angry", "happy", "sad")
    )
)
#> This Font Awesome icon ('angry') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can
#>   be deactivated with `verify_fa = FALSE`
#> This Font Awesome icon ('smile') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can
#>   be deactivated with `verify_fa = FALSE`
#> This Font Awesome icon ('sad-tear') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can
#>   be deactivated with `verify_fa = FALSE`
# --------------------------------- Multiple Select -----------------------------------
ui <- fluidPage(
    selectInput(
        "state", "What's your favourite state?", state.name,
        multiple = TRUE
    )
)
# --------------------------------- Checkbox -----------------------------------
ui <- fluidPage(
    checkboxInput("cleanup", "Clean up?", value = TRUE),
    checkboxInput("shutdown", "Shutdown?")
)
# --------------------------------- -----------------------------------




# ---------------------------------SERVER -----------------------------------

server <- function(input, output, session) {
}

shinyApp(ui, server)

#nnoremap <C-m> <leader>wwa<C-C><esc><leader>ww
#nnoremap <leader>z <leader>wwa





