library(shiny)
options(shiny.autoreload = TRUE)

# Define UI with conditionalPanel
ui <- fluidPage(
  titlePanel("Random number generator"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "digit_type", "Number of digits:",
        c("any", "I_want_to_choose")
      ),
      conditionalPanel( # appears if condition is met
        condition = "input.digit_type == 'I_want_to_choose'",
        sliderInput("digit_count", "How many digits?",
          min = 1, max = 10, value = 4
        )
      ),
      actionButton("go", "Generate new random number"),
      width = 5
    ),
    mainPanel(
      br(),
      "Your random number is",
      h4(textOutput("random_number")),
      width = 7
    )
  )
)

# Define server logic that generates a random number based on user input
server <- function(input, output, session) {
  output$random_number <- renderText({
    input$go
    raw <- runif(1)
    digits <- if (input$digit_type == "any") {
      sample(1:10, size = 1)
    } else {
      input$digit_count
    }
    round(raw * 10^digits)
  })
}

shinyApp(ui = ui, server = server)
